// To parse this JSON data, do
//
//     final onlyCatogeryModel = onlyCatogeryModelFromJson(jsonString);

import 'dart:convert';

OnlyCatogeryModel onlyCatogeryModelFromJson(String str) => OnlyCatogeryModel.fromJson(json.decode(str));

String onlyCatogeryModelToJson(OnlyCatogeryModel data) => json.encode(data.toJson());

class OnlyCatogeryModel {
    Data data;
    String status;
    String message;

    OnlyCatogeryModel({
        required this.data,
        required this.status,
        required this.message,
    });

    factory OnlyCatogeryModel.fromJson(Map<String, dynamic> json) => OnlyCatogeryModel(
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
    List<Product> products;
    Category category;

    Data({
        required this.products,
        required this.category,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
        category: Category.fromJson(json["category"]),
    );

    Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "category": category.toJson(),
    };
}

class Category {
    int count;
    String image;
    String categoryName;

    Category({
        required this.count,
        required this.image,
        required this.categoryName,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        count: json["count"],
        image: json["image"],
        categoryName: json["category_name"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "image": image,
        "category_name": categoryName,
    };
}

class Product {
    int id;
    String name;
    int price;
    String image;

    Product({
        required this.id,
        required this.name,
        required this.price,
        required this.image,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "image": image,
    };
}
