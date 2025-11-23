import 'package:bandora_app/view/screen/setting/map_screen.dart';
import 'package:bandora_app/view/widget/button_utils.dart';
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../logic/controller/location_controller.dart';
import '../../../utils/them.dart';
import '../../widget/profile/contact_text_from_field.dart';

// ignore: must_be_immutable
class AddLocationScreen extends StatelessWidget {
  AddLocationScreen({super.key});

  LocationController controller = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'أضف عنوان'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
            height: 0,
            letterSpacing: -0.30,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: mainColor,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 1,
            child: Form(
              key: controller.fromkey,
              child: Column(
                children: [
                  //google maps
                  GestureDetector(
                    onTap: () {
                      controller.latlatPostition = LatLng(0, 0);
                      Get.to(() => MapScreen(
                            id: 0,
                          ));
                    },
                    child: Container(
                      width: double.infinity,
                      height: Get.height * 0.25,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 0.50, color: GreyClr),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: Get.height * 0.2,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/googlemps.png'),
                                    fit: BoxFit.fill)),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color:
                                      controller.latlatPostition.latitude == 0
                                          ? Colors.redAccent
                                          : Colors.greenAccent,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    TextUtils(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        text: 'تحديد الموقع'.tr),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //location
                  Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: TextUtils(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        text: 'إسم هذا الموقع علي سبيل المثال “ مسكن “'.tr),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ContactTextFormField(
                      keyboardType: TextInputType.name,
                      controller: controller.firstLocation,
                      validator: (value) {
                        controller.validateName(value);
                      },
                      hintText: ''),
                  Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: TextUtils(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        text: 'الشارع'.tr),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ContactTextFormField(
                      keyboardType: TextInputType.name,
                      controller: controller.secondLocation,
                      validator: (value) {
                        controller.validateName(value);
                      },
                      hintText: ''),

                  const SizedBox(
                    height: 25,
                  ),
                  GetBuilder<LocationController>(
                    builder: (_) {
                      return ButtonUtils(
                          text: 'حفظ'.tr,
                          onPressed: () {
                            if (controller.latlatPostition.latitude == 0) {
                              Get.snackbar('home_location'.tr, '',
                                  duration: const Duration(seconds: 1),
                                  backgroundColor: mainColor,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM);
                            } else {
                              controller.addAdress(context);
                            }
                          },
                          colorstext: Colors.black,
                          background: mainColor);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
