import 'package:bandora_app/view/screen/setting/update_location_screen.dart';
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../logic/controller/location_controller.dart';
import '../../../utils/them.dart';
import 'add_location_screen.dart';

// ignore: must_be_immutable
class ChooseLocationScreen extends StatelessWidget {
  ChooseLocationScreen({super.key});

  LocationController controller = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تحديد العنوان'.tr,
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
      body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 1,
          // color: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GetBuilder<LocationController>(
            builder: (_) {
              if (controller.locationItemList.isEmpty) {
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    TextUtils(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: mainColor,
                        text: ' العناوين'.tr),
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        // color: Colors.green,
                        child: Center(
                          child: Lottie.asset(
                              'assets/lottie/Animation - 1700718358881.json',
                              height: MediaQuery.of(context).size.height / 5,
                              width: MediaQuery.of(context).size.width / 1.5,
                              fit: BoxFit.contain),
                        )),
                    InkWell(
                      onTap: () {
                        controller.latlatPostition = LatLng(0, 0);

                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: AddLocationScreen(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.add,
                            color: mainColor,
                            size: 24,
                          ),
                          TextUtils(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: mainColor,
                              text: ' أضف عنوان جديد'.tr)
                        ],
                      ),
                    )
                  ],
                );
              }
              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  TextUtils(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: mainColor,
                      text: ' العناوين'.tr),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    // color: Colors.green,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.locationItemList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return LocationList(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: UpdateLocationScreen(
                                  id: controller.locationItemList[index].id,
                                ),
                                withNavBar:
                                    true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );

                              controller.updateFirstLocation.text =
                                  controller.locationItemList[index].city;
                              controller.updateSecondLocation.text =
                                  controller.locationItemList[index].street;
                              controller.latlatPostition = LatLng(
                                  controller.locationItemList[index].lat,
                                  controller.locationItemList[index].lang);
                            },
                            title: controller.locationItemList[index].city,
                            body: controller.locationItemList[index].street,
                            height: MediaQuery.of(context).size.height / 8,
                            check_map:
                                controller.locationItemList[index].lang != 0);
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.latlatPostition = LatLng(0, 0);
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: AddLocationScreen(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add,
                          color: mainColor,
                          size: 24,
                        ),
                        TextUtils(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: mainColor,
                            text: ' أضف عنوان جديد'.tr)
                      ],
                    ),
                  )
                ],
              );
            },
          )),
    );
  }

  // ignore: non_constant_identifier_names
  Widget LocationList({
    required double height,
    required String title,
    required String body,
    required bool check_map,
    required Function() onTap,
  }) {
    return Container(
        width: double.infinity,
        // height: height,
        margin: const EdgeInsetsDirectional.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFF7785DB)),
            borderRadius: BorderRadius.circular(4),
          ),
          shadows: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 1,
              offset: Offset(0.50, 1),
              spreadRadius: 0,
            )
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextUtils(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: mainColor,
                        text: title),
                    SizedBox(
                      width: 25,
                    ),
                    Icon(Icons.location_on_outlined,
                        color:
                            check_map ? Colors.greenAccent : Colors.redAccent)
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  body,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontFamily: 'Cairo',
                      overflow: TextOverflow.fade),
                ),
              ],
            ),
            PositionedDirectional(
                top: 5,
                end: 5,
                child: InkWell(
                    onTap: onTap,
                    child: SvgPicture.asset('assets/images/edit.svg')))
          ],
        ));
  }
}
