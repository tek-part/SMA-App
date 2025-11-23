import 'package:dio/dio.dart';
import '../../helpers/shared_pref_helper.dart';
import '../constants/api_constants.dart';
import '../di/dependency_injection.dart';

class DioInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      // الحصول على التوكن من SharedPreferences
      final token = getIt<SharedPrefHelper>().getData(key: ApiKey.authorization);
      
      if (token != null && token.toString().isNotEmpty) {
        options.headers[ApiKey.authorization] = 'Bearer $token';
        print('🔑 تم إرسال التوكن في الطلب: ${options.uri}');
        print('🔑 التوكن: Bearer ${token.toString().substring(0, 10)}...');
      } else {
        print('⚠️ لا يوجد توكن متاح للطلب: ${options.uri}');
        print('⚠️ هذا قد يسبب خطأ 401 Unauthorized');
      }
      
      // طباعة تفاصيل الطلب للتشخيص
      print('🌐 إرسال طلب إلى: ${options.uri}');
      print('📋 طريقة الطلب: ${options.method}');
      print('📋 Headers: ${options.headers}');
      
    } catch (e) {
      print('❌ خطأ في معالج التوكن: $e');
    }
    
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('✅ تم استلام رد من: ${response.requestOptions.uri}');
    print('📊 رمز الحالة: ${response.statusCode}');
    print('📄 حجم البيانات: ${response.data?.toString().length ?? 0} حرف');
    
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('❌ خطأ في الطلب: ${err.requestOptions.uri}');
    print('🔍 نوع الخطأ: ${err.type}');
    print('🔍 رمز الحالة: ${err.response?.statusCode}');
    print('🔍 رسالة الحالة: ${err.response?.statusMessage}');
    
    if (err.response?.statusCode == 401) {
      print('🚨 خطأ 401: التوكن غير صالح أو منتهي الصلاحية');
      print('💡 الحل: إعادة تسجيل الدخول للحصول على توكن جديد');
    }
    
    super.onError(err, handler);
  }
}
