import 'package:flutter/material.dart';
import 'package:odoo_client/app/pages/match/components/message_group.dart';
import 'package:odoo_client/app/pages/match/components/message_tile.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key key}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: Focus.of(context).unfocus,
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
              CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(
                    "https://static.billboard.com/files/2021/01/rihanna-sept-2019-billboard-1548-1611156420-compressed.jpg"),
              ),
              const SizedBox(width: 10),
              Text(
                "Nicole",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[100],
        ),
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            ListView.separated(
              separatorBuilder: (_, index) => const SizedBox(height: 25),
              padding: const EdgeInsets.only(top: 25, bottom: 80),
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return MessageGroup(
                  date: "domingo 23:17",
                  messages: ListView.builder(
                      padding: const EdgeInsets.only(top: 15),
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (_, index) {
                        return MessageTile(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          sender: index % 2 == 0,
                          onTap: () {},
                          message: index.isEven
                              ? "olá a a e e a e au e  a e s"
                              : "aaaaaaaaaaaaaaaaa aaaaaa a oooo",
                        );
                      },
                      itemCount: 7),
                );
              },
              itemCount: 3,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.white,
                height: 60,
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
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
                            )),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.send,
                      color: Colors.grey[400],
                    ),
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
