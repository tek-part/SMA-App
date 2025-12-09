import 'package:bandora_app/utils/them.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../logic/controller/details_order_controller.dart';
import '../../../logic/controller/order_controller.dart';
import '../../screen/order_details_screen.dart';
import '../empty_page.dart';
import '../text_utils.dart';
import 'order_container_widget.dart';

// ignore: must_be_immutable
class AllOrderWidget extends StatelessWidget {
  AllOrderWidget({super.key});

  OrderController controller = Get.put(OrderController());
  OrderDetailsController orderDetailsController =
      Get.put(OrderDetailsController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: mainColor),
            );
          } else if (controller.orderItemList.isEmpty) {
            return EmptyPage(
              image: 'assets/images/solar_bag.svg',
              text: 'لا توجد طلبات بعد'.tr,
            );
          }
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
                controller.getCartItem();
                return Future.delayed(const Duration(seconds: 1));
              },
              color: mainColor,
              child: ListView(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.orderItemList.length,
                    itemBuilder: (context, index) {
                      print(
                          "===============================${controller.orderItemList[index].id}");

                      if (controller.orderItemList[index].status == 'اكتمل' ||
                          controller.orderItemList[index].status ==
                              'Completed') {
                        return OrderContainerWidget(
                            reloadTap: () {
                              controller.repetOrderItem(
                                  controller.orderItemList[index].id);
                            },
                            logoColor: mainColor,
                            textColor: mainColor,
                            onTap: () {
                              orderDetailsController.clearList();
                              orderDetailsController.getProducrtDetails(
                                  controller.orderItemList[index].id);
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: OrderDetailsScreen(),
                                withNavBar:
                                    true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            textt: Text(
                              controller.orderItemList[index].status,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: greenClr),
                            ),
                            code: controller.orderItemList[index].code,
                            time: controller.orderItemList[index].createdAt,
                            status: controller.orderItemList[index].status);
                      } else if (controller.orderItemList[index].status ==
                              'تحت المعالجة' ||
                          controller.orderItemList[index].status ==
                              'Processing') {
                        return OrderContainerWidget(
                            reloadTap: () {
                              controller.repetOrderItem(
                                  controller.orderItemList[index].id);
                            },
                            logoColor: mainColor,
                            textColor: mainColor,
                            onTap: () {
                              orderDetailsController.clearList();
                              orderDetailsController.getProducrtDetails(
                                  controller.orderItemList[index].id);
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: OrderDetailsScreen(),
                                withNavBar:
                                    true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            textt: Text(
                              controller.orderItemList[index].status,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: orngClr),
                            ),
                            code: controller.orderItemList[index].code,
                            time: controller.orderItemList[index].createdAt,
                            status: controller.orderItemList[index].status);
                      } else if (controller.orderItemList[index].status ==
                              'مرفوض' ||
                          controller.orderItemList[index].status == 'Decline') {
                        return OrderContainerWidget(
                            reloadTap: () {
                              controller.repetOrderItem(
                                  controller.orderItemList[index].id);
                            },
                            logoColor: mainColor,
                            textColor: mainColor,
                            onTap: () {
                              orderDetailsController.clearList();
                              orderDetailsController.getProducrtDetails(
                                  controller.orderItemList[index].id);
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: OrderDetailsScreen(),
                                withNavBar:
                                    true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            textt: Text(
                              controller.orderItemList[index].status,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: recGreyClr),
                            ),
                            code: controller.orderItemList[index].code,
                            time: controller.orderItemList[index].createdAt,
                            status: controller.orderItemList[index].status);
                      } else {
                        return OrderContainerWidget(
                            reloadTap: () {
                              controller.repetOrderItem(
                                  controller.orderItemList[index].id);
                            },
                            logoColor: mainColor,
                            textColor: mainColor,
                            onTap: () {
                              orderDetailsController.clearList();
                              orderDetailsController.getProducrtDetails(
                                  controller.orderItemList[index].id);
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: OrderDetailsScreen(),
                                withNavBar:
                                    true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            textt: Text(
                              controller.orderItemList[index].status,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: GreyClr),
                            ),
                            code: controller.orderItemList[index].code,
                            time: controller.orderItemList[index].createdAt,
                            status: controller.orderItemList[index].status);
                      }
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
                          : const Text(''),
                ],
              ),
            ),
          );
        }));
  }
}
