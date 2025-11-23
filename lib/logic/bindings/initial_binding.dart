import 'package:get/get.dart';

import '../controller/auth_controller.dart';

class InitialBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(SignupController());
  }

}