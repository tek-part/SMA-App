import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/controller/details_order_controller.dart';
import '../../logic/controller/product_details_controller.dart';
import '../../utils/them.dart';
import '../widget/cart/cart_order_cart.dart';
// import '../widget/cart/prices_widget.dart';

// ignore: must_be_immutable
class OrderDetailsScreen extends StatelessWidget {
  OrderDetailsScreen({super.key});

  OrderDetailsController controller = Get.put(OrderDetailsController());
  ProductDetails productcontroller = Get.put(ProductDetails());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تفاصيل الطلب'.tr,
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
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: GetBuilder<OrderDetailsController>(
            builder: (_) {
              if (controller.orderDetailsList.isEmpty ||
                  controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: mainColor,
                  ),
                );
              } else {
                return ListView(shrinkWrap: true, children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.orderDetailsList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                          onTap: () {
                            // productcontroller.productDetailsList.clear();

                            // productcontroller.getProducrtDetails(
                            //     controller.orderDetailsList[index].id);
                            // PersistentNavBarNavigator.pushNewScreen(
                            //   context,
                            //   screen: ProductDetailsScreen(),
                            //   withNavBar:
                            //       true, // OPTIONAL VALUE. True by default.
                            //   pageTransitionAnimation:
                            //       PageTransitionAnimation.cupertino,
                            // );
                          },
                          child: CartOrderCard(
                            image: controller.orderDetailsList[index].image,
                            name: controller.orderDetailsList[index].name,
                            price: controller.orderDetailsList[index].price,
                            qty: controller.orderDetailsList[index].quantity,
                            descriptoin:
                                controller.orderDetailsList[index].description,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox.shrink(),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () => controller.sendWhatsAppForLastOrder(
                            fromUserTap: true),
                        icon: const Icon(Icons.message),
                        label: Text(
                          'إرسال عبر واتساب'.tr,
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ]);
              }
            },
          )),
    );
  }
}
