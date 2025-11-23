import 'dart:convert';

import 'package:bandora_app/utils/my_strings.dart';
import 'package:bandora_app/view/widget/button_utils.dart';
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import '../../routes/routes.dart';
import '../../utils/them.dart';
import 'cart_item_controller.dart';

class CartController extends GetxController {
  CartItemController cartItemController = Get.put(CartItemController());
  var storage = const FlutterSecureStorage();
  RxInt qty = 1.obs;
  var isLoading = true.obs;
  bool click = true;
  bool emmbty = false;

  postCartData(String id) async {
    try {
      String token = (await storage.read(key: 'token'))!;
      isLoading(true);
      int type = 1 ;
      var request = await http.post(Uri.parse('$baseUrl/Cart/Store'),
          body: {'productId': id, 'qty': '$qty','type':"$type"},
          headers: {'Authorization': 'Bearer $token'});
      try {
        if (request.statusCode == 202 || request.statusCode == 200) {
          // checkOutController.checkOutPageList.clear();
          // checkOutController.getCheckOutPage();
          Get.snackbar('تم إضافة المنتج'.tr, '',
              duration: const Duration(seconds: 1),
              backgroundColor: mainColor,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
        } else {
          Get.defaultDialog(
            backgroundColor: Colors.white,
            title: '',
            titlePadding: const EdgeInsets.all(0),
            titleStyle: const TextStyle(
              height: 0,
              letterSpacing: -0.30,
            ),
            middleText: '',
            actions: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LottieBuilder.asset(
                        'assets/lottie/Animation - 1700525647440.json',
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain),
                    TextUtils(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: mainColor,
                        text: 'انتبه!'.tr),
                    SizedBox(
                      width: 201.87,
                      child: Text(
                        "نأسف لقد نفذت الكمية ! لا تقلق,\nسنضيف المزيد قريبا"
                            .tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: GreyClr,
                          fontSize: 14,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w500,
                          height: 0,
                          letterSpacing: -0.30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ButtonUtils(
                  text: 'تم'.tr,
                  onPressed: () {
                    Get.back();
                  },
                  colorstext: Colors.white,
                  background: mainColor)
            ],
            middleTextStyle: const TextStyle(
              height: 0,
              letterSpacing: -0.30,
            ),
          );
        }
      } finally {
        isLoading(false);
      }

      cartItemController.getCartItem();
    } catch (e) {
      Get.defaultDialog(
        backgroundColor: Colors.white,
        title: '',
        titlePadding: const EdgeInsets.all(0),
        titleStyle: const TextStyle(
          height: 0,
          letterSpacing: -0.30,
        ),
        middleText: '',
        actions: [
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset('assets/lottie/Animation - 1700588382977.json',
                    height: 100, width: 100, fit: BoxFit.contain),
                TextUtils(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: mainColor,
                    text: 'انتبه!'.tr),
                SizedBox(
                  width: 201.87,
                  child: Text(
                    "يجب عليك تسجيل الدخول اولا ".tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: GreyClr,
                      fontSize: 14,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w500,
                      height: 0,
                      letterSpacing: -0.30,
                    ),
                  ),
                )
              ],
            ),
          ),
          ButtonUtils(
              text: 'تسجيل الدخول'.tr,
              onPressed: () {
                Get.offNamed(Routes.signupScreen);
              },
              colorstext: Colors.white,
              background: mainColor)
        ],
        middleTextStyle: const TextStyle(
          height: 0,
          letterSpacing: -0.30,
        ),
      );
    }
  }

  addCartData(String id,int quty) async {
    String token = (await storage.read(key: 'token'))!;
    isLoading(true);
    int type=1;
    try {
      var request = await http.post(
        Uri.parse('$baseUrl/Cart/Store'),
        body: {'productId': id, 'qty': '$quty','type':"$type"},
        headers: {'Authorization': 'Bearer $token'},
      );

      if (request.statusCode == 202 || request.statusCode == 200) {
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
      cartItemController.getCartItem();
    }
  }

  minCartData(String id,int quty) async {
    String token = (await storage.read(key: 'token'))!;
    isLoading(true);
    int type=0;

    try {
      var request = await http.post(
        Uri.parse('$baseUrl/Cart/Store'),
        body: {'productId': id, 'qty': '$quty','type':"$type"},
        headers: {'Authorization': 'Bearer $token'},
      );

      if (request.statusCode == 202 || request.statusCode == 200) {
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
      cartItemController.getCartItem();
    }
  }

  // minCartData(String id,int i) async {
  //   String token = (await storage.read(key: 'token'))!;
  //   isLoading(true);
  //
  //   var request = await http.post(Uri.parse('$baseUrl/Cart/Store'),
  //       body: {'productId': id, 'qty': '$i'},
  //       headers: {'Authorization': 'Bearer $token'});
  //   try {
  //     if (request.statusCode == 202 || request.statusCode == 200) {
  //
  //       var data = jsonDecode(request.body);
  //     } else {
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  //
  //   // qty.value=1;
  //   cartItemController.getCartItem();
  // }

  deleteCart(int id) async {
    String token = (await storage.read(key: 'token'))!;
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request =
        http.MultipartRequest('DELETE', Uri.parse('$baseUrl/Cart/Delete/$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // ignore: await_only_futures
      await response.stream;
    } else {}
    cartItemController.getCartItem();
    update();
  }

  clearCart() async {
    String token = (await storage.read(key: 'token'))!;
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request =
        http.MultipartRequest('DELETE', Uri.parse('$baseUrl/Cart/DeleteAll'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // ignore: await_only_futures
      await response.stream;
    } else {}
    cartItemController.cartItemList.clear();
    cartItemController.getCartItem();
    update();
  }

  add() {
    qty += 1;
  }

  min() {
    // ignore: unrelated_type_equality_checks
    if (qty == 1) {
      return null;
    } else {
      qty -= 1;
    }
  }

  void isFavourites() {
    click = !click;
    update();
  }

  @override
  void onInit() {
    postCartData;
    // isLoading.value;
    // clearCart();
    // deleatCart();
    click;
    super.onInit();
  }
}
