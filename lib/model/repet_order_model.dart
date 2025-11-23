// To parse this JSON data, do
//
//     final repeatOrderModel = repeatOrderModelFromJson(jsonString);

import 'dart:convert';

RepeatOrderModel repeatOrderModelFromJson(String str) => RepeatOrderModel.fromJson(json.decode(str));

String repeatOrderModelToJson(RepeatOrderModel data) => json.encode(data.toJson());

class RepeatOrderModel {
    String data;
    String status;
    String message;

    RepeatOrderModel({
        required this.data,
        required this.status,
        required this.message,
    });

    factory RepeatOrderModel.fromJson(Map<String, dynamic> json) => RepeatOrderModel(
        data: json["data"],
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data,
        "status": status,
        "message": message,
    };
}
