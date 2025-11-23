import 'package:get/get.dart';

import '../../model/product_category_model.dart';
import '../../services/main_catogery_services.dart';

class ProductCatogeryController extends GetxController {
  List<Datum> productCategoryList = <Datum>[].obs; //stream..
  int id = 0;
  var empty = true.obs;
  var isLoading = true.obs;
  int page = 1;
  var isLoadMore = false.obs;
  var isEmpty = false.obs;
  @override
  void onInit() {
    // لا نستدعي getProducrtDetails هنا لأن id = 0 في البداية
    // getProducrtDetails(id);
    // paginateTask();
    super.onInit();
  }

  void getProducrtDetails(int id) async {
    if (id == 0) return; // تجنب استدعاء API إذا كان id صفر
    
    this.id = id;
    isEmpty(false);
    isLoading(true);
    update();
    
    try {
      var products = await ProductCatogeryServices.getProduct(id, 1);
      
      if (products.data.isNotEmpty) {
        productCategoryList.clear();
        productCategoryList.addAll(products.data);
        empty(false);
      } else {
        productCategoryList.clear();
        empty(true);
      }
    } catch (e) {
      productCategoryList.clear();
      empty(true);
    } finally {
      isLoading(false);
      update();
    }
  }

  void clearList() {
    if (productCategoryList.isNotEmpty) {
      productCategoryList.clear();
      page = 1;
      empty(true);
      isEmpty(false);
      update();
    }
  }

  void paginateTask() async {
    isLoadMore(true);
    try {
      //  page++;
      print('###########$page');
      var products = await ProductCatogeryServices.getProduct(id, page);
      // page++;
      productCategoryList.addAll(products.data);
      print('done');
      print('========$id');
      isLoadMore(false);

      print(isLoadMore.value);
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
