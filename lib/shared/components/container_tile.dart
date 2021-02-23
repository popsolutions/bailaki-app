import 'package:flutter/material.dart';

class ContainerTile extends StatelessWidget {
  final Widget child;

  const ContainerTile({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(
        253,
        255,
        253,
        1,
      ),
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
