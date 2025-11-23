import 'package:get/get.dart';

import '../../model/feature_product_model.dart';
import '../../services/main_catogery_services.dart';

class FeaturedProductController extends GetxController {
  var isLoading = true.obs;
  int page = 1;
  var isLoadMore = false.obs;
  var isEmpty = false.obs;

  //featured Product
  List<Datum> featuredProductList = <Datum>[].obs; //stream..
  @override
  void onInit() {
    // paginateTask();
    getFeaturedProduct();
    super.onInit();
  }

  void getFeaturedProduct() async {
    try {
      isEmpty(false);
      var products = await FeaturedProductServices.getProduct(1);

      try {
        isLoading(true);
        if (products.data.isNotEmpty) {
          featuredProductList.clear();
          featuredProductList.addAll(products.data);
        }
      } finally {
        isLoading(false);
      }
    } catch (e) {
      isEmpty(false);
    }
  }

  void paginateTask() async {
    try {
      var products = await FeaturedProductServices.getProduct(page);
      // page++;
      featuredProductList.addAll(products.data);

      isLoadMore(false);
      if (products.data.isEmpty) {
        isEmpty(true);
      }
    } catch (e) {
      isLoadMore(false);
      isEmpty(true);
    }
    update();
  }
}
