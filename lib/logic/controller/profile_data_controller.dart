import 'package:bandora_app/model/profile_data_model.dart';
import 'package:get/get.dart';

import '../../services/main_catogery_services.dart';

class ProfileDataController extends GetxController {
  List<Datum> productCategoryList = <Datum>[].obs;
  var isLoading = true.obs;
  var emty = false.obs;
  @override
  void onInit() {
    getProfileData();
    super.onInit();
  }

  getProfileData() async {
    try {
      isLoading(true);
      try {
        print('loading');
        var data = await ProfileDataServices.getData();
        isLoading(true);
        if (data.data.isNotEmpty) {
          productCategoryList.addAll(data.data);
        }
      } finally {
        isLoading(false);
      }
    } catch (e) {
      print('object');
      emty(true);
      isLoading(false);
    }
    update();
  }
}
