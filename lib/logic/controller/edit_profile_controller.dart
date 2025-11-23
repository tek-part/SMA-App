import 'package:bandora_app/logic/controller/profile_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../utils/them.dart';

class EditProfileController extends GetxController {
  TextEditingController firstName = TextEditingController();
  TextEditingController secondName = TextEditingController();
  final fromkey = GlobalKey<FormState>();
  ProfileDataController controller = Get.put(ProfileDataController());

  editProfile(BuildContext context) async {
    const storage = FlutterSecureStorage();

    String token = (await storage.read(key: 'token'))!;
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://stor.testm.online/api/profile/update'));
    request.fields
        .addAll({'first_name': firstName.text, 'last_name': secondName.text});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      controller.isLoading.value = true;
      controller.productCategoryList.clear();
      controller.getProfileData();
      Get.snackbar('تم تعديل الملف الشخصي'.tr, '',
          duration: const Duration(seconds: 1),
          backgroundColor: mainColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();


    } else {
    }
  }

  @override
  void onInit() {
    firstName = TextEditingController();
    secondName = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    firstName.dispose();
    secondName.dispose();
    super.dispose();
  }
}
