import 'package:flutter/material.dart';

class ContainerTile extends StatelessWidget {
  final Widget child;

  const ContainerTile({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(.5),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 7,
        bottom: 7,
      ),
      child: child,
    );
  }
}
