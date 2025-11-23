// To parse this JSON data, do
//
//     final contactWitUsModel = contactWitUsModelFromJson(jsonString);

import 'dart:convert';

ContactWitUsModel contactWitUsModelFromJson(String str) => ContactWitUsModel.fromJson(json.decode(str));

String contactWitUsModelToJson(ContactWitUsModel data) => json.encode(data.toJson());

class ContactWitUsModel {
    Data data;
    String status;
    String message;

    ContactWitUsModel({
        required this.data,
        required this.status,
        required this.message,
    });

    factory ContactWitUsModel.fromJson(Map<String, dynamic> json) => ContactWitUsModel(
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
    String facebookLink;
    String instagramLink;
    String whatsappLink;
    String phone;

    Data({
        required this.facebookLink,
        required this.instagramLink,
        required this.whatsappLink,
        required this.phone,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        facebookLink: json["facebook_link"] ?? '',
        instagramLink: json["instagram_link"] ?? '',
        whatsappLink: json["whatsapp_link"] ?? '',
        phone: json["phone"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "facebook_link": facebookLink,
        "instagram_link": instagramLink,
        "whatsapp_link": whatsappLink,
        "phone": phone,
    };
}
