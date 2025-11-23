import 'package:get/get.dart';

import '../../model/details_checkout_model.dart';
import '../../services/main_catogery_services.dart';

class CheckOUtDetailsController extends GetxController {
  List<Product> checkOutDetailsList = <Product>[].obs; //stream..
  String first = '';
  int costDelivery = 0;
  String total = '';
  String name = '';
  String description = '';

  var isLoading = true.obs;
  @override
  void onInit() {
    getProducrtDetails();
    super.onInit();
  }

  void getProducrtDetails() async {
    var products = await CheckOutDetailsServices.getProduct();
    // isLoading(true);

    try {
      isLoading.value = true;

      if (products.data.product.isNotEmpty) {
        checkOutDetailsList.clear();
        first = '';
        costDelivery = 0;
        total = '';
        checkOutDetailsList.addAll(products.data.product);
        first = products.data.details.total;
        costDelivery = products.data.details.deliveryCost;
        total = products.data.details.subTotal;
      } else {}
    } finally {
      isLoading(false);
    }
    update();
  }

  void clearList() {
    checkOutDetailsList.clear();
    first = '';
    costDelivery = 0;
    total = '';
    update();
  }
}
