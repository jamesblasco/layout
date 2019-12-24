import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final Function() onTap;

  const CustomCard({Key key, this.child, this.color, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
          child: Padding(child: child, padding: EdgeInsets.all(20)),
          onTap: onTap,
          borderRadius: BorderRadius.circular(12)),
      shadowColor: Colors.grey,
      elevation: 12,
    );
  }
}
