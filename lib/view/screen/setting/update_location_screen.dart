import 'package:bandora_app/view/screen/setting/map_screen.dart';
import 'package:bandora_app/view/widget/button_utils.dart';
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controller/location_controller.dart';
import '../../../utils/them.dart';
import '../../widget/profile/contact_text_from_field.dart';

// ignore: must_be_immutable
class UpdateLocationScreen extends StatelessWidget {
  UpdateLocationScreen({super.key, required this.id});

  final int id;
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
      body: Form(
        key: controller.fromkey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height / 1,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                //google maps
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 4.2,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 0.50, color: GreyClr),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () => Get.to(() => MapScreen(
                          id: id,
                        )),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 141,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/googlemps.png'),
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
                                color: controller.latlatPostition.latitude == 0
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
                    controller: controller.updateFirstLocation,
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
                    controller: controller.updateSecondLocation,
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
                        text: 'حفظ',
                        onPressed: () {
                          controller.updateAdress(id, context);
                          // Navigator.of(context).pop();
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
    );
  }
}
