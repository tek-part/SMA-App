import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/previous_order_model.dart';
import '../../services/main_catogery_services.dart';
import '../../utils/them.dart';
import 'cart_item_controller.dart';

class PreviousOrderController extends GetxController {
  CartItemController cartItemController = Get.put(CartItemController());
  RxList<Datum> previousorderItemList = <Datum>[].obs; //stream..

  var isLoading = true.obs;
  int page = 1;
  var isLoadMore = false.obs;
  var isEmpty = false.obs;
  String message = '';

  @override
  void onInit() {
    // CartItemList.canUpdate;
    paginateTask();
    previousorderItemList;
    getCartItem();
    isLoading.value;
    super.onInit();
  }

  getCartItem() async {
    isLoading(true);
    var products = await PreviousItemServices.getProduct(1);

    try {
      if (products.data.isNotEmpty) {
        previousorderItemList.clear();
        previousorderItemList.addAll(products.data);
      }
      update();
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
      var products = await PreviousItemServices.getProduct(page);
      // page++;
      previousorderItemList.addAll(products.data);

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
