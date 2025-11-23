// import 'dart:convert';
// import 'dart:io';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart'as http;
//
// // دالة static للتعامل مع إشعارات Awesome Notifications
// @pragma('vm:entry-point')
// Future<void> onActionNotificationMethod(ReceivedAction receivedAction) async {
//   // معالجة الإشعارات في الخلفية
//   print('🔔 Notification action received: ${receivedAction.payload}');
// }
//
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// // NotificationService notificationService = NotificationService();
//   await Firebase.initializeApp();
//   // await notificationService.init();
//   //  showFlutterNotification(message);
// }
//
// showFlutterNotification(RemoteMessage message) async {
//   // NotificationService notificationService = NotificationService();
//   RemoteNotification? notification = message.notification;
//   AndroidNotification? android = message.notification?.android;
//   if (notification != null ) {
//     // if (notification != null && android != null && !kIsWeb) {
//     // notificationService.showNotification(1, notification.title!, notification.body!,{
//     //   "title": notification.body!,
//     //   "eventDate":  'new',
//     //   "eventTime": 'ddd',
//     // });
//   }
// }
//
// Future<void> sendAndroidNotification(id_token,title,body) async {
//   String? _token = id_token;
//   try {
//     http.Response response = await http.post(
//       Uri.parse('https://fcm.googleapis.com/fcm/send'),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization': 'key=AAAAdpig9M8:APA91bGN8JXgaJPvm8lwb866YEyM7aYnt36Kfrkj2bG1u6olzj5_NMi5X20BkcaeyR3orbgZGPg8fDsEPzoiq6GtATQObK2GOFn1HojXwAAqS4myIRiFIDTSTBi4mQr0uzxC4aRR3xLM',
//       },
//       body: jsonEncode(
//         <String, dynamic>{
//           'priority': 'high',
//           'data': <String, dynamic>{
//             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//             'status': 'done',
//             'body': 'ahmed',
//             'title': 'Nueva Solicitud',
//           },
//           'notification': <String, dynamic>{
//             'body': body,
//             'title': title,
//             'android_channel_id': 'dbfood'
//           },
//           'to': _token
//         },
//       ),
//     );
//     if(response == 200){
//       print('ok');
//     }else{
//       print('error');
//     }
//   } catch (e) {
//     print(e);
//   }
// }
//
// class NotificationService{
//   static ReceivedAction? initialAction;
//   Future<void> init() async {
//     await AwesomeNotifications().initialize(
//         'resource://mipmap/ic_launcher',
//         [
//           NotificationChannel(
//               channelKey: 'Notification',
//               channelName: 'text Notification',
//               channelDescription: 'Notification tests as alerts',
//               playSound: true,
//               onlyAlertOnce: true,
//               channelShowBadge: true,
//               groupAlertBehavior: GroupAlertBehavior.Children,
//               importance: NotificationImportance.High,
//               defaultPrivacy: NotificationPrivacy.Private,
//               defaultColor: Colors.deepPurple,
//               ledColor: Colors.deepPurple)
//         ], debug: true);
//     // Get initial notification action is optional
//     initialAction = await AwesomeNotifications().getInitialNotificationAction(removeFromActionEvents: false);
//     AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//       if (!isAllowed) {
//         AwesomeNotifications().requestPermissionToSendNotifications();
//       }
//     });
//   }
//   Future<void> showNotification(int id, String title, String body, payload,String image) async {
//     AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: id,
//           channelKey: 'Notification',
//           title: title,
//           body: body,
//           notificationLayout: NotificationLayout.BigPicture,
//           // bigPicture: "https://i0.wp.com/devhq.in/wp-content/uploads/2024/07/2.png?w=1280&ssl=1",
//           bigPicture: 'asset://'+image,
//           category: NotificationCategory.Service,
//           // notificationLayout: NotificationLayout.ProgressBar,
//           // notificationLayout: NotificationLayout.Messaging,
//           // notificationLayout: NotificationLayout.MessagingGroup,
//           // notificationLayout: NotificationLayout.MediaPlayer,
// // notificationLayout: NotificationLayout.MediaPlayer,
//           // notificationLayout: NotificationLayout.BigText,
//           // notificationLayout: NotificationLayout.Inbox,
//           // actionType: ActionType.Default,
//           actionType: ActionType.SilentAction,
//           // payload: {'title': body},
//           payload: {'key1': 'value1', 'key2': 'value2'},
//           displayOnBackground: true,
//           displayOnForeground: true,
//           progress: 35,
//         ),
//         // actionButtons: [
//         //   NotificationActionButton(
//         //     key: "cancel",
//         //     label: "Cancel",
//         //     actionType: ActionType.SilentAction,
//         //   ),
//         //   NotificationActionButton(
//         //     key: "confirm",
//         //     label: "Confirm",
//         //     actionType: ActionType.SilentAction,
//         //     isDangerousOption: true,
//         //   ),
//         // ],
//         actionButtons: [
//           NotificationActionButton(
//               key: 'SHOW_SERVICE_DETAILS',
//               label: 'Show details'
//           )
//         ]
//     );
//     await onSelectNotification(payload);
//   }
//   Future<void> scheduleNotification(int id, String title, String body,
//       DateTime eventDate, TimeOfDay eventTime,  payload,) async {
//     final scheduledTime = eventDate.add(Duration(hours: eventTime.hour, minutes: eventTime.minute,));
//     AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: id,
//           channelKey: 'Notification',
//           title: title,
//           body: body,
//           actionType: ActionType.Default,
//           payload: payload,
//           displayOnBackground: true,
//           displayOnForeground: true,
//           wakeUpScreen: true,
//           category: NotificationCategory.Alarm,
//         ),
//         schedule: NotificationCalendar.fromDate(date: scheduledTime.add(const Duration(seconds: 10)))
//     );
//     print(scheduledTime);
//     await onSelectNotification(payload);
//   }
//   resetBadgeCounter() async {
//     await AwesomeNotifications().resetGlobalBadge();
//   }
//   cancelNotifications() async {
//     await AwesomeNotifications().cancelAll();
//   }
//   Future<void> onSelectNotification(Map? payload) async {
//     AwesomeNotifications().setListeners(
//       onActionReceivedMethod: (ReceivedAction receivedAction) async {
//         badge_app(2);
//         // await navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => Show_Notification_Details_Page(payload: payload)));
//       },
//       // onNotificationCreatedMethod: (ReceivedNotification receivedNotification)async {
//       //   badge_app();
//       // },
//       // onNotificationDisplayedMethod: (ReceivedNotification receivedNotification)async{
//       //   badge_app();
//       // },
//       onDismissActionReceivedMethod: (ReceivedAction receivedAction) async{
//         badge_app(2);
//       },
//     );
//   }
//   badge_app(val){
//     if(Platform.isIOS){
//       if(val ==1){
//         AwesomeNotifications().getGlobalBadgeCounter().then((value) => AwesomeNotifications().setGlobalBadgeCounter(value +1) );
//       }else{
//         AwesomeNotifications().getGlobalBadgeCounter().then((value) => AwesomeNotifications().setGlobalBadgeCounter(value -1) );
//       }
//     }
//   }
// }