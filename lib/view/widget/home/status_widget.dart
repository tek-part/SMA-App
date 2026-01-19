import 'package:bandora_app/utils/my_strings.dart';
import 'package:bandora_app/utils/them.dart';
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../../logic/controller/setting_controller.dart';
import '../../../logic/controller/status_cotroller.dart';

// ignore: must_be_immutable
class StatusWidget extends StatelessWidget {
  StatusWidget({super.key, required this.remaining});

  // StatusContrller contrller = Get.put(StatusContrller());
  SettingController controller = Get.put(SettingController());
  StatusContrller statusContrller = Get.put(StatusContrller());

  final int remaining;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1,
      height: MediaQuery.of(context).size.height / 3.8,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        shadows: const [
          BoxShadow(
            color: Color(0x4CCBCCCD),
            blurRadius: 8,
            offset: Offset(1.50, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        children: [
          //image
          SvgPicture.asset('assets/images/close.svg'),
          SizedBox(
            width: MediaQuery.of(context).size.width / 10,
          ),
          //details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextUtils(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  text: 'مراكز التسوق مغلقة'.tr),
              TextUtils(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: GreyClr,
                  text: 'يفتح فى خلال'.tr),
              SlideCountdownSeparated(
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
             
                decoration: const BoxDecoration(
                    color: Color(0xFFF1F3FB),
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                duration: Duration(seconds: remaining),
                separatorType: SeparatorType.symbol,
                separatorPadding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 35),
                shouldShowDays: (p0) {
                  return false;
                },
                showZeroValue: true,
                onDone: () {
                  statusContrller.getStatus();
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.18,
                // ignore: unrelated_type_equality_checks
                child: controller.getLanguage == ara
                    ? Row(
                        textDirection: TextDirection.ltr,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextUtils(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              text: 'ثانية'.tr),
                          TextUtils(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              text: 'دقيقة'.tr),
                          TextUtils(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              text: 'ساعة'.tr),
                        ],
                      )
                    : Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextUtils(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              text: 'ثانية'.tr),
                          TextUtils(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              text: 'دقيقة'.tr),
                          TextUtils(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              text: 'ساعة'.tr),
                        ],
                      ),
              )
            ],
          )
        ],
      ),
    );
  }
}
