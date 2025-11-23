import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controller/edit_profile_controller.dart';
import '../../../utils/them.dart';
import '../../widget/Auth/auth_button.dart';
import '../../widget/Auth/auth_text_form_field.dart';
import '../../widget/text_utils.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  EditProfileController controller = Get.put(EditProfileController());

  final fromkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'تعديل الملف الشخصي '.tr,
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
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsetsDirectional.only(top: 20, start: 20, end: 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 4,
              child: Form(
                key: fromkey,
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
                          width: MediaQuery.of(context).size.width / 2.3,
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
                          width: MediaQuery.of(context).size.width / 2.3,
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

                    //auth button
                    GetBuilder<EditProfileController>(
                      builder: (_) {
                        return AuthButton(
                            text: 'حفظ'.tr,
                            onPressed: () {
                              if (fromkey.currentState!.validate()) {
                                controller.editProfile(context);
                              }
                            },
                            colorstext: Colors.black,
                            background: mainColor);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
