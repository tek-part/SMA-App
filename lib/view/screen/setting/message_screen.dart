import 'package:bandora_app/view/widget/button_utils.dart';
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controller/contact_controller.dart';
import '../../../utils/them.dart';
import '../../widget/profile/contact_text_from_field.dart';
import '../../widget/profile/message_text_form_field.dart';

// ignore: must_be_immutable
class MessageScreen extends StatelessWidget {
  MessageScreen({super.key});

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController messagecontroller = TextEditingController();
  ContactController controller = Get.put(ContactController());
  final fromkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'تواصل معنا'.tr,
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
          child: Form(
            key: fromkey,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //name
                  TextUtils(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      text: 'الإسم بالكامل'.tr),
                  const SizedBox(
                    height: 5,
                  ),
                  ContactTextFormField(
                      keyboardType: TextInputType.name,
                      controller: controller.name,
                      validator: (value) {
                        if (value.toString().length <= 2) {
                          return 'Enter Valid Name';
                        } else {
                          return null;
                        }
                      },
                      hintText: ''),

                  //message
                  TextUtils(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      text: ' رسالة'.tr),
                  const SizedBox(
                    height: 5,
                  ),
                  MessageTextFormField(
                    controller: controller.message,
                    validator: (value) {
                      if (value.toString().length <= 2) {
                        return 'Enter Valid Name';
                      } else {
                        return null;
                      }
                    },
                    hintText: 'أدخل رسالتك...'.tr,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GetBuilder<ContactController>(
                    builder: (controller) {
                      return Align(
                        alignment: Alignment.center,
                        child: ButtonUtils(
                            text: 'إرسال'.tr,
                            onPressed: () {
                              if (fromkey.currentState!.validate()) {
                                controller.sendMessage();
                                Navigator.of(context).pop();
                              }
                            },
                            colorstext: Colors.black,
                            background: mainColor),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
