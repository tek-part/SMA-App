import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../logic/controller/auth_controller.dart';
import '../../../utils/them.dart';
import '../../widget/Auth/auth_button.dart';
import '../../widget/Auth/auth_text_form_field.dart';
import '../../widget/text_utils.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تسجيل الدخول'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
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
        child: Padding(
          padding:
              EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
          child: SizedBox(
            width: double.infinity,
            height: 200.h,
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextUtils(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: GreyClr,
                      text: 'أدخل تفاصيل الحساب أدناه'.tr),

                  //phone number
                  SizedBox(
                    width: double.infinity,
                    // color: Colors.green,
                    child: Row(children: [
                      //الكود
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.h, vertical: 10.h),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: GreyClr,
                            ),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4.r),
                                bottomRight: Radius.circular(4.r)),
                          ),
                        ),
                        child: Center(
                            child: TextUtils(
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                text: '+964')),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      //number
                      Expanded(
                        flex: 5,
                        child: AuthTextFormField(
                            onsave: (v) {
                              controller.loginPhone.text = v!;
                            },
                            textInputType: TextInputType.phone,
                            controller: controller.loginPhone,
                            obscureText: false,
                            validator: (value) {
                              controller.validatePhone(value);
                            },
                            hintText: '7XX XXX XXXX'.tr),
                      )
                    ]),
                  ),
                  //auth button
                  GetBuilder<SignupController>(
                    builder: (_) {
                      return Align(
                        alignment: AlignmentDirectional.center,
                        child: AuthButton(
                            text: 'التالي'.tr,
                            onPressed: () {
                              controller.logIn();
                            },
                            colorstext: Colors.black,
                            background: mainColor),
                      );
                    },
                  ),

                  //او
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: const [
                  //     Expanded(
                  //         child: Divider(
                  //       color: Colors.black,
                  //     )),
                  //     Text(
                  //       ' أو ',
                  //       textAlign: TextAlign.center,
                  //       style: TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 14,
                  //         fontFamily: 'Tajawal',
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //     Expanded(
                  //         child: Divider(
                  //       color: Colors.black,
                  //     )),
                  //   ],
                  // ),
                  // Align(
                  //   alignment: AlignmentDirectional.center,
                  //   child: TextButton(
                  //       onPressed: () {
                  //         Get.offNamed(Routes.MainScreen);
                  //       },
                  //       child:  TextUtils(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w500,
                  //           color: mainColor,
                  //           text: 'متابعة كضيف'.tr)),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
