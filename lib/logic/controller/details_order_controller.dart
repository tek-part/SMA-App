import 'package:bandora_app/model/all_order_model.dart';
import 'package:bandora_app/model/details_order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/main_catogery_services.dart';

class OrderDetailsController extends GetxController {
  List<Product> orderDetailsList = <Product>[].obs; //stream..
  int first = 0;
  int costDelivery = 0;
  int total = 0;
  String name = '';
  String description = '';
  String userPhone = '';
  late address addres;
  int? lastOrderId;

  var isLoading = true.obs;

  var orders = <Morder>[].obs;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  void onInit() {
    orders.bindStream(get_All_order());
    super.onInit();
  }

  getProducrtDetails(int id) async {
    print(id);
    lastOrderId = id;
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
        userPhone = products.data.details.userPhone;
        addres = products.data.details.addres;
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
    userPhone = '';
    update();
  }

  Stream<List<Morder>> get_All_order() => firebaseFirestore
      .collection("orders")
      .snapshots()
      .map((query) => query.docs.map((item) => Morder.fromJson(item)).toList());

  String _buildWhatsAppMessage() {
    if (orderDetailsList.isEmpty) {
      return 'لا توجد منتجات في الطلب حالياً.';
    }
    final buffer = StringBuffer();
    buffer.writeln('الأصناف:');
    for (final item in orderDetailsList) {
      buffer.writeln('- ${item.name} :\n  الكمية: ${item.quantity}');
    }
    if (userPhone.isNotEmpty) {
      buffer.writeln('هاتف المستخدم:\n $userPhone');
    }
    return buffer.toString();
  }

  Future<void> sendWhatsAppForOrder(
    int orderId, {
    bool fromUserTap = false,
    String? userPhoneOverride,
  }) async {
    // نستخدم رقم الهاتف المرسل من شاشة الإنهاء كنسخة احتياطية قبل جلب التفاصيل
    if (userPhoneOverride != null && userPhoneOverride.trim().isNotEmpty) {
      userPhone = userPhoneOverride.trim();
    }
    try {
      print("Send with whatsapp\n$orderId");
      await getProducrtDetails(orderId);
    } catch (e) {
      if (fromUserTap) {
        Get.snackbar('تعذر جلب تفاصيل الطلب'.tr, e.toString(),
            snackPosition: SnackPosition.BOTTOM);
      }
      return;
    }
    await _sendCurrentOrderToWhatsApp(fromUserTap: fromUserTap);
  }

  Future<void> sendWhatsAppForLastOrder({bool fromUserTap = false}) async {
    if (lastOrderId == null) {
      if (fromUserTap) {
        Get.snackbar('لا يوجد طلب محدد'.tr, '',
            snackPosition: SnackPosition.BOTTOM);
      }
      return;
    }
    try {
      await getProducrtDetails(lastOrderId!);
    } catch (e) {
      if (fromUserTap) {
        Get.snackbar('تعذر جلب تفاصيل الطلب'.tr, e.toString(),
            snackPosition: SnackPosition.BOTTOM);
      }
      return;
    }
    await _sendCurrentOrderToWhatsApp(fromUserTap: fromUserTap);
  }

  Future<void> _sendCurrentOrderToWhatsApp({bool fromUserTap = false}) async {
    if (orderDetailsList.isEmpty) {
      if (fromUserTap) {
        Get.snackbar('لا توجد منتجات لإرسالها'.tr, '',
            snackPosition: SnackPosition.BOTTOM);
      }
      return;
    }

    final message = _buildWhatsAppMessage();
    const phone = '201094260793';
    final uri =
        Uri.parse('https://wa.me/$phone?text=${Uri.encodeComponent(message)}');

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && fromUserTap) {
        Get.snackbar('واتساب غير متوفر'.tr, '',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (_) {
      if (fromUserTap) {
        Get.snackbar('تعذر فتح واتساب'.tr, '',
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }
}
