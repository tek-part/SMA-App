import 'package:bandora_app/view/widget/Auth/auth_button.dart';
import 'package:bandora_app/view/widget/Auth/auth_text_form_field.dart';
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../logic/controller/auth_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/them.dart';

// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  SignupController controller = Get.put(SignupController());
  static String phonenumber = '';
  final GetStorage authBox = GetStorage();

  @override
  Widget build(BuildContext context) {
    // // AuthControllerIMP  authControllerIMP = Get.put(AuthControllerIMP());
    // SignUpControllerImp authControllerIMP = Get.put(SignUpControllerImp());
    // signupController signupcontroller = Get.put(signupController());
    // TextEditingController phonecontroller = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'إنشاء حساب'.tr,
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
          leading: const Text(''),
          elevation: 0,
          centerTitle: true,
          backgroundColor: mainColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsetsDirectional.only(top: 68.h, start: 20.w, end: 20.w),
            child: SizedBox(
              width: double.infinity,
              height: 450.h,
              child: Form(
                key: controller.fromkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextUtils(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: GreyClr,
                        text: 'أدخل تفاصيل الحساب أدناه'.tr),
                    //User name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //first Name
                        SizedBox(
                          width: 160.w,
                          child: AuthTextFormField(
                              onsave: (v) {
                                controller.firstName.text = v!;
                              },
                              textInputType: TextInputType.name,
                              controller: controller.firstName,
                              obscureText: false,
                              validator: (value) {
                                if (value.toString().length <= 2) {
                                  return 'Enter Valid Name';
                                } else {
                                  return null;
                                }
                              },
                              hintText: 'الإسم الأول'.tr),
                        ),
                        //second name
                        SizedBox(
                          width: 160.w,
                          child: AuthTextFormField(
                              onsave: (v) {
                                controller.secondName.text = v!;
                              },
                              textInputType: TextInputType.name,
                              controller: controller.secondName,
                              obscureText: false,
                              validator: (value) {
                                if (value.toString().length <= 2) {
                                  return 'Enter Valid Name';
                                } else {
                                  return null;
                                }
                              },
                              hintText: 'إسم العائلة'.tr),
                        )
                      ],
                    ),

                    //phone number
                    SizedBox(
                      width: double.infinity,
                      // color: Colors.green,
                      child: Row(children: [
                        //الكود
                        Expanded(
                          child: Container(
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
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        //number
                        Expanded(
                          flex: 5,
                          child: AuthTextFormField(
                              onsave: (v) {
                                controller.phone.text = v!;
                              },
                              textInputType: TextInputType.phone,
                              controller: controller.phone,
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
                                // controller.signUp();
                                controller.signupBotton();
                                phonenumber = controller.phone.text;
                                controller.phonenumber.value = phonenumber;
                              },
                              colorstext: Colors.black,
                              background: mainColor),
                        );
                      },
                    ),

                    //او
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                            child: Divider(
                          color: Colors.black,
                        )),
                        Text(
                          ' أو '.tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Expanded(
                            child: Divider(
                          color: Colors.black,
                        )),
                      ],
                    ),
                    GetBuilder<SignupController>(
                      builder: (_) {
                        return Align(
                          alignment: AlignmentDirectional.center,
                          child: TextButton(
                              onPressed: () {
                                authBox.write('auth', false);
                                Get.offNamed(Routes.mainScreen);
                              },
                              child: TextUtils(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  text: 'متابعة كضيف'.tr)),
                        );
                      },
                    ),
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.signInScreen);
                          },
                          child: TextUtils(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              text: 'تسجيل الدخول'.tr)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
