import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthDataController extends GetxController{
  var storge =const FlutterSecureStorage();
  var phone=''.obs;
  var token='';
  @override
  void onInit() {
  autData();
    super.onInit();
  }
  autData()async{
    phone.value=(await storge.read(key: 'phone'))!;
    token=(await storge.read(key: 'token'))!;
    
  }
  bool isAuth(){
    print('+++++++++++++$token');
    return token.isNotEmpty;
  }
}