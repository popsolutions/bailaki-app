import 'dart:typed_data';

import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final EdgeInsets padding;
  final VoidCallback onTap;
  final String name;
  final String description;
  final Uint8List imageBytes;
  final int amount_newmessages;
  const ChatTile(
      {Key key,
      this.padding,
      this.onTap,
      this.name,
      this.description,
      this.imageBytes,
      this.amount_newmessages})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding,
        child: Row(
          children: [
            CircleAvatar(
              radius: 50,
              //backgroundColor: Colors.blue,
              backgroundImage:
                  imageBytes != null ? MemoryImage(imageBytes) : null,
            ),
            const SizedBox(width: 20),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 23,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.subdirectory_arrow_left_sharp,
                        color: Colors.grey[800],
                        size: 15,
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          description,
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (amount_newmessages > 0)
                    Text(
                      amount_newmessages.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
