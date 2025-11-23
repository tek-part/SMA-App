import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../services/main_catogery_services.dart';
import '../../utils/my_strings.dart';

class SettingController extends GetxController {
  bool change = false;
  var langlocal = ara;

  var storge = GetStorage();
  @override
  void onInit() async {
    langlocal = await getLanguage;
    super.onInit();
  }

  //save
  void saveLanguage(String lang) async {
    await storge.write('lang', lang);
  }

  //اجيب الداتا
  Future<String> get getLanguage async {
    return await storge.read('lang') ?? 'ara';
  }

  //التغير
  void changeLanguage(String typeLang) {
    Get.updateLocale(Locale(typeLang));
    if (langlocal == typeLang) {
      return;
    }
    if (typeLang == ara) {
      langlocal = ara;
      saveLanguage(ara);
       LanguageServices.getProduct(ara);

    } else {
      langlocal = ene;
      saveLanguage(ene);
      LanguageServices.getProduct(ene);
    }
    update();
  }
}
