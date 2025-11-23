import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../model/search_model.dart';
import '../../services/main_catogery_services.dart';

class Search extends GetxController {
  List<Category> productCategoryList = <Category>[].obs; //stream..
  int id = 0;
  var empty = true.obs;
  var isLoading = true.obs;
  //search
  var searchList = <Category>[].obs;
  TextEditingController searchTextController = TextEditingController();

  void getSearchProduct(String id) async {
    var products = await SearchServices.getProduct(id);

    try {
      //isLoading.value = true;
      isLoading(true);
      if (products.data.product.isNotEmpty) {
        productCategoryList.addAll(products.data.product);
      }
    } finally {
      // if(productCategoryList.isEmpty){
      //   empty(true);
      // }else{
      //   empty(false);
      // }
      isLoading(false);
    }
    update();
  }

  void clearSearch() {
    productCategoryList.clear();
    searchTextController.clear();
  }
}
