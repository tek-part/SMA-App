import 'package:get/get.dart';

import '../../model/childern_category_model.dart';
import '../../services/main_catogery_services.dart';

class ChildrenCategory extends GetxController {
  List<Datum> childrenCategoryList = <Datum>[].obs; //stream..
  RxInt id = 0.obs;

  var isLoading = true.obs;
  @override
  void onInit() {
    getProducrtDetails(id.value);
    super.onInit();
  }

  void getProducrtDetails(int id) async {
    isLoading(true);
    var products = await ChildernCatogeryServices.getProduct(id);

    try {
      //isLoading.value = true;
      isLoading(true);
      if (products.data.isNotEmpty || childrenCategoryList.isEmpty) {
        childrenCategoryList.clear();
        childrenCategoryList.addAll(products.data);
      }
    } finally {
      isLoading(false);
      update();
    }
  }

  void clearList() {
    childrenCategoryList.clear();
    update();
  }
}
