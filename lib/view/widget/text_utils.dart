import 'package:flutter/material.dart';

class TextUtils extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const TextUtils(
      {super.key,
      required this.fontSize,
      required this.fontWeight,
      required this.color,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          letterSpacing: -0.30,
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: 'Cairo',
          overflow: TextOverflow.ellipsis),
    );
  }
}
