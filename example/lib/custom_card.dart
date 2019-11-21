import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color color;

  const CustomCard({Key key, this.child, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: child,
      shadowColor: Colors.grey,
      elevation: 12,
    );
  }
}
