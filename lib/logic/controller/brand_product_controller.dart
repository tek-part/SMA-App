import 'package:get/get.dart';

import '../../model/brand_product_model.dart';
import '../../services/main_catogery_services.dart';

class BrandProoductController extends GetxController {
  List<Datum> brandProductList = <Datum>[].obs; //stream..
  int id = 0;
  var empty = true.obs;
  var isLoading = true.obs;
  int page = 1;
  var isLoadMore = false.obs;
  var isEmpty = false.obs;
  @override
  void onInit() {
    getProducrtDetails(id);

    super.onInit();
  }

  void getProducrtDetails(int id) async {
    page = 1;
    isEmpty(false);
    isLoading(true);
    var products = await BrandProductServices.getProduct(id, 1);

    try {
      //isLoading.value = true;
      isLoading(true);
      if (products.data.isNotEmpty) {
        brandProductList.clear();
        brandProductList.addAll(products.data);
      }
    } finally {
      if (brandProductList.isEmpty) {
        empty(true);
      } else {
        empty(false);
      }
      isLoading(false);
    }
    update();
  }

  void clearList() {
    brandProductList.clear();
    update();
  }

  void paginateTask() async {
    try {
      var products = await BrandProductServices.getProduct(id, page);
      // page++;
      brandProductList.addAll(products.data);

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
