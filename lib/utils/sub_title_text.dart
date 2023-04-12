import 'package:flutter/material.dart';

class SubTitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  const SubTitleText(
      {Key key,
      this.text,
      this.fontSize = 16,
      this.color = Colors.black,
      this.fontWeight = FontWeight.w500
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontSize: fontSize, fontWeight: fontWeight, color: color));
  }
}