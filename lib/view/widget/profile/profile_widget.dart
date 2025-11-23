import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../text_utils.dart';

Widget profileWidget({
  required String icon,
  required String text,
  required Color textColor,
}) {
  return Row(
    children: [
      SvgPicture.asset(
        icon,
        fit: BoxFit.fill,
        height: 22,
        width: 22,
      ),
      const SizedBox(
        width: 8,
      ),
      TextUtils(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor,
          text: text),
    ],
  );
}
