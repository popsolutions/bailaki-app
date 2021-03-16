import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final EdgeInsets padding;
  final VoidCallback onTap;
  final String name;
  final String description;
 

  const ChatTile({Key key, this.padding,this.onTap, this.name, this.description}) : super(key: key);
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
              backgroundImage: NetworkImage("https://static.billboard.com/files/2021/01/rihanna-sept-2019-billboard-1548-1611156420-compressed.jpg"),
            ),
            const SizedBox(width: 20),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   name,
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
                      Text(
                        description,
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
