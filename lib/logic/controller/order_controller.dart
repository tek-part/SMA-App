import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/all_order_model.dart';
import '../../services/main_catogery_services.dart';
import '../../utils/them.dart';
import 'cart_item_controller.dart';

class OrderController extends GetxController {
  RxList<Datum> orderItemList = <Datum>[].obs; //stream..
  CartItemController cartItemController = Get.put(CartItemController());
  String message = '';

  int page = 1;
  var isLoading = true.obs;
  var isLoadMore = false.obs;
  var isEmpty = false.obs;
  @override
  void onInit() {
    // CartItemList.canUpdate;
    paginateTask();
    orderItemList;
    getCartItem();
    isLoading.value;
    super.onInit();
  }

  getCartItem() async {
    isLoading(true);
    try {
      var products = await OrderItemServices.getProduct(1);

      if (products.data.isNotEmpty) {
        orderItemList.clear();
        orderItemList.addAll(products.data);
      }
      update();
    } catch (e) {
      print('❌ Error in OrderController.getCartItem: $e');
      // لا نريد أن نوقف التطبيق بسبب خطأ في جلب الطلبات
      orderItemList.clear();
    } finally {
      isLoading(false);
      update();
    }
  }

  repetOrderItem(int id) async {
    // isLoading(true);
    var products = await RepetOrderServices.getProduct(id);
    try {
      if (products.status == "success") {
        cartItemController.getCartItem();
        message = products.message;
        Get.snackbar(message.tr, '',
            duration: const Duration(seconds: 1),
            backgroundColor: mainColor,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      }
      update();
    } finally {
      isLoading(false);
      update();
    }
  }

  void paginateTask() async {
    try {
      var products = await OrderItemServices.getProduct(page);
      // page++;
      orderItemList.addAll(products.data);
      isLoadMore(false);
      if (products.data.isEmpty) {
        isEmpty(true);
      }
    } catch (e) {
      isLoadMore(false);
      isEmpty(true);
    }
  }
}
