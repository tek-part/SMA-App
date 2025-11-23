import 'package:bandora_app/notifications/data/data_source/notifications_data_source.dart';
import 'package:bandora_app/notifications/data/repo/notifications_repo.dart';
import 'package:bandora_app/notifications/logic/cubit/notifications_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import '../../helpers/shared_pref_helper.dart';
import '../api/api_factory.dart';
import '../api/api_service.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  try {
    print('🔧 بدء إعداد Dependency Injection...');
    
    // Dio & ApiService
    Dio dio = DioFactory.getDio();
    final navigatorKey = GlobalKey<NavigatorState>();

    getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
    getIt.registerLazySingleton<SharedPrefHelper>(() => SharedPrefHelper());
    getIt.registerSingleton<GlobalKey<NavigatorState>>(navigatorKey);

    // Notification
    getIt.registerLazySingleton<NotificationsDataSource>(() => NotificationsDataSource(getIt()));
    getIt.registerLazySingleton<NotificationsRepo>(() => NotificationsRepo(getIt()));
    getIt.registerFactory<NotificationsCubit>(() => NotificationsCubit(getIt()));

    print('✅ تم إعداد Dependency Injection بنجاح');
  } catch (e) {
    print('❌ خطأ في إعداد Dependency Injection: $e');
    rethrow;
  }
}