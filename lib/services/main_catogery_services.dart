import 'dart:convert';

import 'package:bandora_app/model/M_representatives.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../model/All_catogery_model.dart';
import '../model/Product_Details_model.dart';
import '../model/all_order_model.dart';
import '../model/brand_model.dart';
import '../model/brand_product_model.dart';
import '../model/cart_item_model.dart';
import '../model/check_out_page_model.dart';
import '../model/childern_category_model.dart';
import '../model/contact_us_model.dart';
import '../model/current_order_model.dart';
import '../model/details_checkout_model.dart';
import '../model/details_order_model.dart';
import '../model/feature_product_model.dart';
import '../model/language_model.dart';
import '../model/location_model.dart';
import '../model/notification_model.dart';
import '../model/offer_model.dart';
import '../model/only_catogery_model.dart';
import '../model/order_status_model.dart';
import '../model/previous_order_model.dart';
import '../model/product_category_model.dart';
import '../model/profile_data_model.dart';
import '../model/repet_order_model.dart';
import '../model/search_model.dart';
import '../model/slider_model.dart';
import '../model/status_model.dart';
import '../utils/my_strings.dart';
import 'dart:io';

import '../view/screen/Auth/signup_screen.dart';



class OnnlyProductServices {
  static Future<OnlyCatogeryModel> getProduct(int pagination) async {
    try {
      const storage = FlutterSecureStorage();

      String token = (await storage.read(key: 'token'))!;
      var response = await http
          .get(Uri.parse('$baseUrl/Category/only?page=$pagination'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        //-> الرقم 200 يعنيان الابي اي صحيح و سليم
        var jsonData = response.body;

        return onlyCatogeryModelFromJson(jsonData);
      } else {
        return throw Exception('Failed to load Product');
      }
    } catch (e) {
      var response = await http.get(
        Uri.parse('$baseUrl/Category/only?page=$pagination'),
      );

      if (response.statusCode == 200) {
        //-> الرقم 200 يعنيان الابي اي صحيح و سليم
        var jsonData = response.body;
        // print(jsonData);

        return onlyCatogeryModelFromJson(jsonData);
      } else {
        return throw Exception('Failed to load Product');
      }
    }
    // if (GetStorage().read<bool>('auth') == true) {
    // } else {}
  }
}

class OfferServices {
  static Future<OfferModel> getProduct(int pagination) async {
    try {
      const storage = FlutterSecureStorage();

      String token = (await storage.read(key: 'token'))!;
      var response = await http
          .get(Uri.parse('$baseUrl/Offer?page=$pagination'), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        //-> الرقم 200 يعنيان الابي اي صحيح و سليم
        var jsonData = response.body;

        return offerModelFromJson(jsonData);
      } else {
        return throw Exception('Failed to load Product');
      }
    } catch (e) {
      var response = await http.get(
        Uri.parse('$baseUrl/Offer?page=$pagination'),
      );

      if (response.statusCode == 200) {
        //-> الرقم 200 يعنيان الابي اي صحيح و سليم
        var jsonData = response.body;

        return offerModelFromJson(jsonData);
      } else {
        return throw Exception('Failed to load Product');
      }
    }
    // if (GetStorage().read<bool>('auth') == true) {
    // } else {

    // }
  }
}

class AllCatogeryServices {
  static Future<AllCatogeryModel> getProduct() async {
    try {
      const storage = FlutterSecureStorage();

      String token = (await storage.read(key: 'token'))!;

      var response = await http.get(Uri.parse('$baseUrl/Category'),
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        //-> الرقم 200 يعنيان الابي اي صحيح و سليم
        var jsonData = response.body;
        return allCatogeryModelFromJson(jsonData);
      } else {
        return throw Exception('Failed to load Product');
      }
    } catch (e) {
      var response = await http.get(
        Uri.parse('$baseUrl/Category'),
      );

      if (response.statusCode == 200) {
        //-> الرقم 200 يعنيان الابي اي صحيح و سليم
        var jsonData = response.body;
        return allCatogeryModelFromJson(jsonData);
      } else {
        return throw Exception('Failed to load Product');
      }
    }
    // if (GetStorage().read<bool>('auth') == true) {

    // } else {

    // }
  }
}

class FeaturedProductServices {
  static Future<FeaturedProductModel> getProduct(int paginatoin) async {
    try {
      const storage = FlutterSecureStorage();

      String token = (await storage.read(key: 'token'))!;
      var response = await http.get(
          Uri.parse('$baseUrl/Product/featured?page=$paginatoin'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });

      if (response.statusCode == 200) {
        //-> الرقم 200 يعنيان الابي اي صحيح و سليم
        var jsonData = response.body;

        return featuredProductModelFromJson(jsonData);
      } else {
        return throw Exception('Failed to load Product');
      }
    } catch (e) {
      var response = await http.get(
        Uri.parse('$baseUrl/Product/featured?page=$paginatoin'),
      );

      if (response.statusCode == 200) {
        //-> الرقم 200 يعنيان الابي اي صحيح و سليم
        var jsonData = response.body;

        return featuredProductModelFromJson(jsonData);
      } else {
        return throw Exception('Failed to load Product');
      }
    }
    // if (GetStorage().read<bool>('auth') == true) {

    // } else {

    // }
  }
}

class BrandServices {
  static Future<BrandModel> getProduct() async {
    try {
      const storage = FlutterSecureStorage();

      String token = (await storage.read(key: 'token'))!;
      var response = await http.get(Uri.parse('$baseUrl/Brand'), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        //-> الرقم 200 يعنيان الابي اي صحيح و سليم
        var jsonData = response.body;

        return brandModelFromJson(jsonData);
      } else {
        return throw Exception('Failed to load Product');
      }
    } catch (e) {
      var response = await http.get(
        Uri.parse('$baseUrl/Brand'),
      );

      if (response.statusCode == 200) {
        //-> الرقم 200 يعنيان الابي اي صحيح و سليم
        var jsonData = response.body;

        return brandModelFromJson(jsonData);
      } else {
        return throw Exception('Failed to load Product');
      }
    }
    // if (GetStorage().read<bool>('auth') == true) {
    // } else {

    // }
  }
}

class SliderServices {
  static Future<SliderModel> getProduct() async {
    var response = await http.get(Uri.parse('$baseUrl/Slider'));

    if (response.statusCode == 200) {
      //-> الرقم 200 يعنيان الابي اي صحيح و سليم
      var jsonData = response.body;

      return sliderModelFromJson(jsonData);
    } else {
      return throw Exception('Failed to load Product');
    }
  }
}

class ChildernCatogeryServices {
  static Future<ChildernCategoryModel> getProduct(int id) async {
    try {
      const storage = FlutterSecureStorage();

      String token = (await storage.read(key: 'token'))!;
      var response = await http.get(
          Uri.parse(
            '$baseUrl/Category/Sub-Category/$id',
          ),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      if (response.statusCode == 200) {
        //-> الرقم 200 يعنيان الابي اي صحيح و سليم
        var jsonData = response.body;

        return childernCategoryModelFromJson(jsonData);
      } else {
        return throw Exception('Failed to load Product');
      }
    } catch (e) {
      var response = await http.get(
        Uri.parse(
          '$baseUrl/Category/Sub-Category/$id',
        ),
      );
      if (response.statusCode == 200) {
        //-> الرقم 200 يعنيان الابي اي صحيح و سليم
        var jsonData = response.body;

        return childernCategoryModelFromJson(jsonData);
      } else {
        return throw Exception('Failed to load Product');
      }
    }
    // if (GetStorage().read<bool>('auth') == true) {
    // } else {

    // }
  }
}

class ProductDetailsServices {
  static Future<ProductDetailsModel> getProduct(int id) async {
    try {
      const storage = FlutterSecureStorage();

      String token = (await storage.read(key: 'token'))!;
      var response = await http.get(
          Uri.parse(
            '$baseUrl/Product/Show/$id',
          ),
          headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        //-> الرقم 200 يعنيان الابي اي صحيح و سليم
        var jsonData = response.body;

        return productDetailsModelFromJson(jsonData);
      } else {
        return throw Exception('Failed to load Product');
      }
    } catch (e) {
      var response = await http.get(
        Uri.parse(
          '$baseUrl/Product/Show/$id',
        ),
      );
      if (response.statusCode == 200) {
        //-> الرقم 200 يعنيان الابي اي صحيح و سليم
        var jsonData = response.body;

        return productDetailsModelFromJson(jsonData);
      } else {
        return throw Exception('Failed to load Product');
      }
    }
    // if (GetStorage().read<bool>('auth') == true) {
    // } else {

    // }
  }
}

class ProductCatogeryServices {
  static Future<ProductCategoryModel> getProduct(int id, int pagination) async {
    try {
      const storage = FlutterSecureStorage();

      String token = (await storage.read(key: 'token'))!;

      var response = await http.get(
          Uri.parse(
            '$baseUrl/Category/Product/$id?page=$pagination',
          ),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      if (response.statusCode == 200) {
        //-> الرقم 200 يعنيان الابي اي صحيح و سليم
        var jsonData = response.body;
        // print(pagination);
        //  print(jsonData);


        return productCategoryModelFromJson(jsonData);
      } else {
        return throw Exception('Failed to load Product');
      }
    } catch (e) {
      var response = await http.get(
        Uri.parse(
          '$baseUrl/Category/Product/$id?page=$pagination',
        ),
      );
      if (response.statusCode == 200) {
        //-> الرقم 200 يعنيان الابي اي صحيح و سليم
        var jsonData = response.body;

        return productCategoryModelFromJson(jsonData);
      } else {
        return throw Exception('Failed to load Product');
      }
    }
    // if (GetStorage().read<bool>('auth') == true) {
    // } else {}
  }
}

class ProfileDataServices {
  static Future<ProfileDataModel> getData() async {
    const storage = FlutterSecureStorage();

    String token = (await storage.read(key: 'token'))!;

    var response = await http.get(Uri.parse('$baseUrl/profile'), headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      //-> الرقم 200 يعنيان الابي اي صحيح و سليم
      var jsonData = jsonDecode(response.body);
      return ProfileDataModel.fromJson(jsonData);
    } else {
      return throw Exception('Failed to load Product');
    }
  }
}

class SearchServices {
  static Future<SerchModel> getProduct(String id) async {
    try {
      const storage = FlutterSecureStorage();

      String token = (await storage.read(key: 'token'))!;
      var response = await http.get(
          Uri.parse(
            '$baseUrl/Search/$id',
          ),
          headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        //-> الرقم 200 يعنيان الابي اي صحيح و سليم
        var jsonData = response.body;

        return serchModelFromJson(jsonData);
      } else {
        return throw Exception('Failed to load Product');
      }
    } catch (e) {
      var response = await http.get(
        Uri.parse(
          '$baseUrl/Search/$id',
        ),
      );
      if (response.statusCode == 200) {
        //-> الرقم 200 يعنيان الابي اي صحيح و سليم
        var jsonData = response.body;

        return serchModelFromJson(jsonData);
      } else {
        return throw Exception('Failed to load Product');
      }
    }
    // if (GetStorage().read<bool>('auth') == true) {
    // } else {}
  }
}

class CartItemServices {
  static Future<CartItemModel> getProduct() async {
    try {
      const storage = FlutterSecureStorage();

      final token = await storage.read(key: 'token');
      if (token == null) {
        print('❌ Token not found in CartItemServices');
        throw Exception('Token not found');
      }
      
      print('🔍 Fetching cart items...');
      var response = await http.get(Uri.parse('$baseUrl/Cart'),
          headers: {'Authorization': 'Bearer $token'});

      print('📡 Cart API Response Status: ${response.statusCode}');
      print('📡 Cart API Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 202) {
        //-> الرقم 200 يعنيان الابي اي صحيح و سليم
        var jsonData = response.body;
        return cartItemModelFromJson(jsonData);
      } else {
        print('❌ Cart API Error: ${response.statusCode} - ${response.body}');
        return throw Exception('Failed to load Cart Item. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ CartItemServices Error: $e');
      throw Exception('Failed to load Cart Item: $e');
    }
  }
}

class LanguageServices {
  static Future<LanguageModel> getProduct(String local) async {
    const storage = FlutterSecureStorage();

    final token = await storage.read(key: 'token');
    if (token == null) {
      throw Exception('Token not found');
    }
    
    var response = await http.get(
        Uri.parse(
          '$baseUrl/language/$local',
        ),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      //-> الرقم 200 يعنيان الابي اي صحيح و سليم
      var jsonData = response.body;

      return languageModelFromJson(jsonData);
    } else {
      return throw Exception('Failed to load Local');
    }
  }
}

class BrandProductServices {
  static Future<BrandProdcutModel> getProduct(int id, int pagination) async {
    try {
      const storage = FlutterSecureStorage();

      final token = await storage.read(key: 'token');
      if (token == null) {
        throw Exception('Token not found');
      }
      var response = await http.get(
          Uri.parse(
            '$baseUrl/Brand/Product/$id?page=$pagination',
          ),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': token
          });
      if (response.statusCode == 200) {
        //-> الرقم 200 يعنيان الابي اي صحيح و سليم
        var jsonData = response.body;

        return brandProdcutModelFromJson(jsonData);
      } else {
        return throw Exception('Failed to load Brand Product');
      }
    } catch (e) {
      var response = await http.get(
        Uri.parse(
          '$baseUrl/Brand/Product/$id?page=$pagination',
        ),
      );
      if (response.statusCode == 200) {
        //-> الرقم 200 يعنيان الابي اي صحيح و سليم
        var jsonData = response.body;

        return brandProdcutModelFromJson(jsonData);
      } else {
        return throw Exception('Failed to load Brand Product');
      }
    }
    // if (GetStorage().read<bool>('auth') == true) {
    // } else {}
  }
}

class LocationServices {
  static Future<LocationModel> getProduct() async {
    const storage = FlutterSecureStorage();

    final token = await storage.read(key: 'token');
    if (token == null) {
      throw Exception('Token not found');
    }
    var response = await http.get(Uri.parse('$baseUrl/profile/address'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200 || response.statusCode == 202) {
      //-> الرقم 200 يعنيان الابي اي صحيح و سليم
      var jsonData = response.body;
      return locationModelFromJson(jsonData);
    } else {
      return throw Exception('Failed to load Cart Item');
    }
  }
}

class CheckOutPageServices {
  static Future<CheckOutPageModel> getProduct() async {
    const storage = FlutterSecureStorage();

    final token = await storage.read(key: 'token');
    if (token == null) {
      throw Exception('Token not found');
    }
    
    try {
      var response = await http.get(Uri.parse('$baseUrl/CheckOut/Order'),
          headers: {'Authorization': 'Bearer $token',
          "Accept":"application/json"});

      if (response.statusCode == 200 || response.statusCode == 202) {
        //-> الرقم 200 يعنيان الابي اي صحيح و سليم
        var jsonData = response.body;
        
        if (jsonData.isEmpty) {
          print('Empty response body received');
          throw Exception('Empty response received from server');
        }
        
        // Check if response is valid JSON
        if (!jsonData.trim().startsWith('{') && !jsonData.trim().startsWith('[')) {
          print('Invalid JSON response received');
          print('Response body: $jsonData');
          throw Exception('Invalid response format from server');
        }
        
        try {
          return checkOutPageModelFromJson(jsonData);
        } catch (e) {
          print('Error parsing JSON: $e');
          print('Response body: $jsonData');
          throw Exception('Failed to parse response data: $e');
        }
      } else if (response.statusCode == 401) {
        print('Unauthorized - Token may be invalid or expired');
        throw Exception('Unauthorized - Please login again');
      } else {
        print('API Error: ${response.statusCode}');
        print('Response body: ${response.body}');
        return throw Exception('Failed to load Cart Item. Status: ${response.statusCode}');
      }
    } catch (e) {
      if (e.toString().contains('SocketException') || e.toString().contains('TimeoutException')) {
        throw Exception('Network error - Please check your connection');
      }
      rethrow;
    }
  }
}

class OrderItemServices {
  static Future<AllOrderModel> getProduct(int page) async {
    const storage = FlutterSecureStorage();

    String token = (await storage.read(key: 'token'))!;
    var response = await http.get(Uri.parse('$baseUrl/Order?page=$page'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200 || response.statusCode == 202) {
      //-> الرقم 200 يعنيان الابي اي صحيح و سليم
      var jsonData = response.body;

      return allOrderModelFromJson(jsonData);
    } else {
      return throw Exception('Failed to load Cart Item');
    }
  }
}

class CurrentOrderItemServices {
  static Future<CurrentOrderModel> getProduct(int pagination) async {
    const storage = FlutterSecureStorage();

    String token = (await storage.read(key: 'token'))!;
    var response = await http.get(
        Uri.parse('$baseUrl/Order/Current?page=$pagination'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200 || response.statusCode == 202) {
      //-> الرقم 200 يعنيان الابي اي صحيح و سليم
      var jsonData = response.body;

      return currentOrderModelFromJson(jsonData);
    } else {
      return throw Exception('Failed to load Cart Item');
    }
  }
}

class PreviousItemServices {
  static Future<PreviousOrderModel> getProduct(int pagination) async {
    const storage = FlutterSecureStorage();

    String token = (await storage.read(key: 'token'))!;
    var response = await http.get(
        Uri.parse('$baseUrl/Order/Previous?page=$pagination'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200 || response.statusCode == 202) {
      //-> الرقم 200 يعنيان الابي اي صحيح و سليم
      var jsonData = response.body;

      return previousOrderModelFromJson(jsonData);
    } else {
      return throw Exception('Failed to load Cart Item');
    }
  }
}

class OrderDetailsServices {
  static Future<DetailsOrderModel> getProduct(int id) async {
    const storage = FlutterSecureStorage();

    String token = (await storage.read(key: 'token'))!;
    var response = await http.get(
        Uri.parse(
          '$baseUrl/Order/Details/$id',
        ),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      //-> الرقم 200 يعنيان الابي اي صحيح و سليم
      var jsonData = response.body;
      return detailsOrderModelFromJson(jsonData);
    } else {
      // print(response.statusCode);
      // print(response.body);
      return throw Exception('Failed to load Order');
    }
  }
}

class CheckOutDetailsServices {
  static Future<DetailsCheckOutModel> getProduct() async {
    const storage = FlutterSecureStorage();

    String token = (await storage.read(key: 'token'))!;
    var response = await http.get(
        Uri.parse(
          '$baseUrl/CheckOut/Details',
        ),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 200) {
      //-> الرقم 200 يعنيان الابي اي صحيح و سليم
      var jsonData = response.body;
      return detailsCheckOutModelFromJson(jsonData);
    } else {
      return throw Exception('Failed to load Check out');
    }
  }
}

class StatusServices {
  static Future<StatusModel> getProduct() async {
    const storage = FlutterSecureStorage();

    String token = (await storage.read(key: 'token'))!;
    var response = await http.get(Uri.parse('$baseUrl/status'), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200 || response.statusCode == 202) {
      //-> الرقم 200 يعنيان الابي اي صحيح و سليم
      var jsonData = response.body;

      return statusModelFromJson(jsonData);
    } else {
      return throw Exception('Failed to load Status');
    }
  }
}

// class NotificatoinServices {
//   static Future<NotificationModel> getProduct() async {
//     const storage = FlutterSecureStorage();
//
//     final token = await storage.read(key: 'token');
//     if (token == null) {
//       throw Exception('Token not found');
//     }
//     var response = await http.get(Uri.parse('$baseUrl/Notification'), headers: {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token'
//     });
//
//     if (response.statusCode == 200 || response.statusCode == 202) {
//       //-> الرقم 200 يعنيان الابي اي صحيح و سليم
//       var jsonData = response.body;
//
//       return notificationModelFromJson(jsonData);
//     } else {
//       response.body ==
//               '{"status":"error","error":{"generic":"Not Authenticated"}}'
//           ? storage.deleteAll()
//           : null;
//       // print(response.body);
//       return throw Exception('Failed to load Notification');
//     }
//   }
// }

class RepetOrderServices {
  static Future<RepeatOrderModel> getProduct(int id) async {
    const storage = FlutterSecureStorage();

    final token = await storage.read(key: 'token');
    if (token == null) {
      throw Exception('Token not found');
    }
    var response = await http.get(Uri.parse('$baseUrl/Order/Repeat/$id'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200 || response.statusCode == 202) {
      //-> الرقم 200 يعنيان الابي اي صحيح و سليم
      var jsonData = response.body;

      return repeatOrderModelFromJson(jsonData);
    } else {
      return throw Exception('Failed to load Notification');
    }
  }
}

class OrderStatusServices {
  static Object? get jsonData => null;

  static Future<OrderStatusModel> getProduct() async {
    const storage = FlutterSecureStorage();

    final token = await storage.read(key: 'token');
    if (token == null) {
      throw Exception('Token not found');
    }
    var response = await http.get(Uri.parse('$baseUrl/Order/status'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200 || response.statusCode == 202) {
      //-> الرقم 200 يعنيان الابي اي صحيح و سليم
      var jsonData = response.body;

      return orderStatusModelFromJson(jsonData);
    } else {
      response.body ==
              '{"status":"error","error":{"generic":"Not Authenticated"}}'
          ?
          //  storage.deleteAll()
          Get.off(() => SignupScreen(), transition: Transition.fade)
          : null;
      return throw Exception('Failed to load order Status');
    }
  }

  static Future get_rate(id) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    if (token == null) {
      throw Exception('Token not found');
    }
    var response = await http.get(Uri.parse('$baseUrl/rate/representatives/$id'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200 || response.statusCode == 202) {
      //-> الرقم 200 يعنيان الابي اي صحيح و سليم
      var jsonData = response.body;
      var _data = jsonDecode(jsonData);
      return  mrepresentativesFromJson( _data['representative']);
    } else {

    }
  }
  static Future post_rateing(body) async {


    const storage = FlutterSecureStorage();

    final token = await storage.read(key: 'token');
    if (token == null) {
      throw Exception('Token not found');
    }
    var response = await http.post(Uri.parse('$baseUrl/rate/ratings'),
        headers: {'Authorization': 'Bearer $token'},body: body );

    if (response.statusCode == 200 || response.statusCode == 202) {
      //-> الرقم 200 يعنيان الابي اي صحيح و سليم
      var jsonData = response.body;
      print(jsonData);

      return true;
    } else {
      return false;
    }
  }



}

class ContactWitUsServices {
  static Object? get jsonData => null;

  static Future<ContactWitUsModel> getProduct() async {
    const storage = FlutterSecureStorage();

    String token = (await storage.read(key: 'token'))!;
    var response = await http.get(Uri.parse('$baseUrl/Connect'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200 || response.statusCode == 202) {
      //-> الرقم 200 يعنيان الابي اي صحيح و سليم
      var jsonData = response.body;

      return contactWitUsModelFromJson(jsonData);
    } else {
      return throw Exception('Failed to load order Status');
    }
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
