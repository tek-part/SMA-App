import 'dart:convert';
import 'package:bandora_app/core/helpers/shared_pref_helper.dart';
import 'package:bandora_app/core/networking/di/dependency_injection.dart';
import 'package:bandora_app/utils/them.dart';
import 'package:bandora_app/view/screen/Auth/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:bandora_app/routes/routes.dart';

import '../../core/networking/constants/api_constants.dart';
import '../../utils/my_strings.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/notification_services/device_token.dart';

class SignupController extends GetxController {
  final fromkey = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController secondName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController loginPhone = TextEditingController();
  TextEditingController verification = TextEditingController();
  String code = '';
  var token = '';
  var phonenumber = ''.obs;
  var isSignIn = false;
  final GetStorage authBox = GetStorage();

  final storage = const FlutterSecureStorage();

  @override
  void onInit() {
    firstName = TextEditingController();
    secondName = TextEditingController();
    phone = TextEditingController();
    verification = TextEditingController();
    loginPhone = TextEditingController();
    code;
    authData();

    super.onInit();
  }

  @override
  void dispose() {
    firstName.dispose();
    secondName.dispose();
    phone.dispose();
    verification.dispose();
    loginPhone.dispose();
    super.dispose();
  }

  signUp() async {
    // الحصول على FCM token
    final fcmToken = await DeviceToken.getDeviceToken();
    print("kareem$fcmToken");
    var request = http.MultipartRequest(
        'POST', Uri.parse('$baseUrl/Auth-Phone/register'));

    request.fields.addAll({
      'first_name': firstName.text,
      'last_name': secondName.text,
      'phone': '964${phone.text}',
      'fcm_token': fcmToken ?? '',
    });

    http.StreamedResponse response = await request.send();

    try {
      if (response.statusCode == 200) {
        await response.stream.bytesToString();
        // print(await response.stream.bytesToString());
      } else {
        response.reasonPhrase == 'Accepted'
            ? const Text('')
            : Get.snackbar("من فضلك تأكد من رقم الهاتف".tr, '',
                duration: const Duration(seconds: 1),
                backgroundColor: recGreyClr,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM);
      }
      // ignore: empty_catches
    } catch (e) {}
    update();
  }

  //valid

  String? validateName(String value) {
    if (value.toString().length <= 2) {
      return 'Enter Valid Name';
    } else {
      return null;
    }
  }

  String? validatePhone(String value) {
    if (value.length <= 5) {
      return 'this is Wrong phone';
    } else {
      return null;
    }
  }

//button
  signupBotton() async {
    if (fromkey.currentState!.validate() && phone.text.length == 10) {
      try {
        var data = signUp();
        if (data != null) {
          // await storage.write(key: 'name', value:firstName.text );
          fromkey.currentState!.save();
          Get.to(VerificationScreen(phoneNumber: '964${phone.text}'));
        } else {
          Get.snackbar('redirect', 'problem in redirect');
        }
      } finally {}
    } else {
      Get.snackbar("من فضلك تأكد من رقم الهاتف".tr, '',
          duration: const Duration(seconds: 1),
          backgroundColor: recGreyClr,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  //verification code
  verificationCheck(String numberphone) async {
    // var phoooooooon=await storage.read(key: 'phone');
    // print('------------$phoooooooon');
    

    var request = await http.post(
      Uri.parse('$baseUrl/Auth-Phone/check'),
      body: {
        'phone': numberphone, 
        'phone_code': code,
      }
    );
    print(code);
    print(numberphone);
    print(request.statusCode);
    if (request.statusCode == 202 || request.statusCode == 200) {
      var data = jsonDecode(request.body);
      final userToken = data['token'];
      await storage.write(key: 'token', value: userToken);
      isSignIn = true;
      authBox.write('auth', isSignIn);
      

      // Get.offAllNamed(Routes.languageOnboarding);
      Get.offAllNamed(Routes.mainScreen);
    } else {
      print(code);
      Get.snackbar("من فضلك تأكد من الكود المدخل".tr, '',
          duration: const Duration(seconds: 1),
          backgroundColor: recGreyClr,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  //log in
  logIn() async {
    // الحصول على FCM token
    final fcmToken = await DeviceToken.getDeviceToken();
    print("kareem$fcmToken");
    var request = await http.post(
      Uri.parse('$baseUrl/Auth-Phone/login'), 
      body: {
        'phone': '964${loginPhone.text.trim()}',
        'fcm_token': fcmToken ?? '',
      }
    );
    // var request = await http.post(Uri.parse('$baseUrl/Auth-Phone/login'), body: {'phone': '${loginPhone.text.trim()}'});

    if (request.statusCode == 202 || request.statusCode == 200|| request.statusCode == 406) {

      var data = jsonDecode(request.body);
      await storage.write(key: 'token', value: data['token']);
      isSignIn = true;

      authBox.write('auth', isSignIn);
      Get.to(VerificationScreen(phoneNumber: '964${loginPhone.text}'));
    } else {
      Get.snackbar("من فضلك تأكد من رقم الهاتف".tr, '',
          duration: const Duration(seconds: 1),
          backgroundColor: recGreyClr,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

//resend
  resendCode(String phoneee) async {

    var request = http.MultipartRequest(
        'POST', Uri.parse('$baseUrl/Auth-Phone/resendCode/$phoneee'));
    request.fields.addAll({
      'phone': phoneee,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 202) {
      Get.snackbar('تم الارسال'.tr, '',
          duration: const Duration(seconds: 1),
          backgroundColor: greenClr,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar("الرجاء الانتظار دقيقة".tr, '',
          duration: const Duration(seconds: 1),
          backgroundColor: recGreyClr,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  //storge
  authData() async {
    final storedToken = await storage.read(key: 'token');
    if (storedToken != null) {
      token = storedToken;
      await getIt<SharedPrefHelper>().saveData(key: ApiKey.authorization, value: token);
      print(token);
    } else {
      print('❌ Token not found in storage');
    }
  }

  bool isAuth() {
    return token.isNotEmpty;
  }

  //logout
  doLogout() async {
    Get.defaultDialog(
        backgroundColor: mainColor,
        title: '',
        middleText: 'هل أنت متأكد أنك تريد تسجيل الخروج؟'.tr,
        middleTextStyle: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        textCancel: 'لا'.tr,
        textConfirm: 'نعم'.tr,
        cancelTextColor: Colors.white,
        confirmTextColor: const Color(0xFFEB001B),
        buttonColor: Colors.white,
        onConfirm: () async {
          storage.deleteAll();
          //
          isSignIn = false;
          authBox.remove('auth');
          Get.toNamed(Routes.signupScreen);
        });
  }
}
