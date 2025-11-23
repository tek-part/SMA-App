import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../logic/controller/cart_controller.dart';
import '../../logic/controller/main_catogery_controller.dart';
import '../../logic/controller/product_details_controller.dart';
import '../../utils/them.dart';
import 'offer_details_screen.dart';

// ignore: must_be_immutable
class OfferProductScreen extends StatelessWidget {
  OfferProductScreen({super.key});

  MainCatogeryController controller = Get.put(MainCatogeryController());
  ProductDetails productDetails = Get.put(ProductDetails());
  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'العروض الأسبوعية'.tr,
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
            padding: const EdgeInsets.all(20),
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: mainColor,
                  ),
                );
              } else if (controller.offerProductList.isEmpty) {
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
                      controller.offerPaginateTask();
                    }
                    return true;
                  },
                  child: RefreshIndicator(
                    onRefresh: () async {
                      controller.getOfferProducts();
                      return Future.delayed(const Duration(seconds: 1));
                    },
                    color: mainColor,
                    child: ListView(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.offerProductList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 30.0,
                                  mainAxisExtent: 210),
                          itemBuilder: (context, index) {
                            return Product(
                              imaage: Container(
                                height: MediaQuery.of(context).size.height / 7,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(controller
                                            .offerProductList[index].image),
                                        fit: BoxFit.fill)),
                              ),
                              cartTap: () {
                                cartController.qty.value = 1;
                                cartController.postCartData(controller
                                    .offerProductList[index].id
                                    .toString());
                              },
                              name: controller
                                  .offerProductList[index].productName,
                              price: controller
                                  .offerProductList[index].priceAfterDiscount
                                  .toString(),
                              discondPrice: controller
                                  .offerProductList[index].productPrice
                                  .toString(),
                              offer: controller
                                  .offerProductList[index].offerDiscount
                                  .toString(),
                              onTap: () {
                                productDetails.productDetailsList.clear();
                                cartController.qty.value = 1;

                                productDetails.getProducrtDetails(
                                    controller.offerProductList[index].id);
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: OfferDetailsScreen(),
                                  withNavBar:
                                      true, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
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
                                        fontWeight: FontWeight.w500,
                                        color: GreyClr,
                                        text: 'لا توجد طلبات اخرى '.tr))
                                : const Text(''),
                      ],
                    ),
                  ),
                );
              }
            })));
  }

  // ignore: non_constant_identifier_names
  Widget Product({
    required Widget imaage,
    required String name,
    required String price,
    required String discondPrice,
    required String offer,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Column(
                  children: [
                    //image
                    imaage,
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          name,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontFamily: 'Cairo',
                              overflow: TextOverflow.ellipsis),
                        )),
                    // Align(
                    //   alignment: Alignment.bottomRight,
                    //   child: Text(
                    //     '$discondPrice د.ع',
                    //     textAlign: TextAlign.center,
                    //     style: const TextStyle(
                    //         color: Color(0xFF888888),
                    //         fontSize: 10,
                    //         fontFamily: 'Cairo',
                    //         fontWeight: FontWeight.w500,
                    //         decoration: TextDecoration.lineThrough,
                    //         height: 0,
                    //         overflow: TextOverflow.ellipsis),
                    //   ),
                    // ),
                    // Align(
                    //   alignment: Alignment.bottomRight,
                    //   child: TextUtils(
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.w500,
                    //       color: Colors.black,
                    //       text: '$price د.ع'),
                    // ),
                  ],
                ),
              ),
            ),
            Positioned(
                left: 5,
                top: 5,
                child: InkWell(
                  onTap: cartTap,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: mainColor),
                    child: const Center(
                        child: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                      size: 22,
                    )),
                  ),
                )),
            Positioned(
                right: 5,
                top: 5,
                child: Container(
                  width: 44,
                  height: 37,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFF0C2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  child: Center(
                    child: TextUtils(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        text: '$offer%-'),
                  ),
                )),
          ],
        ));
  }
}
