import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../logic/controller/setting_controller.dart';
import '../../../utils/my_strings.dart';
import '../text_utils.dart';

// ignore: non_constant_identifier_names
Widget OrderContainerWidget({
  required String code,
  required String time,
  required String status,
  required Widget textt,
  required Color logoColor,
  required Color textColor,
  required Function() onTap,
  required Function() reloadTap,
}) {
  SettingController settingController = Get.put(SettingController());

  return Container(
    width: double.infinity,
    height: 116,
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1, color: Color(0xFFCED5E1)),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //first row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextUtils(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                text: '${'رقم الطلب '.tr} $code'),
            TextUtils(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                text: time)
          ],
        ),

        //second row
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //reload
            InkWell(
              onTap: reloadTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/reload.svg',
                    // ignore: deprecated_member_use
                    color: logoColor,
                  ),
                  TextUtils(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                      text: 'إعادة الطلب'.tr),
                ],
              ),
            ),

            //statues
            textt,
            //عرض المنتجات
            InkWell(
              onTap: onTap,
              child: Row(
                children: [
                  TextUtils(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      text: 'عرض المنتجات '.tr),
                  Icon(
                    settingController.langlocal == ara
                        ? Icons.arrow_back_ios_new
                        : Icons.arrow_forward_ios_outlined,
                    size: 18,
                  ),
                ],
              ),
            )
          ],
        )
      ],
    ),
  );
}
