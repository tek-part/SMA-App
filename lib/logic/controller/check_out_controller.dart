import 'dart:convert';

import 'package:bandora_app/model/all_order_model.dart' as model;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../model/check_out_page_model.dart';
import '../../services/main_catogery_services.dart';
import '../../utils/my_strings.dart';
import 'package:http/http.dart' as http;

import '../../utils/them.dart';
import '../../view/screen/order_status_english.dart';
import '../../view/screen/order_status_screen.dart';
import 'cart_controller.dart';
import 'details_order_controller.dart';

class CheckOutController extends GetxController {
  final fromkey = GlobalKey<FormState>();
  TextEditingController anotherPhone = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController cobon = TextEditingController();
  CartController cartController = Get.put(CartController());
  OrderDetailsController orderDetailsController =
      Get.put(OrderDetailsController());
  var isLoading = true.obs;
  var isl = false.obs;
  RxList<Datum> checkOutPageList = <Datum>[].obs; //stream..
  String location = 'اختر عنوانك'.tr;
  int location_id = 0;
  TextEditingController looooc = TextEditingController();

  get storage => null;
  @override
  void onInit() {
    phone = TextEditingController();
    anotherPhone = TextEditingController();
    cobon = TextEditingController();
    looooc = TextEditingController();
    getCheckOutPage();
    super.onInit();
  }

  @override
  void dispose() {
    phone.dispose();
    anotherPhone.dispose();
    cobon.dispose();
    looooc.dispose();
    super.dispose();
  }

  checkOut(var phoneNumber, BuildContext context, bool lang) async {
    print('=== CHECKOUT DEBUG START ===');
    print('Phone: ${phone.text}');
    print('Another Phone: ${anotherPhone.text}');
    print('Address: $location');
    print('Address ID: $location_id');

    const storage = FlutterSecureStorage();
    String token = (await storage.read(key: 'token'))!;
    var request = await http.post(Uri.parse('$baseUrl/CheckOut'), body: {
      'phone_number': phone.text,
      'another_phone': anotherPhone.text,
      'address': location,
      'address_id': location_id.toString(),
      'payment_method': 'cach',
      'coupon': '',
    }, headers: {
      'Authorization': 'Bearer $token',
      "Accept": 'application/json'
    });

    print('Response Status Code: ${request.statusCode}\n$token');
    print('Response Body: ${request.body}');

    // تحسين معالجة الـ status codes
    if (request.statusCode == 200 ||
        request.statusCode == 201 ||
        request.statusCode == 202) {
      print('Success! Status code is ${request.statusCode}');
      Map<String, dynamic> dataJson = jsonDecode(request.body);
      int newOrderCode = dataJson['data']['order'];

      // تمرير رقم المستخدم مباشرةً لرسالة واتساب قبل جلب التفاصيل من الخادم
      await orderDetailsController.sendWhatsAppForOrder(newOrderCode,
          fromUserTap: true,
          userPhoneOverride: phone.text.trim().isNotEmpty
              ? phone.text.trim()
              : anotherPhone.text.trim());
      Get.snackbar("تم التحويل بنجاح شكرا للك".tr, '',
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.white,
          colorText: mainColor,
          snackPosition: SnackPosition.TOP);
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: lang ? OrderStatusScreen() : OrderStatusEnglishScreen(),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );

      anotherPhone.clear();
      phone.clear();
      location = 'اختر عنوانك';
      cobon.clear();
      cartController.clearCart();
      update();
    } else if (request.statusCode == 422) {
      // Validation error - قد يكون العنوان غير صحيح
      print('Validation Error! Status code is ${request.statusCode}');
      print('Error response: ${request.body}');
      Get.snackbar('من فضلك تأكد من العنوان'.tr, '',
          duration: const Duration(seconds: 2),
          backgroundColor: recGreyClr,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP);
    } else if (request.statusCode == 401) {
      // Unauthorized
      print('Unauthorized! Status code is ${request.statusCode}');
      Get.snackbar('يرجى تسجيل الدخول مرة أخرى'.tr, '',
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP);
    } else {
      print('Error! Status code is ${request.statusCode}');
      print('Error response: ${request.body}');
      Get.snackbar('حدث خطأ في إرسال الطلب'.tr, '',
          duration: const Duration(seconds: 2),
          backgroundColor: recGreyClr,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP);
    }
    print('=== CHECKOUT DEBUG END ===');
  }

  getCheckOutPage() async {
    isLoading(true);
    try {
      var products = await CheckOutPageServices.getProduct();

      // if (products.data.isNotEmpty) {
      if (products.data != null) {
        checkOutPageList.clear();
        // checkOutPageList.addAll(products.data);
        checkOutPageList.add(products.data!);
        print('CheckOut data loaded successfully');
      } else {
        // Handle case when data is null
        checkOutPageList.clear();
        print('CheckOut data is null - API returned empty data');
        // Optionally show a message to user
        Get.snackbar(
          'لا توجد بيانات متاحة'.tr,
          'يرجى المحاولة مرة أخرى لاحقاً'.tr,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Error in getCheckOutPage: $e');
      checkOutPageList.clear();

      String errorMessage = 'يرجى التحقق من الاتصال والمحاولة مرة أخرى'.tr;
      Color backgroundColor = Colors.red;

      if (e.toString().contains('Unauthorized')) {
        errorMessage = 'يرجى تسجيل الدخول مرة أخرى'.tr;
        backgroundColor = Colors.orange;
      } else if (e.toString().contains('Network error')) {
        errorMessage = 'خطأ في الاتصال - يرجى التحقق من الإنترنت'.tr;
        backgroundColor = Colors.red;
      } else if (e.toString().contains('Empty response')) {
        errorMessage = 'لا توجد بيانات متاحة حالياً'.tr;
        backgroundColor = Colors.orange;
      } else if (e.toString().contains('Invalid response format')) {
        errorMessage = 'خطأ في تنسيق البيانات من الخادم'.tr;
        backgroundColor = Colors.red;
      } else if (e.toString().contains('Token not found')) {
        errorMessage = 'يرجى تسجيل الدخول مرة أخرى'.tr;
        backgroundColor = Colors.orange;
      }

      // Show error message to user
      Get.snackbar(
        'خطأ في تحميل البيانات'.tr,
        errorMessage,
        duration: const Duration(seconds: 3),
        backgroundColor: backgroundColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
      update();
    }
  }

  checkConbon() async {
    const storage = FlutterSecureStorage();
    String token = (await storage.read(key: 'token'))!;
    var request = await http.post(Uri.parse('$baseUrl/CheckOut/CouponCheck'),
        body: {'coupon': cobon.text},
        headers: {'Authorization': 'Bearer $token'});

    if (request.statusCode == 202 || request.statusCode == 200) {
      // ignore: unused_local_variable
      var data = jsonDecode(request.body);
      getCheckOutPage();

      update();
    } else {
      Get.snackbar("من فضللك تاكد من الكوبون".tr, '',
          duration: const Duration(seconds: 1),
          backgroundColor: recGreyClr,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  String? validateName(String value) {
    if (!RegExp(validationName).hasMatch(value)) {
      return 'Invalid email';
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
}
