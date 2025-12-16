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
                  'أنشئ حسابك'.tr,
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
                  'املأ التفاصيل أدناه للبدء'.tr,
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

                // Form Section
                Form(
                  key: controller.fromkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name Fields
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // First Name
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'الإسم الأول'.tr,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Container(
                                  height: 56.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16.sp,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    controller: controller.firstName,
                                    keyboardType: TextInputType.name,
                                    validator: (value) {
                                      if (value.toString().length <= 2) {
                                        return 'Enter Valid Name';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (v) {
                                      controller.firstName.text = v!;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 0),
                                      hintText: 'الإسم الأول'.tr,
                                      hintStyle: TextStyle(
                                        color: GreyClr.withOpacity(0.6),
                                        fontSize: 16.sp,
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.w400,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: GreyClr.withOpacity(0.3),
                                          width: 1.5,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: mainColor,
                                          width: 2,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 1.5,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12.w),
                          // Last Name
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'إسم العائلة'.tr,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Container(
                                  height: 56.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16.sp,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    controller: controller.secondName,
                                    keyboardType: TextInputType.name,
                                    validator: (value) {
                                      if (value.toString().length <= 2) {
                                        return 'Enter Valid Name';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (v) {
                                      controller.secondName.text = v!;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 0),
                                      hintText: 'إسم العائلة'.tr,
                                      hintStyle: TextStyle(
                                        color: GreyClr.withOpacity(0.6),
                                        fontSize: 16.sp,
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.w400,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: GreyClr.withOpacity(0.3),
                                          width: 1.5,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: mainColor,
                                          width: 2,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 1.5,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // Phone Number Section
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
                                  controller: controller.phone,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    return controller
                                        .validatePhone(value ?? '');
                                  },
                                  onSaved: (v) {
                                    controller.phone.text = v!;
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
                                    controller.signupBotton();
                                    phonenumber = controller.phone.text;
                                    controller.phonenumber.value = phonenumber;
                                  }
                                },
                                borderRadius: BorderRadius.circular(16.r),
                                child: Center(
                                  child: Text(
                                    'التالي'.tr,
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

                      // Divider
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              color: GreyClr.withOpacity(0.3),
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              'أو'.tr,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w500,
                                color: GreyClr,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: GreyClr.withOpacity(0.3),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // Continue as Guest
                      GetBuilder<SignupController>(
                        builder: (_) {
                          return Center(
                            child: TextButton(
                              onPressed: () {
                                authBox.write('auth', false);
                                Get.offNamed(Routes.mainScreen);
                              },
                              child: Text(
                                'متابعة كضيف'.tr,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 16.h),

                      // Sign in link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'لديك حساب بالفعل؟'.tr,
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
                              Get.toNamed(Routes.signInScreen);
                            },
                            child: Text(
                              'تسجيل الدخول'.tr,
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
