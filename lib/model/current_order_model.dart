// To parse this JSON data, do
//
//     final currentOrderModel = currentOrderModelFromJson(jsonString);

import 'dart:convert';

CurrentOrderModel currentOrderModelFromJson(String str) => CurrentOrderModel.fromJson(json.decode(str));

String currentOrderModelToJson(CurrentOrderModel data) => json.encode(data.toJson());

class CurrentOrderModel {
    List<Datum> data;
    String status;
    String message;

    CurrentOrderModel({
        required this.data,
        required this.status,
        required this.message,
    });

    factory CurrentOrderModel.fromJson(Map<String, dynamic> json) => CurrentOrderModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
    };
}

class Datum {
    int id;
    String code;
    String createdAt;
    String status;

    Datum({
        required this.id,
        required this.code,
        required this.createdAt,
        required this.status,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        code: json["code"],
        createdAt: json["created_at"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "created_at": createdAt,
        "status": status,
    };
}
