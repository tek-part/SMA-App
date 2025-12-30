import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/details_checkout_model.dart';
import '../../model/profile_data_model.dart';
import '../../services/main_catogery_services.dart';

class CheckOUtDetailsController extends GetxController {
  List<Product> checkOutDetailsList = <Product>[].obs; //stream..
  String first = '';
  int costDelivery = 0;
  String total = '';
  String name = '';
  String description = '';
  String customerName = '';
  String customerPhone = '';
  bool _whatsAppSent = false;
  String? whatsappLink;

  var isLoading = true.obs;
  @override
  void onInit() {
    getProducrtDetails();
    _loadProfileData();
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

  Future<void> _loadProfileData() async {
    try {
      final profile = await ProfileDataServices.getData();
      if (profile.data.isNotEmpty) {
        final Datum user = profile.data.first;
        customerName = '${user.firstName} ${user.lastName}'.trim();
        customerPhone = user.phone;
      }
    } catch (_) {
      // نحاول لاحقاً في حالة الفشل
    }
  }

  String _buildWhatsAppMessage() {
    if (checkOutDetailsList.isEmpty) {
      return 'لا توجد منتجات في الطلب حالياً.';
    }
    final buffer = StringBuffer();
    buffer.writeln('الأصناف:');
    for (final item in checkOutDetailsList) {
      buffer.writeln(
          '- ${item.name} = { ${item.quantity} } => (${item.price} للوحدة)');
    }
    if (customerName.isNotEmpty) buffer.writeln('الاسم: $customerName');
    if (customerPhone.isNotEmpty) buffer.writeln('الهاتف: $customerPhone');
    if (first.isNotEmpty) buffer.writeln('الإجمالي: $first');
    buffer.writeln('تكلفة التوصيل: $costDelivery');
    if (total.isNotEmpty) buffer.writeln('الإجمالي الفرعي: $total');
    return buffer.toString();
  }

  Future<void> _getWhatsAppLink() async {
    if (whatsappLink != null && whatsappLink!.isNotEmpty) {
      return; // الرابط موجود بالفعل
    }
    
    try {
      var products = await ContactWitUsServices.getProduct();
      if (products.status == "success" && products.data.whatsappLink.isNotEmpty) {
        whatsappLink = products.data.whatsappLink;
      }
    } catch (e) {
      print('Error fetching WhatsApp link: $e');
      whatsappLink = null;
    }
  }

  String? _extractPhoneFromWhatsAppLink(String? link) {
    if (link == null || link.isEmpty) return null;
    
    // إذا كان الرابط يحتوي على wa.me أو رقم مباشر
    if (link.contains('wa.me/')) {
      final match = RegExp(r'wa\.me/(\d+)').firstMatch(link);
      if (match != null) {
        return match.group(1);
      }
    }
    
    // إذا كان الرابط يحتوي على رقم فقط
    final phoneMatch = RegExp(r'(\d+)').firstMatch(link);
    if (phoneMatch != null) {
      return phoneMatch.group(1);
    }
    
    return null;
  }

  Future<void> openWhatsApp({bool fromUserTap = false}) async {
    if (checkOutDetailsList.isEmpty) {
      if (fromUserTap) {
        Get.snackbar('لا توجد منتجات لإرسالها'.tr, '',
            snackPosition: SnackPosition.BOTTOM);
      }
      return;
    }

    // جلب رابط واتساب من API
    await _getWhatsAppLink();
    
    // التحقق من وجود رابط واتساب
    if (whatsappLink == null || whatsappLink!.isEmpty) {
      if (fromUserTap) {
        Get.snackbar('رابط واتساب غير متوفر'.tr, '',
            snackPosition: SnackPosition.BOTTOM);
      }
      return;
    }

    final message = _buildWhatsAppMessage();
    final phone = _extractPhoneFromWhatsAppLink(whatsappLink);
    
    if (phone == null || phone.isEmpty) {
      if (fromUserTap) {
        Get.snackbar('رابط واتساب غير صحيح'.tr, '',
            snackPosition: SnackPosition.BOTTOM);
      }
      return;
    }

    final uri = Uri.parse('https://wa.me/$phone?text=${Uri.encodeComponent(message)}');

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && fromUserTap) {
        Get.snackbar('واتساب غير متوفر'.tr, '',
            snackPosition: SnackPosition.BOTTOM);
      }
      _whatsAppSent = launched || _whatsAppSent;
    } catch (_) {
      if (fromUserTap) {
        Get.snackbar('تعذر فتح واتساب'.tr, '',
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  Future<void> triggerAutoWhatsApp() async {
    if (_whatsAppSent) return;
    if (isLoading.value || checkOutDetailsList.isEmpty) return;
    await openWhatsApp();
  }
}
