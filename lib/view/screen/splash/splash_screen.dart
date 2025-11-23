import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controller/auth_controller.dart';
import '../../../logic/controller/language_controller.dart';
import '../../../logic/controller/setting_controller.dart';
import '../../../utils/my_strings.dart';
import '../../../utils/them.dart';
import '../Auth/signup_screen.dart';
import '../main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LanguageController lanController = Get.put(LanguageController());
  SettingController conntroller = Get.put(SettingController());
  SignupController controller = Get.find<SignupController>();

  @override
  void initState() {
    goToNextView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Container(
          width: 300,
          height: 300,
       
          child: Image.asset(
            'assets/images/sme_logo.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  void goToNextView() {
    Future.delayed(const Duration(seconds: 3), () {
      // controller.verificationCheck();
      if (controller.isAuth()) {
        conntroller.langlocal == ara
            ? conntroller.changeLanguage(ara)
            : conntroller.changeLanguage(ene);
        Get.off(() => MainScreen(), transition: Transition.fade);
      } else {
        lanController.getLanguage('ar');
        conntroller.changeLanguage(ara);
        Get.off(() => SignupScreen(), transition: Transition.fade);
      }
    });
  }
}
