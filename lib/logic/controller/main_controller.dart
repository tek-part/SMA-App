import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../view/screen/main/cart_screen.dart';
import '../../view/screen/main/fav_screen.dart';
import '../../view/screen/main/home_screen.dart';
import '../../view/screen/main/profile_screen.dart';
import '../../view/screen/main/search_screen.dart';

class Maincontroller extends GetxController {
  var token = '';
  final storage = const FlutterSecureStorage();

  RxInt currentIndex = 0.obs;
  final tabs = [
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    FavScreen(),
    ProfileScreen()
  ].obs;

  authData() async {
    token = (await storage.read(key: 'token'))!;
  }

  bool isAuth() {

    return token.isNotEmpty;
  }

  @override
  void onInit() {
    isAuth();
    super.onInit();
  }
}
