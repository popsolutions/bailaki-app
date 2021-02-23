import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final ShapeBorder shape;
  final EdgeInsets padding;
  final Color color;
  final String title;
  final TextStyle titleStyle;
  final EdgeInsets containerPadding;

  const PrimaryButton(
      {Key key,
      this.onTap,
      this.color = const Color.fromRGBO(254, 0, 236, 1),
      this.padding = const EdgeInsets.all(12),
      this.shape = const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      this.title,
      this.titleStyle = const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: "Montserrat",
        color: Color.fromRGBO(2, 255, 235, 1),
      ),
      this.containerPadding = const EdgeInsets.symmetric(vertical: 16.0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: containerPadding,
      child: RaisedButton(
        shape: shape,
        onPressed: onTap,
        padding: padding,
        color: color,
        child: Text(
          title,
          style: titleStyle,
        ),
      ),
    );
  }
}
