import 'package:get/get.dart';

import '../../model/offer_model.dart';
import '../../model/only_catogery_model.dart';
import '../../services/main_catogery_services.dart';

class MainCatogeryController extends GetxController {
  List<Product> onlyProductList = <Product>[].obs; //stream..
  RxInt productNum = 0.obs;
  //offer
  List<Datum> offerProductList = <Datum>[].obs; //stream..
  RxInt offerNum = 0.obs;
  //all catogery
  List<Datum> allCatogeryList = <Datum>[].obs; //stream..

  var isLoading = true.obs;
  int page = 1;
  var isLoadMore = false.obs;
  var isEmpty = false.obs;

  @override
  void onInit() {
    getOnlyProducts();
    getOfferProducts();
    // paginateTask();
    // offerPaginateTask();
    super.onInit();
  }

  void getOnlyProducts() async {
    isLoading(true);
    onlyProductList.clear();
    page = 1;
    isEmpty(false);
    var products = await OnnlyProductServices.getProduct(1);

    try {
      // onlyProductList.clear();
      if (products.data.products.isNotEmpty) {
        // productList=products.data.products.toList();
        onlyProductList.clear();
        onlyProductList.addAll(products.data.products);
        productNum = products.data.category.count.obs;
      }
    } finally {
      isLoading(false);
    }
  }

  void getOfferProducts() async {
    isLoading.value = true;
    offerProductList.clear();
    page = 1;
    isEmpty(false);
    var products = await OfferServices.getProduct(1);

    try {
      // offerProductList.clear();
      isLoading(true);
      if (products.data.isNotEmpty) {
        // productList=products.data.products.toList();
        offerProductList.clear();
        offerProductList.addAll(products.data);
      }
    } finally {
      isLoading(false);
    }
  }

  void paginateTask() async {
    try {
      var products = await OnnlyProductServices.getProduct(page);
      // page++;
      onlyProductList.addAll(products.data.products);

      isLoadMore(false);
      if (products.data.products.isEmpty) {
        isEmpty(true);
      }
    } catch (e) {
      isLoadMore(false);
      isEmpty(true);
    }
  }

  void offerPaginateTask() async {
    try {
      var products = await OfferServices.getProduct(page);
      // page++;
      offerProductList.addAll(products.data);

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
