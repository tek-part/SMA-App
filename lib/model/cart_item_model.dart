// To parse this JSON data, do
//
//     final cartItemModel = cartItemModelFromJson(jsonString);

import 'dart:convert';

CartItemModel cartItemModelFromJson(String str) => CartItemModel.fromJson(json.decode(str));

String cartItemModelToJson(CartItemModel data) => json.encode(data.toJson());

class CartItemModel {
    List<Datum> data;
    String status;
    String message;

    CartItemModel({
        required this.data,
        required this.status,
        required this.message,
    });

    factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
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
    int cartId;
    String name;
    String description;
    String image;
    int price;
    int qty;
    int total;

    Datum({
        required this.id,
        required this.cartId,
        required this.name,
        required this.description,
        required this.image,
        required this.price,
        required this.qty,
        required this.total,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        cartId: json["cart_id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        qty: json["qty"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cart_id": cartId,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
        "qty": qty,
        "total": total,
    };
}
