import 'package:bandora_app/services/main_catogery_services.dart';
import 'package:get/get.dart';

import '../../model/brand_model.dart';

class BrandController extends GetxController {
  List<Datum> brandList = <Datum>[].obs; //stream..
  var isLoading = true.obs;
  //featured Product

  @override
  void onInit() {
    getAllCategory();
    super.onInit();
  }

  void getAllCategory() async {
    try {
      var products = await BrandServices.getProduct();

      try {
        //isLoading.value = true;
        isLoading(true);
        if (products.data.isNotEmpty) {
          brandList.clear();
          brandList.addAll(products.data);
        }
      } finally {
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
    }
  }
}
