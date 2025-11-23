import 'package:get/get.dart';

import '../utils/my_strings.dart';
import 'ar.dart';
import 'en.dart';

class LocalizationApp extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {ene: en, ara: ar};
}
