// // To parse this JSON data, do
// //
// //     final notificationModel = notificationModelFromJson(jsonString);
//
// import 'dart:convert';
//
// NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));
//
// String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());
//
// class NotificationModel {
//     List<Datum> data;
//     String status;
//     String message;
//
//     NotificationModel({
//         required this.data,
//         required this.status,
//         required this.message,
//     });
//
//     factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
//         data: List<Datum>.from((json["data"] as List).map((x) => Datum.fromJson(x))),
//         status: json["status"],
//         message: json["message"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "status": status,
//         "message": message,
//     };
// }
//
// class Datum {
//     String id;
//     int orderId;
//     Content content;
//     String date;
//
//     Datum({
//         required this.id,
//         required this.orderId,
//         required this.content,
//         required this.date,
//     });
//
//     factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         orderId: json["order_id"],
//         content: Content.fromJson(json["content"]),
//         date: json["date"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "order_id": orderId,
//         "content": content.toJson(),
//         "date": date,
//     };
// }
//
// class Content {
//     String title;
//     String content;
//
//     Content({
//         required this.title,
//         required this.content,
//     });
//
//     factory Content.fromJson(Map<String, dynamic> json) => Content(
//         title: json["title"],
//         content: json["content"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "title": title,
//         "content": content,
//     };
// }
