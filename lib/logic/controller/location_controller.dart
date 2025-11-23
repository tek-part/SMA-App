import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../model/location_model.dart';
import '../../services/main_catogery_services.dart';
import '../../utils/my_strings.dart';
import 'package:http/http.dart' as http;

import '../../utils/them.dart';

class LocationController extends GetxController {
  final fromkey = GlobalKey<FormState>();
  TextEditingController firstLocation = TextEditingController();
  TextEditingController secondLocation = TextEditingController();
  TextEditingController updateFirstLocation = TextEditingController();
  TextEditingController updateSecondLocation = TextEditingController();
  RxList<Datum> locationItemList = <Datum>[].obs; //stream..

  late LatLng latlatPostition = new LatLng(0,0) ;

  var isLoading = true.obs;


  @override
  void onInit() {
    firstLocation = TextEditingController();
    secondLocation = TextEditingController();
    updateFirstLocation = TextEditingController();
    updateSecondLocation = TextEditingController();
    getLocationItem();

    super.onInit();
  }

  @override
  void dispose() {
    firstLocation.dispose();
    secondLocation.dispose();
    updateFirstLocation.dispose();
    updateSecondLocation.dispose();

    super.dispose();
  }

  //post adress
  addAdress(BuildContext context) async {
    const storage = FlutterSecureStorage();
    String token = (await storage.read(key: 'token'))!;
    var request = await http.post(Uri.parse('$baseUrl/profile/addAddress'),
        body: {
          'city': firstLocation.text,
          'street': secondLocation.text,
          'flat': '',
          "lat": latlatPostition.latitude.toString(),
          "lang": latlatPostition.longitude.toString()
        },
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (request.statusCode == 202 || request.statusCode == 200) {
      // ignore: unused_local_variable
      var data = jsonDecode(request.body);
      locationItemList.clear();
      getLocationItem();
      Get.snackbar('تم إضافة عنوانك بنجاح'.tr, '',
          duration: const Duration(seconds: 1),
          backgroundColor: mainColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      firstLocation.clear();
      secondLocation.clear();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } else {
      Get.snackbar('إسم هذا الموقع علي سبيل المثال “ مسكن “'.tr, '',
          duration: const Duration(seconds: 1),
          backgroundColor: recGreyClr,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);

    }
  }

  //update

  updateAdress(int id, BuildContext context) async {
    const storage = FlutterSecureStorage();
    String token = (await storage.read(key: 'token'))!;
    var request = await http
        .post(Uri.parse('$baseUrl/profile/UpdateAddress/$id'), body: {
      'city': updateFirstLocation.text,
      'street': updateSecondLocation.text,
      'flat': '',
      "lat": latlatPostition.latitude.toString(),
      "lang": latlatPostition.longitude.toString()
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (request.statusCode == 202 || request.statusCode == 200) {
      // ignore: unused_local_variable
      var data = jsonDecode(request.body);
      getLocationItem();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      updateFirstLocation.clear();
      updateSecondLocation.clear();
      Get.snackbar('تم إضافة عنوانك بنجاح'.tr, '',
          duration: const Duration(seconds: 1),
          backgroundColor: mainColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('من فضلك تأكد من العنوان'.tr, '',
          duration: const Duration(seconds: 1),
          backgroundColor: recGreyClr,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);

    }
  }

  //get location
  getLocationItem() async {
    isLoading(true);

    try {
      var products = await LocationServices.getProduct();
      if (products.data.isNotEmpty) {
        locationItemList.clear();
        locationItemList.addAll(products.data);
      } else {
        isLoading(false);
      }
      update();
    } finally {
      isLoading(false);
      update();
    }
  }

  String? validateName(String value) {
    if (!RegExp(validationName).hasMatch(value)) {
      return 'Invalid email';
    } else {
      return null;
    }
  }
}
