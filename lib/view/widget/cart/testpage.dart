import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controller/location_controller.dart';
import '../../../utils/them.dart';
import '../button_utils.dart';
import '../text_utils.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

LocationController controller = Get.put(LocationController());

class _TestPageState extends State<TestPage> {
  String location = 'العنوان';

  @override
  void initState() {
    location;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: InkWell(
            onTap: () {
              controller.getLocationItem();
              Get.defaultDialog(
                backgroundColor: Colors.white,
                title: '',
                titlePadding: const EdgeInsets.all(0),
                titleStyle: const TextStyle(
                  height: 0,
                  letterSpacing: -0.30,
                ),
                middleText: '',
                actions: [
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const CircularProgressIndicator();
                    }
                    return SizedBox(
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: controller.locationItemList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                location =
                                    controller.locationItemList[index].street;
                                setState(() {});
                                Get.back();
                              },
                              // ignore: avoid_unnecessary_containers
                              child: Container(
                                child: Column(
                                  children: [
                                    Text(controller
                                        .locationItemList[index].street),
                                    const Divider(
                                      height: 2,
                                      color: Colors.black,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ));
                  }),
                  ButtonUtils(
                      text: 'تم'.tr,
                      onPressed: () {
                        Get.back();
                      },
                      colorstext: Colors.black,
                      background: mainColor)
                ],
                middleTextStyle: const TextStyle(
                  height: 0,
                  letterSpacing: -0.30,
                ),
              );
            },
            child: TextUtils(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                text: location),
          ),
        ));
  }
}
