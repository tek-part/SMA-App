import 'package:get/get.dart';


import '../controller/cart_item_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartItemController());
    // Get.lazyPut(() => CartItemController());
  }
}
