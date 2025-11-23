import 'package:get/get.dart';

import '../../services/main_catogery_services.dart';

class LanguageController extends GetxController {
  void getLanguage(String local) async {
    // ignore: unused_local_variable
    var products = await LanguageServices.getProduct(local);
  }
}
