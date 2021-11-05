import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/models/message.dart';
import 'package:odoo_client/app/data/models/search_message_request_dto.dart';
import 'package:odoo_client/app/data/models/send_message_request_dto.dart';
import 'package:odoo_client/app/data/services/message_dao.dart';
import 'package:odoo_client/app/data/services/message_service.dart';

part 'chat_controller.g.dart';

class ChatController = _ChatControllerBase with _$ChatController;

abstract class _ChatControllerBase with Store {
  final MessageService _messageService;
  final MessageDao _messageDao;
  int _channelId;
  int _currentPartnerId;
  int _lastReadMessageId = 0;
  bool searchingNewMessages = false;

  _ChatControllerBase(this._messageService, this._messageDao);

  set channelId(int channelId) => _channelId = channelId;
  set currentPartnerId(int currentPartnerId) =>
      _currentPartnerId = currentPartnerId;

  setlastReadMessageId() async {
    final items = await _messagesRequest.value;

    if (items == null) {
      _lastReadMessageId = 0;
      return;
    }

    if (items.length > 0) {
      if (items.last.messages.length > 0) {
        for (int i = items.length - 1; i >= 0; i--) {
          for (int j = items[i].messages.length - 1; j >= 0; j--) {
            Message message = items[i].messages[j];

            if (message.fromServer) {
              _lastReadMessageId = message.id;
              return;
            }
          }
        }
      }
    }
  }

  @observable
  String _message = '';
  set message(String message) {
    _message = message.trim();
    _messageDao.saveOrReplace(_channelId.toString(), message);
  }

  @computed
  bool get isEmptyMessage => _message.isEmpty;

  @observable
  ObservableFuture _sendMessageRequest = ObservableFuture.value(null);
  ObservableFuture get sendMessageRequest => _sendMessageRequest;

  @observable
  ObservableFuture<List<DayMessage>> _messagesRequest =
      ObservableFuture.value(null);
  ObservableFuture<List<DayMessage>> get messagesRequest => _messagesRequest;

  @action
  void load() {
    _messagesRequest = _messageService
        .findByChannel(SearchMessageRequestDto(channelId: _channelId))
        .asObservable();
  }

  @action
  void addMessage(Message message) {
    final items = _messagesRequest.value;
    print(items);
    if (items.isEmpty) {
      items.add(DayMessage(DateTime.now(), []));
    }
    items.last.messages.add(message);
    _messagesRequest = ObservableFuture.value(items);
  }

  @action
  void searchNewMessages() async {
    if (searchingNewMessages) return;

    try {
      searchingNewMessages = true;

      if (_lastReadMessageId == 0)
        await setlastReadMessageId(); //t.todo verificar se é possível colocar este procedimenhto após o load().

      List<DayMessage> listDayMessage = await _messageService.findByChannel(
          SearchMessageRequestDto(
              channelId: _channelId,
              lastIdReceived: _lastReadMessageId,
              author_idNot: _currentPartnerId));

      await listDayMessage.forEach((elementDayMessage) async {
        await elementDayMessage.messages.forEach((elementMessage) async {
          addMessage(
            Message(
              id: elementMessage.id,
              authorId: elementMessage.authorId,
              body: elementMessage.body,
              channelId: _channelId,
              date: elementMessage.date,
            ),
          );

          _lastReadMessageId = elementMessage.id;
        });
      });
    } finally {
      searchingNewMessages = false;
    }
  }

  @action
  void send() {
    final messageDto = SendMessageRequestDto(
      channelId: _channelId,
      currentPartnerId: _currentPartnerId,
      message: _message,
    );
    _sendMessageRequest =
        _messageService.sendMessage(messageDto).asObservable();
    addMessage(
      Message(
        authorId: _currentPartnerId,
        body: _message,
        channelId: _channelId,
        date: DateTime.now(),
      ),
    );
  }
}
