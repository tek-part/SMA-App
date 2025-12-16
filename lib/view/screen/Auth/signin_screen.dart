import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../logic/controller/auth_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/them.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 24.w, vertical: 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // App Logo
                SizedBox(height: 20.h),
                Image.asset(
                  'assets/images/sme_logo.png',
                  width: 120.w,
                  height: 120.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 32.h),

                // Header Section
                Text(
                  'مرحباً بك'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'سجل دخولك للاستمرار'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w400,
                    color: GreyClr,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 48.h),

                // Phone Number Section
                Form(
                  key: controller.fromkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'رقم الهاتف'.tr,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      //phone number - Improved Design
                      Container(
                        height: 56.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: GreyClr.withOpacity(0.3),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            //الكود - Country Code
                            Container(
                              width: 90.w,
                              height: 56.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12.r),
                                  bottomRight: Radius.circular(12.r),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '+964',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                            // Divider
                            Container(
                              width: 1,
                              height: 32.h,
                              color: GreyClr.withOpacity(0.2),
                            ),
                            //number - Phone Number Field
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: TextFormField(
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16.sp,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  controller: controller.loginPhone,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    return controller
                                        .validatePhone(value ?? '');
                                  },
                                  onSaved: (v) {
                                    controller.loginPhone.text = v!;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true,
                                    hintText: '7XX XXX XXXX'.tr,
                                    hintStyle: TextStyle(
                                      color: GreyClr.withOpacity(0.6),
                                      fontSize: 16.sp,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.h),

                      //auth button
                      GetBuilder<SignupController>(
                        builder: (_) {
                          return Container(
                            width: double.infinity,
                            height: 56.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [mainColor, mainColor.withOpacity(0.8)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [
                                BoxShadow(
                                  color: mainColor.withOpacity(0.3),
                                  blurRadius: 16,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  if (controller.fromkey.currentState!
                                      .validate()) {
                                    controller.logIn();
                                  }
                                },
                                borderRadius: BorderRadius.circular(16.r),
                                child: Center(
                                  child: Text(
                                    'تسجيل الدخول'.tr,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18.sp,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 24.h),

                      // Sign up link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ليس لديك حساب؟'.tr,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w400,
                              color: GreyClr,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.signupScreen);
                            },
                            child: Text(
                              'سجل الآن'.tr,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                color: mainColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
