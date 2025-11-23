import 'package:bandora_app/utils/them.dart';
import 'package:flutter/cupertino.dart';

Widget radioWidget() {
  return Container(
    width: 20,
    height: 20,
    margin: const EdgeInsets.only(left: 20, right: 20),
    decoration: const ShapeDecoration(
      shape: OvalBorder(
        side: BorderSide(width: 2, color: mainColor),
      ),
    ),
    child: Container(
      margin: const EdgeInsets.all(2),
      width: 10,
      height: 10,
      decoration: const ShapeDecoration(
        color: mainColor,
        shape: OvalBorder(),
      ),
    ),
  );
}
