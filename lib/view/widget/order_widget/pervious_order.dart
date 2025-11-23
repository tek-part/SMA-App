import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../logic/controller/details_order_controller.dart';
import '../../../logic/controller/previous_order_controller.dart';
import '../../../utils/them.dart';
import '../../screen/order_details_screen.dart';
import '../empty_page.dart';
import '../text_utils.dart';
import 'order_container_widget.dart';

// ignore: must_be_immutable
class PreviousOrderWidget extends StatelessWidget {
  PreviousOrderWidget({super.key});

  PreviousOrderController controller = Get.put(PreviousOrderController());
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
          } else if (controller.previousorderItemList.isEmpty) {
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
                    itemCount: controller.previousorderItemList.length,
                    itemBuilder: (context, index) {
                      if (controller.previousorderItemList[index].status ==
                              'اكتمل' ||
                          controller.previousorderItemList[index].status ==
                              'Completeds') {
                        return OrderContainerWidget(
                            reloadTap: () {
                              controller.repetOrderItem(
                                  controller.previousorderItemList[index].id);
                            },
                            logoColor: mainColor,
                            textColor: mainColor,
                            onTap: () {
                              orderDetailsController.clearList();
                              orderDetailsController.getProducrtDetails(
                                  controller.previousorderItemList[index].id);
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
                              controller.previousorderItemList[index].status,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: greenClr),
                            ),
                            code: controller.previousorderItemList[index].code,
                            time: controller
                                .previousorderItemList[index].createdAt,
                            status:
                                controller.previousorderItemList[index].status);
                      } else if (controller
                                  .previousorderItemList[index].status ==
                              'تحت المعالجة' ||
                          controller.previousorderItemList[index].status ==
                              'Processing') {
                        return OrderContainerWidget(
                            reloadTap: () {
                              controller.repetOrderItem(
                                  controller.previousorderItemList[index].id);
                            },
                            logoColor: mainColor,
                            textColor: mainColor,
                            onTap: () {
                              orderDetailsController.clearList();
                              orderDetailsController.getProducrtDetails(
                                  controller.previousorderItemList[index].id);
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
                              controller.previousorderItemList[index].status,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: orngClr),
                            ),
                            code: controller.previousorderItemList[index].code,
                            time: controller
                                .previousorderItemList[index].createdAt,
                            status:
                                controller.previousorderItemList[index].status);
                      } else if (controller
                                  .previousorderItemList[index].status ==
                              'مرفوض' ||
                          controller.previousorderItemList[index].status ==
                              'Decline') {
                        return OrderContainerWidget(
                            reloadTap: () {
                              controller.repetOrderItem(
                                  controller.previousorderItemList[index].id);
                            },
                            logoColor: mainColor,
                            textColor: mainColor,
                            onTap: () {
                              orderDetailsController.clearList();
                              orderDetailsController.getProducrtDetails(
                                  controller.previousorderItemList[index].id);
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
                              controller.previousorderItemList[index].status,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: recGreyClr),
                            ),
                            code: controller.previousorderItemList[index].code,
                            time: controller
                                .previousorderItemList[index].createdAt,
                            status:
                                controller.previousorderItemList[index].status);
                      } else {
                        return OrderContainerWidget(
                            reloadTap: () {
                              controller.repetOrderItem(
                                  controller.previousorderItemList[index].id);
                            },
                            logoColor: mainColor,
                            textColor: mainColor,
                            onTap: () {
                              orderDetailsController.clearList();
                              orderDetailsController.getProducrtDetails(
                                  controller.previousorderItemList[index].id);
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
                              controller.previousorderItemList[index].status,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: GreyClr),
                            ),
                            code: controller.previousorderItemList[index].code,
                            time: controller
                                .previousorderItemList[index].createdAt,
                            status:
                                controller.previousorderItemList[index].status);
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
