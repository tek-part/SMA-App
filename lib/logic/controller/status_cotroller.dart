import 'package:get/get.dart';

import '../../services/main_catogery_services.dart';

class StatusContrller extends GetxController {
  var isLoading = false.obs;
  @override
  void onInit() {
    getStatus();
    super.onInit();
  }

  bool sss = false;
  bool stutus = true;
  int remaining = 0;

  getStatus() async {
    isLoading(true);
    var products = await StatusServices.getProduct();

    try {
      if (products.status == "success") {
        isLoading(false);
        stutus = products.data.status;
        remaining = products.data.remaining;
        sss = true;
      } else {
        sss = false;
      }
      update();
    } finally {
      // isLoading(false);
      update();
    }
  }
}
