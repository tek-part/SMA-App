// To parse this JSON data, do
//
//     final brandProdcutModel = brandProdcutModelFromJson(jsonString);

import 'dart:convert';

BrandProdcutModel brandProdcutModelFromJson(String str) => BrandProdcutModel.fromJson(json.decode(str));

String brandProdcutModelToJson(BrandProdcutModel data) => json.encode(data.toJson());

class BrandProdcutModel {
    List<Datum> data;
    String status;
    String message;

    BrandProdcutModel({
        required this.data,
        required this.status,
        required this.message,
    });

    factory BrandProdcutModel.fromJson(Map<String, dynamic> json) => BrandProdcutModel(
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
    String description;
    String image;
    int price;
    String discountPrice;

    Datum({
        required this.id,
        required this.name,
        required this.description,
        required this.image,
        required this.price,
        required this.discountPrice,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        discountPrice: json["discount_price"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
        "discount_price": discountPrice,
    };
}
