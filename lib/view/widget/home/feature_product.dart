import 'package:bandora_app/utils/them.dart';
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../logic/controller/cart_controller.dart';
import '../../../logic/controller/featured_product_controller.dart';
import '../../../logic/controller/product_details_controller.dart';
import '../../screen/featured_product.dart';
import '../../screen/prouct_details_screen.dart';
import '../loading/loading_featured.dart';

// ignore: must_be_immutable
class FeaturedProduct extends StatelessWidget {
  FeaturedProduct({super.key});

  FeaturedProductController controller = Get.put(FeaturedProductController());
  ProductDetails productcontroller = Get.put(ProductDetails());
  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextUtils(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      text: 'المنتجات المميزة'.tr),
                  TextButton(
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: FeaturedProductScreen(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: TextUtils(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: mainColor,
                          text: 'عرض المزيد'.tr))
                ],
              ),
            ),
            loadingFeatured(),
          ],
        );
      } else if (controller.featuredProductList.isEmpty) {
        return const Text('');
      } else {
        return SizedBox(
          width: MediaQuery.of(context).size.width / 1,
          height: MediaQuery.of(context).size.height / 3.5,
          child: Column(
            children: [
              //المزيد
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextUtils(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        text: 'المنتجات المميزة'.tr),
                    TextButton(
                        onPressed: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: FeaturedProductScreen(),
                            withNavBar:
                                true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        child: TextUtils(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: mainColor,
                            text: 'عرض المزيد'.tr))
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    //first container
                    InkWell(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: FeaturedProductScreen(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width / 3.5,
                          height: MediaQuery.of(context).size.height / 8,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: ShapeDecoration(
                            color: mainColor,
                            shape: RoundedRectangleBorder(
                              side:
                                  const BorderSide(width: 0.50, color: GreyClr),
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
                            alignment: Alignment.center,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextUtils(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      text: 'المنتجات المميزة'),
                                  TextUtils(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      text: 'Featured Products'),
                                ],
                              ),
                              Positioned(
                                  top: 0,
                                  bottom:
                                      MediaQuery.of(context).size.height / 8.5,
                                  child: Lottie.asset(
                                      'assets/lottie/Animation - 1700527639153.json',
                                      fit: BoxFit.fill))
                            ],
                          )),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.featuredProductList.length >= 5
                          ? 5
                          : controller.featuredProductList.length,
                      itemBuilder: (context, index) {
                        return UniqueProduct(
                            width: MediaQuery.of(context).size.width / 3.5,
                            height: MediaQuery.of(context).size.height / 8,
                            cartTap: () {
                              cartController.qty.value = 1;
                              cartController.postCartData(controller
                                  .featuredProductList[index].id
                                  .toString());
                              productcontroller.getProducrtDetails(
                                  controller.featuredProductList[index].id);
                            },
                            onTab: () {
                              productcontroller.productDetailsList.clear();
                              cartController.qty.value = 1;
                              productcontroller.getProducrtDetails(
                                  controller.featuredProductList[index].id);
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: ProductDetailsScreen(),
                                withNavBar: true,
                                // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                              //  Get.toNamed(Routes.ProductDetailsScreen);
                              Get.to(() => ProductDetailsScreen());
                            },
                            image: controller.featuredProductList[index].image,
                            name: controller.featuredProductList[index].name,
                            price: controller.featuredProductList[index].price
                                .toString());
                      },
                    )
                  ],
                ),
              ),
              // Obx(() {
              //   if (controller.isLoading.value) {
              //     return loadingFeatured();
              //   } else {
              //     return Expanded(
              //       child: ListView(
              //         scrollDirection: Axis.horizontal,
              //         physics: const BouncingScrollPhysics(),
              //         children: [
              //           //first container
              //           InkWell(
              //             onTap: () {
              //               PersistentNavBarNavigator.pushNewScreen(
              //                 context,
              //                 screen: FeaturedProductScreen(),
              //                 withNavBar: true, // OPTIONAL VALUE. True by default.
              //                 pageTransitionAnimation:
              //                     PageTransitionAnimation.cupertino,
              //               );
              //             },
              //             child: Container(
              //                 width: MediaQuery.of(context).size.width / 3.5,
              //                 height: MediaQuery.of(context).size.height / 8,
              //                 margin: const EdgeInsets.symmetric(horizontal: 10),
              //                 decoration: ShapeDecoration(
              //                   color: mainColor,
              //                   shape: RoundedRectangleBorder(
              //                     side:
              //                         const BorderSide(width: 0.50, color: GreyClr),
              //                     borderRadius: BorderRadius.circular(4),
              //                   ),
              //                   shadows: const [
              //                     BoxShadow(
              //                       color: Color(0x7FCCCCCD),
              //                       blurRadius: 4,
              //                       offset: Offset(0.50, 2),
              //                       spreadRadius: 0,
              //                     )
              //                   ],
              //                 ),
              //                 child: Stack(
              //                   alignment: Alignment.center,
              //                   children: [
              //                     const Column(
              //                       crossAxisAlignment: CrossAxisAlignment.center,
              //                       mainAxisAlignment: MainAxisAlignment.center,
              //                       children: [
              //                         TextUtils(
              //                             fontSize: 14,
              //                             fontWeight: FontWeight.w600,
              //                             color: Colors.white,
              //                             text: 'المنتجات المميزة'),
              //                         TextUtils(
              //                             fontSize: 12,
              //                             fontWeight: FontWeight.w600,
              //                             color: Colors.white,
              //                             text: 'Featured Products'),
              //                       ],
              //                     ),
              //                     Positioned(
              //                         top: 0,
              //                         bottom:
              //                             MediaQuery.of(context).size.height / 8.5,
              //                         child: Lottie.asset(
              //                             'assets/lottie/Animation - 1700527639153.json',
              //                             fit: BoxFit.fill))
              //                   ],
              //                 )),
              //           ),
              //           ListView.builder(
              //             shrinkWrap: true,
              //             physics: const NeverScrollableScrollPhysics(),
              //             scrollDirection: Axis.horizontal,
              //             itemCount: controller.featuredProductList.length >= 5
              //                 ? 5
              //                 : controller.featuredProductList.length,
              //             itemBuilder: (context, index) {
              //               return UniqueProduct(
              //                   width: MediaQuery.of(context).size.width / 3.5,
              //                   height: MediaQuery.of(context).size.height / 8,
              //                   cartTap: () {
              //                     cartController.qty.value = 1;
              //                     cartController.postCartData(controller
              //                         .featuredProductList[index].id
              //                         .toString());
              //                     productcontroller.getProducrtDetails(
              //                         controller.featuredProductList[index].id);
              //                   },
              //                   onTab: () {
              //                     productcontroller.productDetailsList.clear();
              //                     cartController.qty.value = 1;
              //                     productcontroller.getProducrtDetails(
              //                         controller.featuredProductList[index].id);
              //                     PersistentNavBarNavigator.pushNewScreen(
              //                       context,
              //                       screen: ProductDetailsScreen(),
              //                       withNavBar:
              //                           true, // OPTIONAL VALUE. True by default.
              //                       pageTransitionAnimation:
              //                           PageTransitionAnimation.cupertino,
              //                     );
              //                     // Get.toNamed(Routes.ProductDetailsScreen);
              //                   },
              //                   image: controller.featuredProductList[index].image,
              //                   name: controller.featuredProductList[index].name,
              //                   price: controller.featuredProductList[index].price
              //                       .toString());
              //             },
              //           )
              //         ],
              //       ),
              //     );
              //   }
              // })
            ],
          ),
        );
      }
    });
  }

  // ignore: non_constant_identifier_names
  Widget UniqueProduct({
    required String image,
    required String name,
    required String price,
    required double height,
    required Function() onTab,
    required Function() cartTap,
    required double width,
  }) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        width: width,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 0.50, color: GreyClr),
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
              onTap: onTab,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(image), fit: BoxFit.contain)),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        name,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
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
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
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
                ),
              ),
            ),
          ],
        ));
  }
}
