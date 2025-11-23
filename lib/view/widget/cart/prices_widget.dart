import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../text_utils.dart';

// ignore: non_constant_identifier_names
Widget PricesWidget({
  required String text,
  required String price,
  required Color textColor,
  required Color priceColor,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      TextUtils(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textColor,
          text: text),
      TextUtils(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: priceColor,
          text: price),
    ],
  );
}
