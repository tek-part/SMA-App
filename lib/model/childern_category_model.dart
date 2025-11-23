// To parse this JSON data, do
//
//     final childernCategoryModel = childernCategoryModelFromJson(jsonString);

import 'dart:convert';

ChildernCategoryModel childernCategoryModelFromJson(String str) => ChildernCategoryModel.fromJson(json.decode(str));

String childernCategoryModelToJson(ChildernCategoryModel data) => json.encode(data.toJson());

class ChildernCategoryModel {
    List<Datum> data;
    String status;
    String message;

    ChildernCategoryModel({
        required this.data,
        required this.status,
        required this.message,
    });

    factory ChildernCategoryModel.fromJson(Map<String, dynamic> json) => ChildernCategoryModel(
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
    String name;

    Datum({
        required this.id,
        required this.name,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
