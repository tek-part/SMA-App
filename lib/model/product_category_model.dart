// To parse this JSON data, do
//
//     final productCategoryModel = productCategoryModelFromJson(jsonString);

import 'dart:convert';

ProductCategoryModel productCategoryModelFromJson(String str) => ProductCategoryModel.fromJson(json.decode(str));

String productCategoryModelToJson(ProductCategoryModel data) => json.encode(data.toJson());

class ProductCategoryModel {
    List<Datum> data;
    String status;
    String message;

    ProductCategoryModel({
        required this.data,
        required this.status,
        required this.message,
    });

    factory ProductCategoryModel.fromJson(Map<String, dynamic> json) => ProductCategoryModel(
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
    dynamic discountPrice;

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
