import 'dart:io';
import 'package:bandora_app/core/notification_services/device_token.dart';
import 'package:bandora_app/core/notification_services/notification_services.dart';
import 'package:bandora_app/routes/routes.dart';
import 'package:bandora_app/services/main_catogery_services.dart';
import 'package:bandora_app/utils/them.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:upgrader/upgrader.dart';
import 'core/helpers/bloc_observer.dart';
import 'language/localization.dart';
import 'core/networking/di/dependency_injection.dart';
import 'core/helpers/shared_pref_helper.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationService.handleNotificationNavigation(message, navigatorKey);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await NotificationService.initialize(navigatorKey: navigatorKey);
  await NotificationService.checkPermissionStatus();
  await DeviceToken.getDeviceToken();
  DeviceToken.setupTokenRefreshListener();

  final RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    NotificationService.handleNotificationNavigation(initialMessage, navigatorKey);
  }
    
    HttpOverrides.global = MyHttpOverrides();
    
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    await Upgrader.clearSavedSettings();
    await GetStorage.init();
    
    await SharedPrefHelper.initialize();
    
    await setupGetIt();

    Bloc.observer = AppBlocObserver();
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    runApp(const MyApp());
  } catch (e) {
    print('❌ خطأ في تشغيل التطبيق: $e');
    rethrow;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // تصميم iPhone X
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
    return GetMaterialApp(
      title: 'SMA',
      debugShowCheckedModeBanner: false,
      theme: themsApp.light,
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
      locale: Locale(GetStorage().read<String>('lang').toString()),
      fallbackLocale: const Locale('ar','en'),
      translations: LocalizationApp(),
        );
      },
    );
  }
}
