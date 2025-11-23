import 'package:get/get.dart';

import '../../model/All_catogery_model.dart';
import '../../services/main_catogery_services.dart';

class CategoryController extends GetxController {
//all catogery
  List<Datum> allCatogeryList = <Datum>[].obs; //stream..
  var isLoading = true.obs;
  //featured Product
  List<Datum> featuredProductList = <Datum>[].obs; //stream..
  int index = 0;
  @override
  void onInit() {
    getAllCategory();
    index;
    super.onInit();
  }

  void getAllCategory() async {
    try {
      var products = await AllCatogeryServices.getProduct();

      try {
        //isLoading.value = true;
        isLoading(true);
        if (products.data.isNotEmpty) {
          // productList=products.data.products.toList();
          allCatogeryList.clear();
          allCatogeryList.addAll(products.data);
        }
      } finally {
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
    }
  }

  void inputIndex(int x) {
    x = index;
  }
}
