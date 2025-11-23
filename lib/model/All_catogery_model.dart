// To parse this JSON data, do
//
//     final allCatogeryModel = allCatogeryModelFromJson(jsonString);

import 'dart:convert';

AllCatogeryModel allCatogeryModelFromJson(String str) => AllCatogeryModel.fromJson(json.decode(str));

String allCatogeryModelToJson(AllCatogeryModel data) => json.encode(data.toJson());

class AllCatogeryModel {
    List<Datum> data;
    String status;
    String message;

    AllCatogeryModel({
        required this.data,
        required this.status,
        required this.message,
    });

    factory AllCatogeryModel.fromJson(Map<String, dynamic> json) => AllCatogeryModel(
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
    String image;

    Datum({
        required this.id,
        required this.name,
        required this.image,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
    };
}
