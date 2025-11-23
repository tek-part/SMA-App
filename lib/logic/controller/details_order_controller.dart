import 'package:bandora_app/model/all_order_model.dart';
import 'package:bandora_app/model/details_order_model.dart';
import 'package:bandora_app/model/details_order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../model/details_order_model.dart';
import '../../services/main_catogery_services.dart';

class OrderDetailsController extends GetxController {
  List<Product> orderDetailsList = <Product>[].obs; //stream..
  int first = 0;
  int costDelivery = 0;
  int total = 0;
  String name = '';
  String description = '';
   late address addres ;

  var isLoading = true.obs;

  var orders = <Morder>[].obs;


  FirebaseFirestore  firebaseFirestore =  FirebaseFirestore.instance ;
  @override
  void onInit() {
    orders.bindStream(get_All_order());
    super.onInit();
  }

   getProducrtDetails(int id) async {
    print(id);
    var products = await OrderDetailsServices.getProduct(id);
    isLoading(true);

    try {
      //isLoading.value = true;

      if (products.data.products.isNotEmpty) {
        orderDetailsList.clear();
        first = 0;
        costDelivery = 0;
        total = 0;
        orderDetailsList.addAll(products.data.products);
        first = products.data.details.firstCash;
        costDelivery = products.data.details.deliveryCost;
        total = products.data.details.finalCash;
        name = products.data.products[0].name;
        addres = products.data.details.addres ;

      }
    } finally {
      isLoading(false);
    }
    update();
  }

  void clearList() {
    orderDetailsList.clear();
    first = 0;
    costDelivery = 0;
    total = 0;
    update();
  }

  Stream<List<Morder>> get_All_order() => firebaseFirestore.collection("orders").snapshots().map((query) =>  query.docs.map((item) => Morder.fromJson(item)).toList());

}
