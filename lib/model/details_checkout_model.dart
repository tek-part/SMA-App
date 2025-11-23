// To parse this JSON data, do
//
//     final detailsCheckOutModel = detailsCheckOutModelFromJson(jsonString);

import 'dart:convert';

DetailsCheckOutModel detailsCheckOutModelFromJson(String str) => DetailsCheckOutModel.fromJson(json.decode(str));

String detailsCheckOutModelToJson(DetailsCheckOutModel data) => json.encode(data.toJson());

class DetailsCheckOutModel {
    Data data;
    String status;
    String message;

    DetailsCheckOutModel({
        required this.data,
        required this.status,
        required this.message,
    });

    factory DetailsCheckOutModel.fromJson(Map<String, dynamic> json) => DetailsCheckOutModel(
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
    List<Product> product;
    Details details;

    Data({
        required this.product,
        required this.details,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        product: List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
        details: Details.fromJson(json["details"]),
    );

    Map<String, dynamic> toJson() => {
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
        "details": details.toJson(),
    };
}

class Details {
    int deliveryCost;
    String total;
    String couponDiscount;
    String subTotal;

    Details({
        required this.deliveryCost,
        required this.total,
        required this.couponDiscount,
        required this.subTotal,
    });

    factory Details.fromJson(Map<String, dynamic> json) => Details(
        deliveryCost: json["delivery_cost"],
        total: json["total"],
        couponDiscount: json["coupon_discount"],
        subTotal: json["sub_total"],
    );

    Map<String, dynamic> toJson() => {
        "delivery_cost": deliveryCost,
        "total": total,
        "coupon_discount": couponDiscount,
        "sub_total": subTotal,
    };
}

class Product {
    int id;
    String name;
    String description;
    String image;
    int quantity;
    int price;

    Product({
        required this.id,
        required this.name,
        required this.description,
        required this.image,
        required this.quantity,
        required this.price,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        quantity: json["quantity"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "quantity": quantity,
        "price": price,
    };
}
