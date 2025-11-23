import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controller/cart_controller.dart';
import '../../../logic/controller/cart_item_controller.dart';
import '../../../logic/controller/product_details_controller.dart';
import '../../../utils/them.dart';
import '../../widget/empty_page.dart';
import '../../widget/text_utils.dart';

// ignore: must_be_immutable
class FavScreen extends StatelessWidget {
  FavScreen({super.key});

  ProductDetails controller = Get.put(ProductDetails());
  CartController cartController = Get.put(CartController());
  CartItemController cartItemController = Get.put(CartItemController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'قائمة المفضلة'.tr,
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
          leading: const Text(''),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Obx(() {
              if (controller.favouritesList.isEmpty &&
                  cartItemController.favouritesList.isEmpty) {
                return Center(
                    child: EmptyPage(
                  image: 'assets/images/heartlogo.svg',
                  text: 'لم تقم بإضافة أى منتج بعد'.tr,
                ));
              } else {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.favouritesList.length,
                      itemBuilder: (context, index) {
                        return Products(
                          id: controller.favouritesList[index].id,
                          likeonTap: () {
                            controller.manageFavourites(
                              controller.favouritesList[index].id,
                            );
                          },
                          description:
                              controller.favouritesList[index].description,
                          imaage: Container(
                            height: MediaQuery.of(context).size.height / 9,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        controller.favouritesList[index].image),
                                    fit: BoxFit.contain)),
                          ),
                          cartTap: () {
                            cartController.qty.value = 1;
                            cartController.postCartData(
                                controller.favouritesList[index].id.toString());
                          },
                          name: controller.favouritesList[index].name,
                          price:
                              controller.favouritesList[index].price.toString(),
                        );
                      },
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartItemController.favouritesList.length,
                      itemBuilder: (context, index) {
                        return Products(
                          id: cartItemController.favouritesList[index].id,
                          likeonTap: () {
                            cartItemController.manageFavourites(
                              cartItemController.favouritesList[index].id,
                            );
                          },
                          description: cartItemController
                              .favouritesList[index].description,
                          imaage: Container(
                            height: MediaQuery.of(context).size.height / 9,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(cartItemController
                                        .favouritesList[index].image),
                                    fit: BoxFit.contain)),
                          ),
                          cartTap: () {
                            cartController.qty.value = 1;
                            cartController.postCartData(
                                controller.favouritesList[index].id.toString());
                          },
                          name: cartItemController.favouritesList[index].name,
                          price: cartItemController.favouritesList[index].price
                              .toString(),
                        );
                      },
                    )
                  ],
                );
              }
            })));
  }

  // ignore: non_constant_identifier_names
  Widget Products({
    required Widget imaage,
    required String name,
    required String description,
    required String price,
    required Function() cartTap,
    required Function() likeonTap,
    required int id,
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
            Column(
              children: [
                imaage,
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextUtils(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      text: name),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextUtils(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      text: description),
                ),
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
            PositionedDirectional(
                end: 5,
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
            Obx(() {
              return PositionedDirectional(
                start: 5,
                top: 5,
                child: InkWell(
                    onTap: likeonTap,
                    child: controller.isFavourites(id) ||
                            cartItemController.isFavourites(id)
                        ? Icon(
                            Icons.favorite,
                            color: Get.isDarkMode ? mainColor : mainColor,
                          )
                        : Icon(
                            Icons.favorite_border_outlined,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          )),
              );
            }),
          ],
        ));
  }
}
