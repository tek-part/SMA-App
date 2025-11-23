import 'package:flutter/material.dart';

import '../../../utils/them.dart';
import '../text_utils.dart';

// ignore: non_constant_identifier_names
Widget ConnectUSContainer({
  required String image,
  required String text,
}) {
  return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.50, color: Color(0xFFCED5E1)),
          borderRadius: BorderRadius.circular(8),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 4,
            offset: Offset(0, 2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(image),
              const SizedBox(
                width: 16,
              ),
              TextUtils(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  text: text),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: GreyClr,
            size: 20,
          ),
        ],
      ));
}
