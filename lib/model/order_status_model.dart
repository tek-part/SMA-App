// To parse this JSON data, do
//
//     final orderStatusModel = orderStatusModelFromJson(jsonString);

import 'dart:convert';

OrderStatusModel orderStatusModelFromJson(String str) => OrderStatusModel.fromJson(json.decode(str));

String orderStatusModelToJson(OrderStatusModel data) => json.encode(data.toJson());

class OrderStatusModel {
    List<OrderStatus> data;
    String status;
    String message;

    OrderStatusModel({
        required this.data,
        required this.status,
        required this.message,
    });

    factory OrderStatusModel.fromJson(Map<String, dynamic> json) => OrderStatusModel(
        data: List<OrderStatus>.from(json["data"].map((x) => OrderStatus.fromJson(x))),
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
    };
}

class OrderStatus {
    int id;
    String representativeName;
    String remaing;
    String status;
    int type;

    OrderStatus({
        required this.id,
        required this.representativeName,
        required this.remaing,
        required this.status,
        required this.type,
    });

    factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
        id: json["id"],
        representativeName: json["representative_name"],
        remaing: json["remaing"],
        status: json["status"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "representative_name": representativeName,
        "remaing": remaing,
        "status": status,
        "type": type,
    };
}
