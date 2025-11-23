// To parse this JSON data, do
//
//     final statusModel = statusModelFromJson(jsonString);

import 'dart:convert';

StatusModel statusModelFromJson(String str) => StatusModel.fromJson(json.decode(str));

String statusModelToJson(StatusModel data) => json.encode(data.toJson());

class StatusModel {
    String status;
    Data data;

    StatusModel({
        required this.status,
        required this.data,
    });

    factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    bool status;
    int remaining;

    Data({
        required this.status,
        required this.remaining,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        remaining: json["remaining"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "remaining": remaining,
    };
}
