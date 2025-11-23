import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../profile/radio.dart';
import '../text_utils.dart';

// ignore: non_constant_identifier_names
Widget PayMentMetohodWidget() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          SvgPicture.asset(
            'assets/images/uil_wallet.svg',
            fit: BoxFit.fill,
            height: 22,
            width: 22,
          ),
          const SizedBox(
            width: 8,
          ),
          TextUtils(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              text: 'الدفع عند الاستلام'.tr),
        ],
      ),
      radioWidget(),
    ],
  );
}
