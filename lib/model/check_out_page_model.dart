// To parse this JSON data, do
//
//     final checkOutPageModel = checkOutPageModelFromJson(jsonString);

import 'dart:convert';

CheckOutPageModel checkOutPageModelFromJson(String str) {
  try {
    if (str.isEmpty) {
      print('Empty JSON string received');
      return CheckOutPageModel(
        data: null,
        status: 'error',
        message: 'Empty response received',
      );
    }
    
    final decoded = json.decode(str);
    if (decoded == null) {
      print('Decoded JSON is null');
      return CheckOutPageModel(
        data: null,
        status: 'error',
        message: 'Invalid JSON response',
      );
    }
    
    // Check if decoded is a Map
    if (decoded is! Map<String, dynamic>) {
      print('Decoded JSON is not a Map: ${decoded.runtimeType}');
      return CheckOutPageModel(
        data: null,
        status: 'error',
        message: 'Invalid response format',
      );
    }
    
    return CheckOutPageModel.fromJson(decoded);
  } catch (e) {
    print('Error in checkOutPageModelFromJson: $e');
    print('JSON string: $str');
    // Return a default model
    return CheckOutPageModel(
      data: null,
      status: 'error',
      message: 'Failed to parse JSON: $e',
    );
  }
}

String checkOutPageModelToJson(CheckOutPageModel data) => json.encode(data.toJson());

class CheckOutPageModel {
    // List<Datum> data;
   Datum? data;
    String status;
    String message;

    CheckOutPageModel({
        this.data,
        required this.status,
        required this.message,
    });

    factory CheckOutPageModel.fromJson(Map<String, dynamic> json) {
      try {
        return CheckOutPageModel(
          // data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
          data: json["data"] != null ? Datum.fromJson(json["data"]) : null,
          status: json["status"]?.toString() ?? '',
          message: json["message"]?.toString() ?? '',
        );
      } catch (e) {
        print('Error parsing CheckOutPageModel: $e');
        print('JSON data: $json');
        // Return a default model with null data
        return CheckOutPageModel(
          data: null,
          status: json["status"]?.toString() ?? 'error',
          message: json["message"]?.toString() ?? 'Failed to parse data',
        );
      }
    }

    Map<String, dynamic> toJson() => {
        // "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "data": data?.toJson(),
        "status": status,
        "message": message,
    };
}

class Datum {
    int deliveryCost;
    String address;
    String phone;
    String total;
    String couponDiscount;
    String subTotal;

    Datum({
        required this.deliveryCost,
        required this.address,
        required this.phone,
        required this.total,
        required this.couponDiscount,
        required this.subTotal,
    });

    factory Datum.fromJson(Map<String, dynamic> json) {
      try {
        return Datum(
          deliveryCost: json["delivery_cost"] is int ? json["delivery_cost"] : int.tryParse(json["delivery_cost"]?.toString() ?? '0') ?? 0,
          address: json["address"]?.toString() ?? '',
          phone: json["phone"]?.toString() ?? '',
          total: json["total"]?.toString() ?? '',
          couponDiscount: json["coupon_discount"]?.toString() ?? '',
          subTotal: json["sub_total"]?.toString() ?? '',
        );
      } catch (e) {
        print('Error parsing Datum: $e');
        print('JSON data: $json');
        // Return default values
        return Datum(
          deliveryCost: 0,
          address: '',
          phone: '',
          total: '',
          couponDiscount: '',
          subTotal: '',
        );
      }
    }

    Map<String, dynamic> toJson() => {
        "delivery_cost": deliveryCost,
        "address": address,
        "phone": phone,
        "total": total,
        "coupon_discount": couponDiscount,
        "sub_total": subTotal,
    };
}
