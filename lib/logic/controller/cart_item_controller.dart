import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/cart_item_model.dart';
import '../../services/main_catogery_services.dart';

class CartItemController extends GetxController {
  List<Datum> cartItemList = <Datum>[].obs;
  List<Datum> favouritesList = <Datum>[].obs;

  var storge = GetStorage();
  var isLoading = true.obs;

  @override
  void onInit() {
    // CartItemList.canUpdate;
    cartItemList;
    getCartItem();
    isLoading.value;
    super.onInit();
  }



  getCartItem() async {
    isLoading(true);
    try {
      var products = await CartItemServices.getProduct();

      if (products.data.isNotEmpty) {
        cartItemList.clear();
        cartItemList.addAll(products.data);
      }
      update();
    } catch (e) {
      print('❌ Error in getCartItem: $e');
      // لا نريد أن نوقف التطبيق بسبب خطأ في جلب الكارت
      cartItemList.clear();
    } finally {
      isLoading(false);
      update();
    }
  }

  get total => cartItemList.map((e) => e.total)
      .toList()
      .reduce((value, element) => value + element)
      .toString();
//.toStringAsFixed(2)
//Logic For Favourites Screen
  void manageFavourites(int productId) async {
    var existingIndex =
        favouritesList.indexWhere((element) => element.id == productId);
    if (existingIndex >= 0) {
      favouritesList.removeAt(existingIndex);
      await storge.remove('isFavouritesList');
    } else {
      favouritesList.add(
          cartItemList.firstWhere((element) => element.id == productId));
      await storge.write('isFavouritesList', favouritesList);
    }
  }

  bool isFavourites(int productId) {
    return favouritesList.any((element) => element.id == productId);
  }
}
