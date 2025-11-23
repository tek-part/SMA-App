import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controller/cart_controller.dart';
import '../../../logic/controller/cart_item_controller.dart';
import '../../../utils/them.dart';
import '../../widget/cart/cart_total.dart';
import '../../widget/cart_product_card.dart';
import '../../widget/empty_page.dart';

// ignore: must_be_immutable
class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  CartItemController cartItemController = Get.put(CartItemController());

  CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'سلة التسوق'.tr,
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
          actions: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Obx(() {
                  if (cartItemController.cartItemList.isEmpty) {
                    return InkWell(
                      onTap: () {
                        // Get.defaultDialog(
                        //     backgroundColor: mainColor,
                        //     title: '',
                        //     middleText: 'هل أنت متأكد أنك تريد حذف الكل؟'.tr,
                        //     middleTextStyle: const TextStyle(
                        //         fontSize: 18,
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.white),
                        //     textCancel: 'لا'.tr,
                        //     textConfirm: 'نعم'.tr,
                        //     cancelTextColor: Colors.white,
                        //     confirmTextColor: Color(0xFFEB001B),
                        //     buttonColor: Colors.white,
                        //     onConfirm: () {
                        //       controller.clearCart();
                        //       Get.back();
                        //     });
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    );
                  } else {
                    return InkWell(
                      onTap: () {
                        Get.defaultDialog(
                            backgroundColor: mainColor,
                            title: '',
                            middleText: 'هل أنت متأكد أنك تريد حذف الكل؟'.tr,
                            middleTextStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textCancel: 'لا'.tr,
                            textConfirm: 'نعم'.tr,
                            cancelTextColor: Colors.white,
                            confirmTextColor: const Color(0xFFEB001B),
                            buttonColor: Colors.white,
                            onConfirm: () {
                              controller.clearCart();
                              Get.back();
                            });
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    );
                  }
                })),
          ],
        ),
        body: Obx(() {
          if (cartItemController.cartItemList.isEmpty) {
            return Center(
                child: EmptyPage(
              image: 'assets/images/cartlogo.svg',
              text: 'لم تقم بإضافة أى منتج بعد'.tr,
            ));
          } else {
            return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(children: [
                  Expanded(
                    flex: 6,
                    child: SizedBox(
                      child: ListView.separated(
                          itemBuilder: (context, index) {

                            return CartProductCard(
                              id: cartItemController.cartItemList[index].id,
                              deleatTap: () {
                                if (cartItemController.cartItemList.length ==
                                    1) {
                                  return controller.clearCart();
                                } else {
                                  return controller.deleteCart(
                                      cartItemController
                                          .cartItemList[index].cartId);
                                }
                              },
                              add: () {
                                cartItemController.isLoading.value = true;
                                controller.addCartData(
                                    cartItemController.cartItemList[index].id
                                        .toString(),cartItemController.cartItemList[index].qty+1);
                              },
                              min: () {
                                cartItemController.isLoading.value = true;
                                controller.minCartData(
                                    cartItemController.cartItemList[index].id
                                        .toString(),cartItemController.cartItemList[index].qty-1);
                              },
                              image:
                                  cartItemController.cartItemList[index].image,
                              name: cartItemController.cartItemList[index].name,
                              describtion: cartItemController
                                  .cartItemList[index].description,
                              price:
                                  cartItemController.cartItemList[index].total,
                              qty: cartItemController.cartItemList[index].qty,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 16,
                            );
                          },
                          itemCount: cartItemController.cartItemList.length),
                    ),
                  ),
                  Expanded(
                    child: CartTotal(
                      total: cartItemController.total,
                    ),
                  )
                ]));
          }
        }));
  }
}
