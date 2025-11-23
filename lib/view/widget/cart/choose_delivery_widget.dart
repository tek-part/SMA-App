// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/them.dart';
import '../text_utils.dart';

class ChooseDeliveryWidget extends StatelessWidget {
  const ChooseDeliveryWidget({
    Key? key,
    required this.text1,
    required this.text2,
    required this.immage,
  }) : super(key: key);
  final String text1;
  final String text2;
  final SvgPicture immage;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        immage,
        const SizedBox(
          width: 10,
        ),
        TextUtils(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: GreyClr,
            text: text1),
        const Spacer(),
        TextUtils(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            text: text2)
      ],
    );
  }
}
