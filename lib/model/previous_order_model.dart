// To parse this JSON data, do
//
//     final previousOrderModel = previousOrderModelFromJson(jsonString);

import 'dart:convert';

PreviousOrderModel previousOrderModelFromJson(String str) => PreviousOrderModel.fromJson(json.decode(str));

String previousOrderModelToJson(PreviousOrderModel data) => json.encode(data.toJson());

class PreviousOrderModel {
    List<Datum> data;
    String status;
    String message;

    PreviousOrderModel({
        required this.data,
        required this.status,
        required this.message,
    });

    factory PreviousOrderModel.fromJson(Map<String, dynamic> json) => PreviousOrderModel(
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
