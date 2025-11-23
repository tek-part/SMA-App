// To parse this JSON data, do
//
//     final featuredProductModel = featuredProductModelFromJson(jsonString);

import 'dart:convert';

FeaturedProductModel featuredProductModelFromJson(String str) => FeaturedProductModel.fromJson(json.decode(str));

String featuredProductModelToJson(FeaturedProductModel data) => json.encode(data.toJson());

class FeaturedProductModel {
    List<Datum> data;
    String status;
    String message;

    FeaturedProductModel({
        required this.data,
        required this.status,
        required this.message,
    });

    factory FeaturedProductModel.fromJson(Map<String, dynamic> json) => FeaturedProductModel(
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
    int price;

    Datum({
        required this.id,
        required this.name,
        required this.image,
        required this.price,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
    };
}
