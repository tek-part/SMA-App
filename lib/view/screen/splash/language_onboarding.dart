import 'package:bandora_app/routes/routes.dart';
import 'package:bandora_app/utils/them.dart';
import 'package:bandora_app/view/widget/button_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controller/auth_controller.dart';
import '../../../logic/controller/language_controller.dart';
import '../../../logic/controller/setting_controller.dart';
import '../../../utils/my_strings.dart';

// ignore: must_be_immutable
class LanguageOnboarding extends StatelessWidget {
  LanguageOnboarding({super.key});

  LanguageController lanController = Get.put(LanguageController());
  SettingController controller = Get.put(SettingController());
  SignupController signup = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'اللغة'.tr,
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
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'إختر اللغة '.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: mainColor,
                fontSize: 20,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w500,
                height: 0,
                letterSpacing: -0.30,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonUtils(
                text: 'العربية',
                onPressed: () {
                  Get.offNamed(Routes.mainScreen);
                  lanController.getLanguage('ar');
                  controller.changeLanguage(ara);
                },
                colorstext: Colors.black,
                background: mainColor),
            const SizedBox(
              height: 20,
            ),
            ButtonUtils(
                text: 'English',
                onPressed: () {
                  Get.offNamed(Routes.mainScreen);
                  lanController.getLanguage('en');
                  controller.changeLanguage(ene);
                },
                colorstext: Colors.black,
                background: mainColor),
          ],
        )));
  }
}
