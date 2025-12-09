import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../logic/controller/details_checkout_controller.dart';
import '../../utils/them.dart';
import '../widget/cart/cart_order_cart.dart';
// import '../widget/cart/prices_widget.dart';

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
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  controller.triggerAutoWhatsApp();
                });
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
                        onPressed: () =>
                            controller.openWhatsApp(fromUserTap: true),
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
