// To parse this JSON data, do
//
//     final offerModel = offerModelFromJson(jsonString);

import 'dart:convert';

OfferModel offerModelFromJson(String str) => OfferModel.fromJson(json.decode(str));

String offerModelToJson(OfferModel data) => json.encode(data.toJson());

class OfferModel {
    List<Datum> data;
    String status;
    String message;

    OfferModel({
        required this.data,
        required this.status,
        required this.message,
    });

    factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
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
    int productPrice;
    int priceAfterDiscount;
    int offerDiscount;
    String offerName;
    String productName;
    String image;
    String remainingTime;
    String offerStatus;

    Datum({
        required this.id,
        required this.productPrice,
        required this.priceAfterDiscount,
        required this.offerDiscount,
        required this.offerName,
        required this.productName,
        required this.image,
        required this.remainingTime,
        required this.offerStatus,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productPrice: json["productPrice"],
        priceAfterDiscount: json["price_after_discount"],
        offerDiscount: json["OfferDiscount"],
        offerName: json["offerName"],
        productName: json["productName"],
        image: json["image"],
        remainingTime: json["remainingTime"],
        offerStatus: json["offerStatus"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "productPrice": productPrice,
        "price_after_discount": priceAfterDiscount,
        "OfferDiscount": offerDiscount,
        "offerName": offerName,
        "productName": productName,
        "image": image,
        "remainingTime": remainingTime,
        "offerStatus": offerStatus,
    };
}
