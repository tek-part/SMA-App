// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:untitled/core/networking/di/dependency_injection.dart';
// import 'package:untitled/core/router/routers.dart';
//
// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   static bool _isInitialized = false;
//   static bool _permissionsGranted = false;
//
//   /// طلب صلاحيات الإشعارات
//   static Future<bool> requestPermissions() async {
//     try {
//       print('🔐 Requesting notification permissions...');
//
//       // Request FCM permissions
//       NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );
//
//       print('📱 FCM Permission status: ${settings.authorizationStatus}');
//
//       // Request local notification permissions
//       final status = await Permission.notification.request();
//       print('📱 Local Permission status: $status');
//
//       if (Platform.isIOS) {
//         final localSettings = await _notificationsPlugin
//             .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//             ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//         _permissionsGranted = settings.authorizationStatus == AuthorizationStatus.authorized && (localSettings ?? false);
//         print('🍎 iOS notification settings: $_permissionsGranted');
//       } else {
//         _permissionsGranted = settings.authorizationStatus == AuthorizationStatus.authorized && status.isGranted;
//         print('🤖 Android notification permission: $_permissionsGranted');
//       }
//
//       return _permissionsGranted;
//     } catch (e) {
//       print('❌ Error requesting permissions: $e');
//       return false;
//     }
//   }
//
//   /// تهيئة خدمة الإشعارات
//   static Future<void> initialize() async {
//     try {
//       print('🚀 Initializing NotificationService...');
//
//       final permissionGranted = await requestPermissions();
//       if (!permissionGranted) {
//         print('❌ Notification permissions not granted');
//         return;
//       }
//
//       const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
//
//       const DarwinInitializationSettings initializationSettingsIOS =
//       DarwinInitializationSettings(
//         requestAlertPermission: false,
//         requestBadgePermission: false,
//         requestSoundPermission: false,
//       );
//
//       const InitializationSettings initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid,
//         iOS: initializationSettingsIOS,
//       );
//
//       await _notificationsPlugin.initialize(
//         initializationSettings,
//         onDidReceiveNotificationResponse: (NotificationResponse details) {
//           print('📱 Notification tapped: ${details.payload}');
//           // Handle notification tap
//         },
//       );
//
//       // Set up FCM message handlers
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         print('📱 Got a message whilst in the foreground!');
//         print('Message data: ${message.data}');
//
//         if (message.notification != null) {
//           print('Message also contained a notification: ${message.notification}');
//           _showNotification(
//             id: message.hashCode,
//             title: message.notification!.title ?? 'New Message',
//             body: message.notification!.body ?? '',
//             channelId: 'fcm_channel',
//             payload: message.data.toString(),
//           );
//         }
//       });
//
//       // الاستماع عند فتح التطبيق من الإشعار (خلفية/مصغر)
//       FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//         print("🔥 onMessageOpenedApp: oping the app with notification ");
//         print("🔥 notification data: \\${message.data}");
//         print("🔥 notification title: \\${message.notification?.title}");
//         final title = message.notification?.title;
//         if (title == 'تم إضافة رصيد') {
//           navigatorKey.currentState?.pushNamed(Routes.wallet);
//         }
//       });
//
//       // فحص إذا تم فتح التطبيق من إشعار وهو مغلق
//       RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
//       if (initialMessage != null) {
//         print("🔥 getInitialMessage: app opened from notification");
//         print("🔥 notification data: \\${initialMessage.data}");
//         print("🔥 notification title: \\${initialMessage.notification?.title}");
//         final title = initialMessage.notification?.title;
//         if (title == 'تم إضافة رصيد') {
//           navigatorKey.currentState?.pushNamed(Routes.wallet);
//         }
//       }
//
//       if (Platform.isAndroid) {
//         await _createNotificationChannels();
//       }
//
//       _isInitialized = true;
//       print('✅ NotificationService initialized successfully');
//     } catch (e) {
//       print('❌ Error initializing NotificationService: $e');
//     }
//   }
//
//   /// إنشاء قنوات الإشعارات للأندرويد
//   static Future<void> _createNotificationChannels() async {
//     try {
//       const AndroidNotificationChannel cartChannel = AndroidNotificationChannel(
//         'cart_channel',
//         'Cart Notifications',
//         description: 'Notifications for cart updates',
//         importance: Importance.high,
//         playSound: true,
//         enableVibration: true,
//         showBadge: true,
//       );
//
//       const AndroidNotificationChannel testChannel = AndroidNotificationChannel(
//         'test_channel',
//         'Test Notifications',
//         description: 'Test notifications for debugging',
//         importance: Importance.high,
//         playSound: true,
//         enableVibration: true,
//         showBadge: true,
//       );
//
//       const AndroidNotificationChannel generalChannel = AndroidNotificationChannel(
//         'general_channel',
//         'General Notifications',
//         description: 'General app notifications',
//         importance: Importance.defaultImportance,
//         playSound: true,
//         enableVibration: true,
//         showBadge: true,
//       );
//
//       const AndroidNotificationChannel fcmChannel = AndroidNotificationChannel(
//         'fcm_channel',
//         'FCM Notifications',
//         description: 'Firebase Cloud Messaging notifications',
//         importance: Importance.high,
//         playSound: true,
//         enableVibration: true,
//         showBadge: true,
//       );
//
//       const AndroidNotificationChannel apiNotificationsChannel = AndroidNotificationChannel(
//         'api_notifications',
//         'API Notifications',
//         description: 'Notifications from API',
//         importance: Importance.high,
//         playSound: true,
//         enableVibration: true,
//         showBadge: true,
//       );
//
//       const AndroidNotificationChannel pusherNotificationsChannel = AndroidNotificationChannel(
//         'pusher_notifications',
//         'Pusher Notifications',
//         description: 'Real-time notifications from Pusher',
//         importance: Importance.high,
//         playSound: true,
//         enableVibration: true,
//         showBadge: true,
//       );
//
//       await _notificationsPlugin
//           .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//           ?.createNotificationChannel(cartChannel);
//
//       await _notificationsPlugin
//           .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//           ?.createNotificationChannel(testChannel);
//
//       await _notificationsPlugin
//           .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//           ?.createNotificationChannel(generalChannel);
//
//       await _notificationsPlugin
//           .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//           ?.createNotificationChannel(fcmChannel);
//
//       await _notificationsPlugin
//           .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//           ?.createNotificationChannel(apiNotificationsChannel);
//
//       await _notificationsPlugin
//           .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//           ?.createNotificationChannel(pusherNotificationsChannel);
//
//     } catch (e) {
//       print('❌ Error creating notification channels: $e');
//     }
//   }
//
//   /// إظهار إشعار عربة التسوق
//   static Future<void> showCartNotification({
//     required String message,
//     required String title
//   }) async {
//     await _showNotification(
//       id: 0,
//       title: title,
//       body: message,
//       channelId: 'cart_channel',
//     );
//   }
//
//   /// اختبار الإشعارات المحلية فقط
//   static Future<void> testLocalNotificationOnly({
//     String title = 'اختبار الإشعارات المحلية',
//     String body = 'هذا اختبار للإشعارات المحلية فقط',
//   }) async {
//     try {
//       print('🧪 اختبار الإشعارات المحلية فقط...');
//
//       if (!_isInitialized) {
//         await initialize();
//       }
//
//       if (!_permissionsGranted) {
//         return;
//       }
//
//       await _showNotification(
//         id: 999999,
//         title: title,
//         body: body,
//         channelId: 'test_channel',
//         payload: 'test_local_only',
//       );
//     } catch (e) {
//       print('❌ خطأ في اختبار الإشعار المحلي: $e');
//     }
//   }
//
//   /// إظهار إشعار عام
//   static Future<void> _showNotification({
//     required int id,
//     required String title,
//     required String body,
//     required String channelId,
//     String? payload,
//   }) async {
//     try {
//       if (!_isInitialized) {
//         print('⚠️ NotificationService not initialized');
//         return;
//       }
//
//       if (!_permissionsGranted) {
//         print('❌ Notification permissions not granted');
//         return;
//       }
//
//       final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//         channelId,
//         channelId == 'api_notifications' ? 'API Notifications' :
//         channelId == 'pusher_notifications' ? 'Pusher Notifications' :
//         channelId == 'fcm_channel' ? 'FCM Notifications' :
//         'General Notifications',
//         channelDescription: channelId == 'api_notifications' ? 'Notifications from API' :
//         channelId == 'pusher_notifications' ? 'Real-time notifications from Pusher' :
//         channelId == 'fcm_channel' ? 'Firebase Cloud Messaging notifications' :
//         'General app notifications',
//         importance: Importance.high,
//         priority: Priority.high,
//         playSound: true,
//         enableVibration: true,
//         icon: '@mipmap/ic_launcher',
//         color: const Color(0xFF4CAF50),
//         styleInformation: BigTextStyleInformation(body),
//       );
//
//       const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails(
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: true,
//         sound: 'default',
//         badgeNumber: 1,
//       );
//
//       final NotificationDetails notificationDetails = NotificationDetails(
//         android: androidDetails,
//         iOS: iOSDetails,
//       );
//
//       await _notificationsPlugin.show(
//         id,
//         title,
//         body,
//         notificationDetails,
//         payload: payload,
//       );
//
//
//       print('📱 Notification shown with ID: $id');
//     } catch (e) {
//       print('❌ Error showing notification: $e');
//       rethrow;
//     }
//   }
//
//   /// فحص حالة الصلاحيات
//   static Future<bool> checkPermissionStatus() async {
//     try {
//       final status = await Permission.notification.status;
//       final fcmSettings = await FirebaseMessaging.instance.getNotificationSettings();
//       _permissionsGranted = status.isGranted && fcmSettings.authorizationStatus == AuthorizationStatus.authorized;
//       return _permissionsGranted;
//     } catch (e) {
//       return false;
//     }
//   }
//
//   /// الحصول على FCM Token
//   static Future<String?> getFCMToken() async {
//     try {
//       String? token = await FirebaseMessaging.instance.getToken();
//       return token;
//     } catch (e) {
//       return null;
//     }
//   }
//
//   /// فحص حالة الخدمة
//   static bool get isInitialized => _isInitialized;
//   static bool get permissionsGranted => _permissionsGranted;
//
//   /// إعادة تهيئة الخدمة
//   static Future<void> reinitialize() async {
//     print('🔄 Reinitializing NotificationService...');
//     _isInitialized = false;
//     _permissionsGranted = false;
//     await initialize();
//   }
//
//   /// مسح جميع الإشعارات
//   static Future<void> cancelAllNotifications() async {
//     try {
//       await _notificationsPlugin.cancelAll();
//       print('🗑️ All notifications cancelled');
//     } catch (e) {
//       print('❌ Error cancelling notifications: $e');
//     }
//   }
//
//   /// مسح إشعار محدد
//   static Future<void> cancelNotification(int id) async {
//     try {
//       await _notificationsPlugin.cancel(id);
//       print('🗑️ Notification $id cancelled');
//     } catch (e) {
//       print('❌ Error cancelling notification $id: $e');
//     }
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:untitled/core/router/routers.dart';
// import 'package:untitled/main.dart'; // يحتوي على navigatorKey
//
// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   static bool _isInitialized = false;
//   static bool _permissionsGranted = false;
//
//   static Future<bool> requestPermissions() async {
//     try {
//       final settings = await FirebaseMessaging.instance.requestPermission(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//       final localPermission = await Permission.notification.request();
//
//       if (Platform.isIOS) {
//         final iosSettings = await _notificationsPlugin
//             .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
//             ?.requestPermissions(alert: true, badge: true, sound: true);
//         _permissionsGranted = settings.authorizationStatus == AuthorizationStatus.authorized &&
//             (iosSettings ?? false);
//       } else {
//         _permissionsGranted = settings.authorizationStatus == AuthorizationStatus.authorized &&
//             localPermission.isGranted;
//       }
//
//       return _permissionsGranted;
//     } catch (e) {
//       print("❌ Permission error: $e");
//       return false;
//     }
//   }
//
//   static Future<void> initialize({required GlobalKey<NavigatorState> navigatorKey}) async {
//     if (_isInitialized) return;
//
//     final granted = await requestPermissions();
//     if (!granted) return;
//
//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const ios = DarwinInitializationSettings();
//     const initSettings = InitializationSettings(android: android, iOS: ios);
//
//     await _notificationsPlugin.initialize(
//       initSettings,
//       onDidReceiveNotificationResponse: _handleNotificationTap,
//     );
//
//     FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleNotificationNavigation);
//
//     final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
//     if (initialMessage != null) handleNotificationNavigation(initialMessage);
//
//     _isInitialized = true;
//   }
//
//   static void _handleNotificationTap(NotificationResponse response) {
//     final payload = response.payload ?? '';
//     _navigateBasedOnTitle(payload);
//   }
//
//   static void _handleForegroundMessage(RemoteMessage message) {
//     final notification = message.notification;
//     if (notification != null) {
//       _showNotification(
//         id: message.hashCode,
//         title: notification.title ?? 'تنبيه',
//         body: notification.body ?? '',
//         payload: notification.title ?? '',
//         channelId: 'fcm_channel',
//       );
//     }
//   }
//
//   static void handleNotificationNavigation(RemoteMessage message) {
//     final title = message.notification?.title ?? '';
//     _navigateBasedOnTitle(title);
//   }
//
//   static void _navigateBasedOnTitle(String title) {
//     switch (title) {
//       case 'تم إضافة رصيد':
//         navigatorKey.currentState?.pushNamed(Routes.wallet);
//         break;
//       default:
//         print("📭 لم يتم التعرف على العنوان: $title");
//     }
//   }
//
//   static Future<void> _showNotification({
//     required int id,
//     required String title,
//     required String body,
//     required String channelId,
//     String? payload,
//   }) async {
//     final androidDetails = AndroidNotificationDetails(
//       channelId,
//       'تنبيهات التطبيق',
//       importance: Importance.high,
//       priority: Priority.high,
//       playSound: true,
//     );
//     const iosDetails = DarwinNotificationDetails();
//     final details = NotificationDetails(android: androidDetails, iOS: iosDetails);
//
//     await _notificationsPlugin.show(id, title, body, details, payload: payload);
//   }
//
//   static Future<void> cancelAllNotifications() async {
//     await _notificationsPlugin.cancelAll();
//   }
//
//   static Future<bool> checkPermissionStatus() async {
//     final status = await Permission.notification.status;
//     final fcmSettings = await FirebaseMessaging.instance.getNotificationSettings();
//     _permissionsGranted = status.isGranted &&
//         fcmSettings.authorizationStatus == AuthorizationStatus.authorized;
//     return _permissionsGranted;
//   }
//
//   static bool get isInitialized => _isInitialized;
//   static bool get permissionsGranted => _permissionsGranted;
// }


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static bool _isInitialized = false;
  static bool _permissionsGranted = false;

  static Future<bool> requestPermissions() async {
    try {
      final settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      final localPermission = await Permission.notification.request();

      if (Platform.isIOS) {
        final iosSettings = await _notificationsPlugin
            .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(alert: true, badge: true, sound: true);
        _permissionsGranted = settings.authorizationStatus == AuthorizationStatus.authorized && (iosSettings ?? false);
      } else {
        _permissionsGranted =
            settings.authorizationStatus == AuthorizationStatus.authorized &&
                localPermission.isGranted;
      }

      return _permissionsGranted;
    } catch (e) {
      print("❌ Permission error: $e");
      return false;
    }
  }

  static Future<void> initialize({required GlobalKey<NavigatorState> navigatorKey}) async {
    if (_isInitialized) return;

    final granted = await requestPermissions();
    if (!granted) return;

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: android, iOS: ios);

    await _notificationsPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse: (response) {
          final payload = response.payload ?? '';
          _navigateBasedOnTitle(payload, navigatorKey);
        });

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification != null) {
        _showNotification(
          id: message.hashCode,
          title: notification.title ?? '',
          body: notification.body ?? '',
          payload: notification.title ?? '',
          channelId: 'fcm_channel',
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleNotificationNavigation(message, navigatorKey);
    });

    _isInitialized = true;
  }

  static void handleNotificationNavigation(RemoteMessage message, GlobalKey<NavigatorState> navigatorKey) {
    final title = message.notification?.title ?? '';
    _navigateBasedOnTitle(title, navigatorKey);
  }

  static void _navigateBasedOnTitle(String title, GlobalKey<NavigatorState> navigatorKey) {
    switch (title.trim()) {
      case 'تم إضافة رصيد':
       // navigatorKey.currentState?.pushNamed(Routes.wallet);
        break;
      default:
        print("📭 لا يوجد توجيه لهذا العنوان: $title");
    }
  }

  static Future<void> _showNotification({
    required int id,
    required String title,
    required String body,
    required String channelId,
    String? payload,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      channelId,
      'تنبيهات التطبيق',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );
    const iosDetails = DarwinNotificationDetails();
    final details = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _notificationsPlugin.show(id, title, body, details, payload: payload);
  }

  static Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

  static Future<bool> checkPermissionStatus() async {
    final status = await Permission.notification.status;
    final fcmSettings =
    await FirebaseMessaging.instance.getNotificationSettings();
    _permissionsGranted = status.isGranted &&
        fcmSettings.authorizationStatus == AuthorizationStatus.authorized;
    return _permissionsGranted;
  }

  static bool get isInitialized => _isInitialized;
  static bool get permissionsGranted => _permissionsGranted;
}
