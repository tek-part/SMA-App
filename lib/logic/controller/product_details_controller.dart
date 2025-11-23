import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/Product_Details_model.dart';
import '../../services/main_catogery_services.dart';
import 'cart_item_controller.dart';

class ProductDetails extends GetxController {
  CartItemController controller = Get.put(CartItemController());
  List<Datum> productDetailsList = <Datum>[].obs; //stream..
  //Like
  List<Datum> favouritesList = <Datum>[].obs;

  var storge = GetStorage();

  int idd = 0;
  String name = '';
  String description = '';
  String image = '';
  int price = 0;
  RxInt id = 0.obs;
  int? discountPrice = 0;

  var isLoading = true.obs;
  @override
  void onInit() {
    //save favorite_logic
    List? storedShoppings = storge.read<List>('isFavouritesList');
    if (storedShoppings != null) {
      favouritesList =
          storedShoppings.map((e) => Datum.fromJson(e)).toList().obs;
    }
    super.onInit();
  }

  void getProducrtDetails(int id) async {
    var products = await ProductDetailsServices.getProduct(id);

    try {
      //isLoading.value = true;
      isLoading(true);
      if (products.data.isNotEmpty) {
        productDetailsList.clear();
        productDetailsList.addAll(products.data);
        name = products.data[0].name;
        image = products.data[0].image;
        price = products.data[0].price;
        description = products.data[0].description;
        discountPrice = products.data[0].discountPrice;
        idd = products.data[0].id;
      }
    } finally {
      isLoading(false);
    }
    update();
  }

  void clearList() {
    productDetailsList.clear();
    update();
  }

//Logic For Favourites Screen
  void manageFavourites(int productId) async {
    var existingIndex =
        favouritesList.indexWhere((element) => element.id == productId);
    if (existingIndex >= 0) {
      favouritesList.removeAt(existingIndex);
      await storge.remove('isFavouritesList');
    } else {
      favouritesList.add(
          productDetailsList.firstWhere((element) => element.id == productId));
      await storge.write('isFavouritesList', favouritesList);
    }
  }

  bool isFavourites(int productId) {
    return favouritesList.any((element) => element.id == productId);
  }
}
