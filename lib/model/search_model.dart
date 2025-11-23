// To parse this JSON data, do
//
//     final serchModel = serchModelFromJson(jsonString);

import 'dart:convert';

SerchModel serchModelFromJson(String str) => SerchModel.fromJson(json.decode(str));

String serchModelToJson(SerchModel data) => json.encode(data.toJson());

class SerchModel {
    Data data;
    String status;
    String message;

    SerchModel({
        required this.data,
        required this.status,
        required this.message,
    });

    factory SerchModel.fromJson(Map<String, dynamic> json) => SerchModel(
        data: Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
    };
}

class Data {
    List<Category> product;
    List<Category> category;

    Data({
        required this.product,
        required this.category,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        product: List<Category>.from(json["product"].map((x) => Category.fromJson(x))),
        category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
    };
}

class Category {
    int id;
    String name;

    Category({
        required this.id,
        required this.name,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
