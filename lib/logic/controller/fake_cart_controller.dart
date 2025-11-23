import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FakeCartController extends GetxController {
  var productsMap = {}.obs;

  // ignore: non_constant_identifier_names
  void addProductToCart( ProductModels) {
    if (productsMap.containsKey(ProductModels)) {
      productsMap[ProductModels] += 1;
    } else {
      productsMap[ProductModels] = 1;
    }
  }

  // ignore: non_constant_identifier_names
  void removeProductsFormCart( ProductModels) {
    if (productsMap.containsKey(ProductModels) &&
        productsMap[ProductModels] == 1) {
      productsMap.removeWhere((key, value) =>
          key ==
          ProductModels); //فيما معناه اول حاجه اوجد الكي ثانيا لما تبقا ب واحد اعمل ريموف
    } else {
      productsMap[ProductModels] -= 1;
    }
  }

  // ignore: non_constant_identifier_names
  removeOneProducts( ProductModels) {
    productsMap.removeWhere((key, value) => key == ProductModels);
  }

  void clearAllPriuducts() {
    Get.defaultDialog(
        backgroundColor: Colors.grey[800],
        title: '',
        middleText: 'Are you sure you need clear products?',
        middleTextStyle: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        textCancel: 'No',
        textConfirm: 'Yes',
        cancelTextColor: Colors.red,
        confirmTextColor: Colors.white,
        buttonColor: Colors.black,
        onConfirm: () {
          productsMap.clear();
          Get.back();
        });
  }

  get productSubTotal =>
      productsMap.entries.map((e) => e.key.price * e.value).toList();

  get total => productsMap.entries
      .map((e) => e.key.price * e.value)
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(2);
}
