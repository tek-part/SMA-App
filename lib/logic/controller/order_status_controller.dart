import 'dart:async';

import 'package:bandora_app/model/M_representatives.dart';
import 'package:bandora_app/model/order_status_model.dart';
import 'package:bandora_app/model/subCategories.dart';
import 'package:bandora_app/services/notification_services.dart';
import 'package:get/get.dart';

import '../../services/main_catogery_services.dart';

class OrderStatusController extends GetxController {
  List<OrderStatus> orderStatusItemList = <OrderStatus>[].obs;
  var isLoading = true.obs;
  String representative = '';
  String status = '';
  String remaing = '';
  int type = 0;
  int id = 0;
  List<SubCategories> order_notification = [];

  var driver = Rxn<Mrepresentatives>();

  @override
  void onInit() {
    getOrderStatusItem();
    type;
    //Timer.periodic(const Duration(seconds: 15), (Timer t) => get_order_notification());
    super.onInit();
  }

  getOrderStatusItem() async {
    isLoading(true);
    orderStatusItemList.clear();

    try {
      try {
        var products = await OrderStatusServices.getProduct();
        orderStatusItemList.clear();
        if (products.status == "success") {
          orderStatusItemList.addAll(products.data);
          // representative = products.data.;
          // status = products.data.status;
          // remaing = products.data.remaing;
          // type = products.data.type;
          // id = products.data.id;
        }
        update();
      } catch (e) {
        isLoading(false);
        update();
      }
    } finally {
      isLoading(false);
    }
  }

  show_Customer_rating(body) async {
    try {
      var products = await OrderStatusServices.post_rateing(body);
      if (products.status == "success") {}
      update();
    } catch (e) {
      isLoading(false);
      update();
    }
  }

  get_rating(id) async {
    try {
      var products = await OrderStatusServices.get_rate(id);
      if (products != null) {
        driver.value = products;
      }
      update();
    } catch (e) {
      isLoading(false);
      update();
    }
  }

  // get_order_notification(){
  //   orderStatusItemList.map((el){
  //     if(el.type != 4){
  //       if(order_notification.isEmpty){
  //         var _data = SubCategories(id:  el.id, name:  el.type.toString());
  //         order_notification.add(_data);
  //        // NotificationService notificationService = NotificationService();
  //         notificationService.showNotification(1, 'app_name'.tr , el.status, {},el.type == 1 ? 'assets/images/orders/not1.png' : el.type == 2 ? 'assets/images/orders/not2.png' : 'assets/images/orders/not3.png');
  //       }else{
  //         var  check = order_notification.where((ee)=>ee.id == el.id) ;
  //         if(check.isEmpty){
  //               var _data = SubCategories(id:  el.id, name:  el.type.toString());
  //               order_notification.add(_data);
  //              // NotificationService notificationService = NotificationService();
  //               notificationService.showNotification(1, 'app_name'.tr , el.status, {},'assets/images/orders/not1.png');
  //         }else{
  //                if(check.first.name  != el.type.toString()){
  //                   check.first.name =  el.type.toString() ;
  //                 //  NotificationService notificationService = NotificationService();
  //                   notificationService.showNotification(1, 'app_name'.tr , el.status, {},el.type == 2 ? 'assets/images/orders/not2.png' : 'assets/images/orders/not3.png');
  //                 }
  //     }
  //
  //       }
  //
  //     }
  //   } ).toList();
  //
  //
  //   if(orderStatusItemList.where((el)=>el.type != 4).isNotEmpty){
  //     getOrderStatusItem();
  //   }
  //
  // }
}
