import 'package:bandora_app/utils/them.dart';
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';

Widget profilePhoto({
  required String char,
}) {
  return Container(
    width: 100,
    height: 100,
    padding: const EdgeInsets.all(5),
    decoration: const ShapeDecoration(
      shape: OvalBorder(
        side: BorderSide(width: 1, color: mainColor),
      ),
    ),
    child: Container(
      width: 90,
      height: 90,
      decoration: const ShapeDecoration(
        color: mainColor,
        shape: OvalBorder(),
      ),
      child: Center(
          child: TextUtils(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              text: char)),
    ),
  );
}
