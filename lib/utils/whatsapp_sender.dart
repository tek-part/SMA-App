import 'package:url_launcher/url_launcher.dart';

class WhatsAppOrderSender {
  const WhatsAppOrderSender._();

  /// يبني نص رسالة واتساب مفصلة للطلب.
  static String buildOrderMessage({
    required int orderId,
    required List<WhatsAppOrderItem> items,
    String? customerName,
    String? customerPhone,
    int? subtotal,
    int? deliveryCost,
    int? total,
  }) {
    final buffer = StringBuffer();
    buffer.writeln('رقم الطلب: $orderId');
    if (customerName != null && customerName.trim().isNotEmpty) {
      buffer.writeln('الاسم: $customerName');
    }
    if (customerPhone != null && customerPhone.trim().isNotEmpty) {
      buffer.writeln('الهاتف: $customerPhone');
    }

    if (items.isEmpty) {
      buffer.writeln('لا توجد منتجات في الطلب حالياً.');
      return buffer.toString();
    }

    buffer.writeln('المنتجات:');
    for (final item in items) {
      final lineTotal = item.price * item.quantity;
      buffer.writeln(
          '• ${item.name} — ${item.quantity} × ${item.price} = $lineTotal');
    }

    if (subtotal != null) buffer.writeln('الإجمالي الفرعي: $subtotal');
    if (deliveryCost != null) buffer.writeln('التوصيل: $deliveryCost');
    if (total != null) buffer.writeln('الإجمالي: $total');
    return buffer.toString();
  }

  /// يستخرج رقم الهاتف من رابط واتساب
  static String? extractPhoneFromWhatsAppLink(String? link) {
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

  /// يفتح واتساب عبر wa.me ويعيد true عند النجاح.
  /// يتطلب رابط واتساب من API، وإذا لم يكن متوفراً يعيد false
  static Future<bool> openWhatsApp(String message, String? whatsappLink) async {
    if (whatsappLink == null || whatsappLink.isEmpty) {
      return false;
    }

    final phone = extractPhoneFromWhatsAppLink(whatsappLink);
    if (phone == null || phone.isEmpty) {
      return false;
    }

    final uri =
        Uri.parse('https://wa.me/$phone?text=${Uri.encodeComponent(message)}');
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }
}

class WhatsAppOrderItem {
  final String name;
  final int quantity;
  final int price;

  const WhatsAppOrderItem({
    required this.name,
    required this.quantity,
    required this.price,
  });
}

