// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

LocationModel locationModelFromJson(String str) => LocationModel.fromJson(json.decode(str));

String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
    List<Datum> data;
    String status;
    String message;

    LocationModel({
        required this.data,
        required this.status,
        required this.message,
    });

    factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
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
    String city;
    String street;
    String? flat;
    double lat ;
    double lang ;

    Datum({
        required this.id,
        required this.city,
        required this.street,
        required this.flat,
        required this.lat,
        required this.lang,
    });


    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? 0,
        city: json["city"] ?? '',
        street: json["street"] ?? '',
        flat: json["flat"] ?? '',
        lat:json["lat"] ==null ? 0 : double.parse( json["lat"]) ,
        lang: json["lang"] ==null ? 0 : double.parse(json["lang"]) ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        "street": street,
        "flat": flat,
        "lat": lat,
        "lang": lang,
    };
}
