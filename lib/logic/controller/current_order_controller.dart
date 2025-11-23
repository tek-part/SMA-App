import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/current_order_model.dart';
import '../../services/main_catogery_services.dart';
import '../../utils/them.dart';
import 'cart_item_controller.dart';

class CurrentOrderController extends GetxController {
  RxList<Datum> currentOrderItemList = <Datum>[].obs; //stream..
  CartItemController cartItemController = Get.put(CartItemController());
  String message = '';

  var isLoading = true.obs;
  int page = 1;
  var isLoadMore = false.obs;
  var isEmpty = false.obs;
  @override
  void onInit() {
    // CartItemList.canUpdate;
    currentOrderItemList;
    getCartItem();
    // paginateTask();
    isLoading.value;
    super.onInit();
  }

  getCartItem() async {
    isLoading(true);
    try {
      var products = await CurrentOrderItemServices.getProduct(1);

      try {
        if (products.data.isNotEmpty) {
          currentOrderItemList.clear();
          currentOrderItemList.addAll(products.data);
        }
        update();
      } finally {
        isLoading(false);
        update();
      }
    } catch (e) {
      isLoading(false);
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
      var products = await CurrentOrderItemServices.getProduct(page);
      // page++;
      currentOrderItemList.addAll(products.data);

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
