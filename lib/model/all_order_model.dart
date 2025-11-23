// To parse this JSON data, do
//
//     final allOrderModel = allOrderModelFromJson(jsonString);

import 'dart:convert';

import 'package:bandora_app/model/details_order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

AllOrderModel allOrderModelFromJson(String str) => AllOrderModel.fromJson(json.decode(str));

String allOrderModelToJson(AllOrderModel data) => json.encode(data.toJson());

class AllOrderModel {
    List<Datum> data;
    String status;
    String message;

    AllOrderModel({
        required this.data,
        required this.status,
        required this.message,
    });

    factory AllOrderModel.fromJson(Map<String, dynamic> json) => AllOrderModel(
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
    dynamic total;
    address addres;
    String createdAt;
    String status;

    Datum({
        required this.id,
        required this.code,
        required this.total,
        required this.addres,
        required this.createdAt,
        required this.status,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        code: json["code"],
        total: json["total"],
        addres: address.fromJson(json["address"]) ,
        createdAt: json["created_at"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "total": total,
        "address": address,
        "created_at": createdAt,
        "status": status,
    };
}


class Morder {

    Morder({
        this.id,
        required  this.name,
        required this.location,
    });

    String? id;
    String name;
    LatLng location;

    factory Morder.fromJson(DocumentSnapshot json) => Morder(
        id: json.id ?? '',
        name: json["name"] ?? '',
        location: json["location"]==null ? LatLng(0,0): LatLng(json["location"].latitude, json["location"].longitude),

    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "location": location,};

}