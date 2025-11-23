// import 'package:get/get.dart';
//
// import '../../model/notification_model.dart';
// import '../../services/main_catogery_services.dart';
//
// class NotificationController extends GetxController {
//   RxList<Datum> notificationList = <Datum>[].obs; //stream..
//   var isLoading = true.obs;
//   @override
//   void onInit() {
//     getNotificationItem();
//     super.onInit();
//   }
//
//   getNotificationItem() async {
//     isLoading(true);
//     var products = await NotificatoinServices.getProduct();
//
//     try {
//       if (products.data.isNotEmpty) {
//         notificationList.clear();
//         notificationList.addAll(products.data);
//       }
//       update();
//     } finally {
//       isLoading(false);
//       update();
//     }
//   }
// }
