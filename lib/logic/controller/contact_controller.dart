import 'package:bandora_app/utils/my_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../services/main_catogery_services.dart';
import '../../utils/them.dart';

class ContactController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController message = TextEditingController();
  var isLoading = true.obs;
  String facebookLink = '';
  String watsappLink = '';
  String instgramLink = '';
  String phone = '';

  sendMessage() async {
    const storage = FlutterSecureStorage();

    String token = (await storage.read(key: 'token'))!;
    var headers = {'Authorization': 'Bearer $token'};
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/Connect/Message'));
    request.fields.addAll({'fullName': name.text, 'message': message.text});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Get.snackbar('تم ارسال رسالتك'.tr, '',
          duration: const Duration(seconds: 1),
          backgroundColor: mainColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } else {
    }
  }

  void getSlider() async {
    var products = await ContactWitUsServices.getProduct();

    try {
      //isLoading.value = true;
      isLoading(true);
      if (products.status == "success") {
        phone = products.data.phone;
        facebookLink = products.data.facebookLink;
        instgramLink = products.data.instagramLink;
        watsappLink = products.data.whatsappLink;
      }
    } finally {
      isLoading(false);
    }
    update();
  }

  @override
  void onInit() {
    name = TextEditingController();
    message = TextEditingController();
    getSlider();
    phone;
    facebookLink;
    instgramLink;
    watsappLink;

    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    message.dispose();
    super.dispose();
  }
}
