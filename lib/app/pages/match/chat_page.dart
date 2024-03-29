import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/models/channel.dart';
import 'package:odoo_client/app/data/models/like_dto.dart';
import 'package:odoo_client/app/data/services/login_facade_impl.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';
import 'package:odoo_client/app/data/services/relation_service_impl.dart';
import 'package:odoo_client/app/pages/home/select_partner_controller.dart';
import 'package:odoo_client/app/pages/match/chat_controller.dart';
import 'package:odoo_client/app/pages/match/components/message_group.dart';
import 'package:odoo_client/app/pages/match/components/message_tile.dart';
import 'package:odoo_client/main.dart';
import 'package:odoo_client/shared/components/dialogs.dart';
import 'package:odoo_client/shared/controllers/authentication_controller.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key key}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Channel _channel;
  PartnerChannel _inversePartner;
  ChatController _chatController;
  AuthenticationController _authenticationController;
  TextEditingController _messageEditingController;
  ReactionDisposer _sendMessageReaction;
  UserProfile _user;
  Timer timer;
  ScrollController _scrollController = ScrollController();
  bool _shouldAutoscroll = false;

  @override
  void initState() {
    super.initState();
    _authenticationController = GetIt.I.get<AuthenticationController>();
    _chatController = GetIt.I.get<ChatController>();
    _messageEditingController = TextEditingController();
    _sendMessageReaction =
        reaction((_) => _chatController.sendMessageRequest.status, _onMessage);
    appLifecycleState = AppLifecycleState.resumed;

    _scrollController.addListener(_scrollListener);
    timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      searchNewMessages();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_channel == null) {
      _channel = ModalRoute.of(context).settings.arguments;

      _chatController.channelId = _channel.channelId;
      _user = _authenticationController.currentUser;
      _inversePartner = _channel.inverseChatter(_user.partnerId);
      _chatController.currentPartnerId = _user.partnerId;
      _chatController.load();
    }
  }

  @override
  void dispose() {
    _sendMessageReaction();
    _messageEditingController.dispose();
    _scrollController.removeListener(_scrollListener);
    timer.cancel();
    super.dispose();
  }

  void _onMessage(FutureStatus requestStatus) {
    switch (requestStatus) {
      case FutureStatus.fulfilled:
        _clearMessage();
        break;
      case FutureStatus.rejected:
        break;
      default:
    }
  }

  void _clearMessage() {
    _chatController.message = '';
    _messageEditingController.clear();
  }

  searchNewMessages() async {
    if (appLifecycleState == AppLifecycleState.resumed) {
      _chatController.searchNewMessages();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients && _shouldAutoscroll) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 500),
          );
        }
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.hasClients &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      _shouldAutoscroll = true;
    } else {
      _shouldAutoscroll = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          leading: Navigator.canPop(context)
              ? BackButton(
                  color: Colors.black,
                )
              : null,
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/partner_detail',
                    arguments: _inversePartner.id,
                  );
                },
                child: CircleAvatar(
                  radius: 22,
                  backgroundImage: _inversePartner?.photo?.bytes != null
                      ? MemoryImage(_inversePartner?.photo?.bytes)
                      : null,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${_channel.inverseChatter(_user.partnerId).name}',
                style: const TextStyle(color: Colors.black),
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                ),
                onPressed: () async {
                  final relation = RelationServiceImpl(GetIt.I.get<Odoo>());
                  await inputQuestionThrow(context, 'Confirmação', 'Deseja realmente excluir este Match?');
                  await relation.unmatch(
                    LikeDto(_channel.rightPartnerId, _channel.leftPartnerId),
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[100],
        ),
        body: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            Observer(builder: (_) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _scrollController
                    .jumpTo(_scrollController.position.maxScrollExtent);
              });

              final response = _chatController.messagesRequest;
              final items = response.value;
              switch (response.status) {
                case FutureStatus.rejected:
                  return Center(
                    child: Text("erro"),
                  );
                  break;

                case FutureStatus.pending:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
                default:
                  return ListView.separated(
                    controller: _scrollController,
                    separatorBuilder: (_, index) => const SizedBox(height: 25),
                    padding: const EdgeInsets.only(top: 25, bottom: 80),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      final item = items[index];
                      final messages = item.messages;
                      return MessageGroup(
                        date: "${DateFormat.yMMMMd().format(item.date)}",
                        messages: ListView.builder(
                            padding: const EdgeInsets.only(top: 15),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemBuilder: (_, index) {
                              final message = messages[index];
                              return MessageTile(
                                // imageBytes: _inversePartner?.photo?.bytes,
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 5),
                                sender: message.authorId == _user.partnerId,
                                onTap: () {},
                                message: message.body,
                              );
                            },
                            itemCount: messages.length),
                      );
                    },
                    itemCount: items.length,
                  );
              }
            }),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLines: null,
                        controller: _messageEditingController,
                        onChanged: (e) {
                          _chatController.message = e;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 15, right: 15, top: 10, bottom: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Colors.grey[300],
                          hintText: "Digite uma mensagem...",
                          hintStyle: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Observer(builder: (_) {
                      return IconButton(
                          icon: Icon(
                            Icons.send,
                            color: _chatController.isEmptyMessage
                                ? Colors.grey[400]
                                : Colors.blue,
                          ),
                          onPressed: () {
                            if (!_chatController.isEmptyMessage) {
                              _chatController.send();
                            }
                          });
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
