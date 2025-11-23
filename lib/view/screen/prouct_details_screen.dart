import 'package:bandora_app/view/widget/button_utils.dart';
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

import '../../logic/controller/cart_controller.dart';
import '../../logic/controller/product_details_controller.dart';
import '../../routes/routes.dart';
import '../../utils/them.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key});

  ProductDetails controller = Get.put(ProductDetails());
  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تفاصيل المنتج'.tr,
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
      body: GetBuilder<ProductDetails>(
        builder: (_) {
          if (controller.productDetailsList.isEmpty ||
              controller.name.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  //details
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 0.50, color: Color(0xFFCED5E1)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x7FCCCCCD),
                          blurRadius: 1,
                          offset: Offset(1, 0.50),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //image
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.width / 2.5,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(controller.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            //name
                            Align(
                              alignment: AlignmentDirectional.bottomStart,
                              child: TextUtils(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                text: controller.name,
                              ),
                            ),
                            const SizedBox(height: 8),
                            //describtion
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                controller.description,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Color(0xFF888888),
                                  fontSize: 14,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.clip,
                                  height: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Align(
                            //   alignment: AlignmentDirectional.bottomStart,
                            //   child: TextUtils(
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.w500,
                            //       color: Colors.black,
                            //       text: '${controller.price} د.ع'),
                            // )
                          ],
                        ),
                        Obx(() {
                          return PositionedDirectional(
                            top: 0,
                            start: 0,
                            child: InkWell(
                                onTap: () {
                                  GetStorage().read<bool>('auth') ==
                                          true
                                      ? controller.manageFavourites(
                                          controller.idd)
                                      : Get.defaultDialog(
                                          backgroundColor: Colors.white,
                                          title: '',
                                          titlePadding:
                                              const EdgeInsets.all(0),
                                          titleStyle: const TextStyle(
                                            height: 0,
                                            letterSpacing: -0.30,
                                          ),
                                          middleText: '',
                                          actions: [
                                            SizedBox(
                                              width: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                children: [
                                                  Lottie.asset(
                                                      'assets/lottie/Animation - 1700588382977.json',
                                                      height: 100,
                                                      width: 100,
                                                      fit: BoxFit
                                                          .contain),
                                                  TextUtils(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight
                                                              .w500,
                                                      color: mainColor,
                                                      text:
                                                          'انتبه!'.tr),
                                                  SizedBox(
                                                    width: 201.87,
                                                    child: Text(
                                                      "يجب عليك تسجيل الدخول اولا "
                                                          .tr,
                                                      textAlign:
                                                          TextAlign
                                                              .center,
                                                      style:
                                                          const TextStyle(
                                                        color: GreyClr,
                                                        fontSize: 14,
                                                        fontFamily:
                                                            'Cairo',
                                                        fontWeight:
                                                            FontWeight
                                                                .w500,
                                                        height: 0,
                                                        letterSpacing:
                                                            -0.30,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            ButtonUtils(
                                                text: 'تسجيل الدخول'.tr,
                                                onPressed: () {
                                                  Get.offNamed(Routes
                                                      .signupScreen);
                                                },
                                                colorstext:
                                                    Colors.black,
                                                background: mainColor)
                                          ],
                                          middleTextStyle:
                                              const TextStyle(
                                            height: 0,
                                            letterSpacing: -0.30,
                                          ),
                                        );
                                },
                                child: controller
                                        .isFavourites(controller.idd)
                                    ? Icon(
                                        Icons.favorite,
                                        color: Get.isDarkMode
                                            ? mainColor
                                            : mainColor,
                                        size: 35,
                                      )
                                    : Icon(
                                        Icons.favorite_border_outlined,
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        size: 35,
                                      )),
                          );
                        }),
                        Obx(() {
                          return PositionedDirectional(
                            bottom: 0,
                            end: 0,
                            child: Row(
                              children: [
                                //add
                                AM(
                                  onTap: () {
                                    cartController.add();
                                  },
                                  colors: mainColor,
                                  icons: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5),
                                  child: TextUtils(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      text:
                                          '${cartController.qty.value}'),
                                ),
                                //minus
                                AM(
                                  onTap: () {
                                    cartController.min();
                                  },
                                  colors: const Color(0xFFF6F9FF),
                                  icons: const Icon(
                                    Icons.remove,
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  //button
                  ButtonUtils(
                      text: 'إضافة إلي السلة'.tr,
                      onPressed: () {
                        cartController.postCartData(
                            controller.productDetailsList[0].id.toString());
                      },
                      colorstext: Colors.black,
                      background: mainColor)
                ],
              ),
            );
          }
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget AM({
    required Color colors,
    required Icon icons,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
            color: colors,
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: Align(alignment: Alignment.center, child: icons),
      ),
    );
  }
}
