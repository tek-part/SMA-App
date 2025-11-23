// To parse this JSON data, do
//
//     final detailsOrderModel = detailsOrderModelFromJson(jsonString);

import 'dart:convert';

DetailsOrderModel detailsOrderModelFromJson(String str) =>
    DetailsOrderModel.fromJson(json.decode(str));

String detailsOrderModelToJson(DetailsOrderModel data) =>
    json.encode(data.toJson());

class DetailsOrderModel {
  Data data;
  String status;
  String message;

  DetailsOrderModel({
    required this.data,
    required this.status,
    required this.message,
  });

  factory DetailsOrderModel.fromJson(Map<String, dynamic> json) =>
      DetailsOrderModel(
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
  Details details;

  Data({
    required this.products,
    required this.details,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        details: Details.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "details": details.toJson(),
      };
}

class Details {
  int discountCoupon;
  int deliveryCost;
  int firstCash;
  int finalCash;
  String userName;
  String userPhone;
  String anotherPhone;
  address addres;

  Details({
    required this.discountCoupon,
    required this.deliveryCost,
    required this.firstCash,
    required this.finalCash,
    required this.userName,
    required this.userPhone,
    required this.anotherPhone,
    required this.addres,

  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        discountCoupon: json["discount_coupon"] ?? 0,
        deliveryCost: json["delivery_cost"] ?? 0,
        firstCash: json["first_cash"] ?? 0,
        finalCash: json["final_cash"] ?? 0,
        userName: json["user_name"] ?? '',
        userPhone: json["user_phone"] ?? '',
        anotherPhone: json["another_phone"] ?? '',
        addres: address.fromJson(json["address"]) ,
      );

  Map<String, dynamic> toJson() => {
        "discount_coupon": discountCoupon,
        "delivery_cost": deliveryCost,
        "first_cash": firstCash,
        "final_cash": finalCash,
        "user_name": userName,
        "user_phone": userPhone,
        "another_phone": anotherPhone,
        "address": address,
      };
}

class Product {
  int id;
  int quantity;
  String price;
  String description;
  String name;
  String image;

  Product({
    required this.id,
    required this.quantity,
    required this.price,
    required this.description,
    required this.name,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] ?? 0,
        quantity: json["quantity"] ?? 0,
        price: json["price"] ?? '',
        description: json["description"] ?? '',
        name: json["name"] ?? '',
        image: json["image"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "price": price,
        "description": description,
        "name": name,
        "image": image,
      };
}
class address{
  int id;
  int user_id;
  String city;
  String street;
  String flat;
  String lat;
  String lang;

  address( {required this.id,required this.user_id,required this.city,required this.street,required this.flat,required this.lat,
    required this.lang });

  factory address.fromJson(Map<String, dynamic> json) => address(
      id: json["id"] ?? 0,
      user_id: json["user_id"] ?? 0,
      city: json["city"] ?? '',
      street: json["street"] ?? '',
      flat: json["flat"] ?? '',
      lat: json["lat"] ?? '',
      lang: json["lang"] ?? ''

  );
}