// import 'package:bandora_app/utils/my_strings.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl_phone_field/phone_number.dart';

// import '../../core/class/status_request.dart';

// class AuthControllerIMP extends GetxController {
//   final fromkey = GlobalKey<FormState>();
//   TextEditingController firstName = TextEditingController();
//   TextEditingController secondName = TextEditingController();
//   TextEditingController phone = TextEditingController();
//   late StatusRequest statusRequest;
//   var headers = {
//     'Authorization':
//         'Bearer 10|c5Syg6ceHgBVOI9R24kPGbwahdHcrXXGul5BWFO769ec2d77'
//   };
//   @override
//   void onInit() {
//     firstName = TextEditingController();
//     secondName = TextEditingController();
//     phone = TextEditingController();

//     super.onInit();
//   }

//   @override
//   void dispose() {
//     firstName.dispose();
//     secondName.dispose();
//     phone.dispose();

//     super.dispose();
//   }

//   Future authLogin() async {
//     statusRequest = StatusRequest.loding;

//     http.Response response = await http.post(
//         Uri.parse('$baseUrl/Auth-Phone/redirect'),
//         headers: headers,
//         body: {
//           'first_name': firstName.text,
//           'last_name': secondName.text,
//           'phone': phone.text
//         });
//     if (response.statusCode == 200 || response.statusCode == 202) {
//       statusRequest = StatusRequest.success;
//       // ok here after success will navigate to verfyCode right 
//       // after verfyCode will send req and response will be  {"token"=>"6949a47106a4564"}
//       //use sharedPref 
//       myServices.sharedPreferences.setString("token","Bearer 10|c5Syg6ceHgBVOI9R24kPGbwahdHcrXXGul5BWFO769ec2d77");//set key of var to know how to get it in any time
//       // dont froget thats dynamic i just write any thing 
//       //ok how to get it in any screen 
//       myServices.sharedPreferences.getString("token");// here write key you set it to get var or details ok 

//     // how to send dynamic headers unq for evrey user 
//     Map<String,String> headers ={"authorization":myServices.sharedPreferences.getString("token").toString()}; // here finaly evrey req will send headers you save it(token) from begain when Auth 
//     // headears will declaretive it in evrey screen 
    
//           print(response.body);
//     } else {
//       return print('you have error');
//     }
//     update();
//   }
// }

