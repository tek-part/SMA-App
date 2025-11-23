// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../logic/controller/auth_controller.dart';
import '../../../utils/them.dart';
import '../../widget/Auth/pin_put_widget.dart';
import '../../widget/Auth/timer_widget.dart';

// ignore: must_be_immutable
class VerificationScreen extends StatelessWidget {
  VerificationScreen({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);
  final String phoneNumber;
  SignupController controller = SignupController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'إنشاء حساب',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
            height: 0,
            letterSpacing: -0.30,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: 340.h,
          child: Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 50.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextUtils(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: GreyClr,
                    text: 'تم إرسال رمز إلي  $phoneNumber'.tr),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: PinPutWidget(
                        phone: phoneNumber,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                const TimerWIdget(),
                TextUtils(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    text: 'لم تحصل علي الرمز؟'.tr),
                InkWell(
                  onTap: () {
                    controller.resendCode(phoneNumber);
                  },
                  child: TextUtils(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: mainColor,
                      text: 'أعد إرسال الرمز'.tr),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
