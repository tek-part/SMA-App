import 'package:bandora_app/routes/routes.dart';
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../logic/controller/cart_controller.dart';
import '../../logic/controller/product_details_controller.dart';
import '../../utils/them.dart';
import '../logic/controller/brand_product_controller.dart';

// ignore: must_be_immutable
class BrandProductScreen extends StatelessWidget {
  BrandProductScreen({super.key});

  BrandProoductController controller = Get.put(BrandProoductController());
  ProductDetails productcontroller = Get.put(ProductDetails());
  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'العلامات التجارية الرائجة'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
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
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: mainColor,
                  ),
                );
              } else if (controller.brandProductList.isEmpty) {
                return Center(
                  child: Lottie.asset(
                      'assets/lottie/Animation - 1699311761861.json'),
                );
              } else {
                return NotificationListener(
                  onNotification: (notification) {
                    if (notification is ScrollEndNotification &&
                        notification.metrics.extentAfter == 0) {
                      print('kajk');

                      controller.isLoadMore(true);
                      controller.page++;
                      // controller.getAllCategory();
                      controller.paginateTask();
                    }
                    return true;
                  },
                  child: RefreshIndicator(
                    onRefresh: () async {
                      return Future.delayed(const Duration(seconds: 2));
                    },
                    color: mainColor,
                    child: ListView(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.brandProductList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 30.0,
                                  mainAxisExtent: 210),
                          itemBuilder: (context, index) {
                            return Products(
                              cartTap: () {
                                cartController.postCartData(controller
                                    .brandProductList[index].id
                                    .toString());
                                Get.snackbar('Product added', '',
                                    duration: const Duration(seconds: 1),
                                    backgroundColor: mainColor,
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM);
                              },
                              image: controller.brandProductList[index].image,
                              name: controller.brandProductList[index].name,
                              price: controller.brandProductList[index].price
                                  .toString(),
                              onTap: () {
                                productcontroller.productDetailsList.clear();

                                productcontroller.getProducrtDetails(
                                    controller.brandProductList[index].id);
                                Get.toNamed(Routes.productDetailsScreen);
                              },
                            );
                          },
                        ),
                        controller.isLoadMore.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: mainColor,
                                ),
                              )
                            : controller.isEmpty.value
                                ? Center(
                                    child: TextUtils(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: GreyClr,
                                        text: 'لا توجد طلبات اخرى '.tr))
                                : const Text('')
                      ],
                    ),
                  ),
                );
              }
            })));
  }

  // ignore: non_constant_identifier_names
  Widget Products({
    required String image,
    required String name,
    required String price,
    required Function() onTap,
    required Function() cartTap,
  }) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 0.50, color: Color(0xFFCED5E1)),
            borderRadius: BorderRadius.circular(4),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x7FCCCCCD),
              blurRadius: 4,
              offset: Offset(0.50, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Stack(
          children: [
            InkWell(
              onTap: onTap,
              child: Column(
                children: [
                  Container(
                    height: 130,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(image), fit: BoxFit.contain)),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        name,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis),
                      )),
                  // Align(
                  //   alignment: Alignment.bottomRight,
                  //   child: TextUtils(
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w600,
                  //       color: Colors.black,
                  //       text: '$price د.ع'),
                  // ),
                ],
              ),
            ),
            Positioned(
                left: 5,
                top: 5,
                child: InkWell(
                  onTap: cartTap,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: mainColor),
                    child: const Center(
                        child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 14,
                    )),
                  ),
                )),
          ],
        ));
  }
}
