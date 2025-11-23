import 'package:bandora_app/model/slider_model.dart';
import 'package:get/get.dart';
import '../../services/main_catogery_services.dart';


class SliderController extends GetxController {
  RxList<Datum> sliderList = <Datum>[].obs;
  var isLoading = true.obs;
  String get defaultImage => sliderList.isNotEmpty
      ? sliderList.first.image
      : "";
  var isContainerVisible = false.obs;


  @override
  void onInit() {
    super.onInit();
    getSlider();
  }

  Future<void> getSlider() async {
    isLoading(true);
    try {
      var response = await SliderServices.getProduct();
      if (response != null && response.data.isNotEmpty) {
        sliderList.assignAll(response.data);
      } else {
        sliderList.clear();
      }
    } catch (e) {
      print("Error fetching slider data: $e");
    } finally {
      isLoading(false);
    }
  }
}
