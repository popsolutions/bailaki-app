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

  _ChatControllerBase(this._messageService, this._messageDao);

  set channelId(int channelId) => _channelId = channelId;
  set currentPartnerId(int currentPartnerId) => _currentPartnerId = currentPartnerId;

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
  ObservableFuture<List<DayMessage>> _messagesRequest = ObservableFuture.value(null);
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
    if(items.isEmpty){
      items.add(DayMessage(DateTime.now(), []));
    }
    items.last.messages.add(message);
    _messagesRequest = ObservableFuture.value(items);
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

/*
                      FlatButton(
                          onPressed: () async {
                            final odoo = Odoo();

                            /*
                            final channelService = ChannelServiceImpl(odoo);
                            channelService.findByPartner(ChannelRequestDto(
                                currentPartnerId: _authenticationController
                                    .currentUser.partnerId));
                                    */

//MATCHES QUERY
/*
                            final relationTypeResponse = await odoo
                                .searchRead('res.partner.relation.type', [
                              ['name', '=', 'Match']
                            ], [
                              'id',
                              'name'
                            ]);

                            final relationTypeId =
                                relationTypeResponse.getRecords()[0]["id"];

                            final res =
                                await odoo.searchRead('res.partner.relation', [
                              ['type_id', '=', 7],
                              '|',
                              [
                                'left_partner_id',
                                '=',
                                _authenticationController.currentUser.partnerId
                              ],
                              [
                                'right_partner_id',
                                '=',
                                _authenticationController.currentUser.partnerId
                              ]
                            ], []);
                            print(res);
                            */

                            /*
    final createRelationResponse = await odoo.create('res.partner.relation', {
      'left_partner_id': deslikeDto.currentUserPartnerId,
      'right_partner_id': deslikeDto.friendPartnerId,
      'type_id': relationTypeId,
    });
    */

                            //    final messages =
                            //      await odoo.searchRead('mail.message', [], []);

                            // print(messages);

                            /*
   'music_genre_ids': [
            [6, 0, music_genre_ids]
          ],
                      */


                            final channelres =
                                await odoo.create('mail.channel', {
                              'description': 'chat',
                              'name': 'test mitchel with test',
                              'email_send': false,
                              'channel_type': 'chat',
                              'public': 'private',
                              'channel_partner_ids': [
                                [4, 3, 0],
                                [4, 4, 0]
                              ]
                            });
                            print(channelres);
                            

                            final channels =
                                (await odoo.searchRead('mail.channel', [
                            //  ['id', '=', 15],
                              ['channel_partner_ids', 'in', 3]
                            ], []));
                            print(channels);

                            //  print(channelres.getResult());
/*
                            final messageres =
                                await odoo.create('mail.message', {
                              'author_id': _authenticationController
                                  .currentUser.partnerId,
                              'model': 'mail.channel',
                              'res_id': 15,
                              'type': 'comment',
                              'body': "testando novamente o chat",
                              'channel_ids': [
                                //      [4, channelres.getResult(), 0]
                                [4, 15, 0]
                              ]
                            });

                            print(messageres);
                            */
/*
                            final data = await odoo.searchRead('mail.message', [
                              ['res_id', '=', 15]
                            ], []);
                            print(data);
  */
                          },
                          child: Text("UÁAA")),
*/
