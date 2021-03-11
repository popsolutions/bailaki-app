import 'package:flutter/material.dart';

class MessageGroup extends StatelessWidget {
  final Widget messages;
  final String date;

  const MessageGroup({
    Key key,
    @required this.date,
    @required this.messages,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [Text(date), const SizedBox(height: 12), messages],
      ),
    );
  }
}
