
import 'package:flutter/material.dart';

class CircularInkWell extends StatelessWidget {
  final Widget child;
  final Color color;
  final VoidCallback onTap;
  final double radius;

  const CircularInkWell({
    Key key,
    this.color,
    this.onTap,
    this.child,
    this.radius = 70,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      child: Material(
        borderRadius: BorderRadius.circular(200),
        color: color,
        child: InkWell(
          borderRadius: BorderRadius.circular(200),
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
