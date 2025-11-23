import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/controller/details_checkout_controller.dart';
import '../../utils/them.dart';
import '../widget/cart/cart_order_cart.dart';
// import '../widget/cart/prices_widget.dart';
import '../widget/text_utils.dart';

// ignore: must_be_immutable
class CheckOutDetailsScreen extends StatelessWidget {
  CheckOutDetailsScreen({super.key});

  CheckOUtDetailsController controller = Get.put(CheckOUtDetailsController());

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
          child: GetBuilder<CheckOUtDetailsController>(
            builder: (_) {
              if (controller.isLoading.value) {
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
                    itemCount: controller.checkOutDetailsList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: CartOrderCard(
                          image: controller.checkOutDetailsList[index].image,
                          name: controller.checkOutDetailsList[index].name,
                          price: controller.checkOutDetailsList[index].price
                              .toString(),
                          qty: controller.checkOutDetailsList[index].quantity,
                          descriptoin:
                              controller.checkOutDetailsList[index].description,
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
                                fontWeight: FontWeight.w500,
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
