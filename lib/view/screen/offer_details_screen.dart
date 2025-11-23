import 'package:bandora_app/view/widget/button_utils.dart';
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/controller/cart_controller.dart';
import '../../logic/controller/product_details_controller.dart';
import '../../utils/them.dart';

// ignore: must_be_immutable
class OfferDetailsScreen extends StatelessWidget {
  OfferDetailsScreen({super.key});

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
      body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: GetBuilder<ProductDetails>(
            builder: (_) {
              if (controller.productDetailsList.isEmpty ||
                  controller.name.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //details
                    Container(
                        width: MediaQuery.of(context).size.width / 1,
                        // height: MediaQuery.of(context).size.height / 4,
                        padding: const EdgeInsets.only(
                            right: 16, left: 20, bottom: 20, top: 5),
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
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //image
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      height:
                                          MediaQuery.of(context).size.width / 4,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(controller.image),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    //name
                                    Align(
                                      alignment:
                                          AlignmentDirectional.bottomStart,
                                      child: TextUtils(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        text: controller.name,
                                      ),
                                    ),
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
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.clip,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                    // Align(
                                    //   alignment:
                                    //       AlignmentDirectional.bottomStart,
                                    //   child: TextUtils(
                                    //       fontSize: 14,
                                    //       fontWeight: FontWeight.w500,
                                    //       color: Colors.black,
                                    //       text:
                                    //           '${controller.discountPrice} د.ع'),
                                    // )
                                  ],
                                ),
                                Obx(() {
                                  return PositionedDirectional(
                                    top: 16,
                                    start: 0,
                                    child: InkWell(
                                        onTap: () {
                                          controller
                                              .manageFavourites(controller.idd);
                                        },
                                        child: controller
                                                .isFavourites(controller.idd)
                                            ? Icon(
                                                Icons.favorite,
                                                color: Get.isDarkMode
                                                    ? mainColor
                                                    : mainColor,
                                              )
                                            : Icon(
                                                Icons.favorite_border_outlined,
                                                color: Get.isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                              )),
                                  );
                                }),
                                Obx(() {
                                  return PositionedDirectional(
                                    bottom: 10,
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
                                              fontWeight: FontWeight.w600,
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
                            );
                          },
                        )),

                    //button
                    ButtonUtils(
                        text: 'إضافة إلي السلة'.tr,
                        onPressed: () {
                          cartController.postCartData(
                              controller.productDetailsList[0].id.toString());
                          Get.snackbar('Product added', '',
                              duration: const Duration(seconds: 1),
                              backgroundColor: mainColor,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM);
                          // cartController.qty.value=1;
                        },
                        colorstext: Colors.black,
                        background: mainColor)
                  ],
                );
              }
            },
          )),
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
