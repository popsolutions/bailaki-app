import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessageTile extends StatelessWidget {
  final EdgeInsets padding;
  final VoidCallback onTap;
  final String message;
  final bool sender;

  const MessageTile(
      {Key key, this.padding, this.onTap, this.sender, this.message})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        mainAxisAlignment:
            sender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!sender)
            CircleAvatar(
              radius: 30,
              //backgroundColor: Colors.blue,
              backgroundImage: NetworkImage(
                  "https://static.billboard.com/files/2021/01/rihanna-sept-2019-billboard-1548-1611156420-compressed.jpg"),
            ),
          const SizedBox(width: 20),
          Flexible(
              child: GestureDetector(
            onLongPress: () {
              Clipboard.setData(ClipboardData(text: message));
            },
            child: Container(
              decoration: BoxDecoration(
                color: sender ? Colors.blue : Colors.grey[400],
                borderRadius: sender
                    ? BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(8),
                        topRight: Radius.circular(35))
                    : BorderRadius.only(
                        topLeft: Radius.circular(35),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(30),
                        topRight: Radius.circular(30)),
              ),
              padding: const EdgeInsets.only(
                  left: 18, right: 14, top: 14, bottom: 14),
              child: SelectableText(
                message,
                textAlign: TextAlign.start,
                style: TextStyle(color: sender ? Colors.white : Colors.black),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
