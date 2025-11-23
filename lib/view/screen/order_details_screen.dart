import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/controller/details_order_controller.dart';
import '../../logic/controller/product_details_controller.dart';
import '../../utils/them.dart';
import '../widget/cart/cart_order_cart.dart';
// import '../widget/cart/prices_widget.dart';
import '../widget/text_utils.dart';

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
                  //cart
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    // height: 164,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 0.50, color: Color(0xFFCED5E1)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x7FCED5E1),
                          blurRadius: 3,
                          offset: Offset(0, 1),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: TextUtils(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                text: 'ملخص الدفع'.tr),
                          ),
                          //الدفعات
                          // PricesWidget(
                          //   textColor: Colors.black,
                          //   priceColor: Colors.black,
                          //   text: 'المجموع الأولي'.tr,
                          //   price: '${controller.first} د.ع',
                          // ),
                          // const SizedBox(
                          //   height: 7,
                          // ),
                          // const Divider(color: Colors.black, height: 1),
                          // const SizedBox(
                          //   height: 7,
                          // ),
                          // PricesWidget(
                          //   textColor: Colors.black,
                          //   priceColor: Colors.black,
                          //   text: 'تكلفة التوصيل'.tr,
                          //   price: '${controller.costDelivery} د.ع',
                          // ),
                          // const SizedBox(
                          //   height: 7,
                          // ),
                          // const Divider(color: Colors.black, height: 1),
                          // const SizedBox(
                          //   height: 7,
                          // ),
                          // PricesWidget(
                          //   textColor: Colors.black,
                          //   priceColor: Colors.black,
                          //   text: 'المجموع النهائي النقدي'.tr,
                          //   price: '${controller.total} د.ع',
                          // ),
                          const SizedBox(
                            height: 7,
                          ),
                        ]),
                  ),
                ]);
              }
            },
          )),
    );
  }
}
