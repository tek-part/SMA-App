import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../logic/controller/current_order_controller.dart';
import '../../../logic/controller/details_order_controller.dart';
import '../../../utils/them.dart';
import '../../screen/order_details_screen.dart';
import '../empty_page.dart';
import '../text_utils.dart';
import 'order_container_widget.dart';

// ignore: must_be_immutable
class CurrentOrderWidget extends StatelessWidget {
  CurrentOrderWidget({super.key});

  CurrentOrderController controller = Get.put(CurrentOrderController());

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
          } else if (controller.currentOrderItemList.isEmpty) {
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
                    itemCount: controller.currentOrderItemList.length,
                    itemBuilder: (context, index) {
                      if (controller.currentOrderItemList[index].status ==
                              'اكتمل' ||
                          controller.currentOrderItemList[index].status ==
                              'Completeds') {
                        return OrderContainerWidget(
                            reloadTap: () {
                              controller.repetOrderItem(
                                  controller.currentOrderItemList[index].id);
                            },
                            logoColor: mainColor,
                            textColor: mainColor,
                            onTap: () {
                              orderDetailsController.clearList();
                              orderDetailsController.getProducrtDetails(
                                  controller.currentOrderItemList[index].id);
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
                              controller.currentOrderItemList[index].status,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: greenClr),
                            ),
                            code: controller.currentOrderItemList[index].code,
                            time: controller
                                .currentOrderItemList[index].createdAt,
                            status:
                                controller.currentOrderItemList[index].status);
                      } else if (controller
                                  .currentOrderItemList[index].status ==
                              'تحت المعالجة' ||
                          controller.currentOrderItemList[index].status ==
                              'Processing') {
                        return OrderContainerWidget(
                            reloadTap: () {
                              controller.repetOrderItem(
                                  controller.currentOrderItemList[index].id);
                            },
                            logoColor: mainColor,
                            textColor: mainColor,
                            onTap: () {
                              orderDetailsController.clearList();
                              orderDetailsController.getProducrtDetails(
                                  controller.currentOrderItemList[index].id);
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
                              controller.currentOrderItemList[index].status,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: orngClr),
                            ),
                            code: controller.currentOrderItemList[index].code,
                            time: controller
                                .currentOrderItemList[index].createdAt,
                            status:
                                controller.currentOrderItemList[index].status);
                      } else if (controller
                                  .currentOrderItemList[index].status ==
                              'مرفوض' ||
                          controller.currentOrderItemList[index].status ==
                              'Decline') {
                        return OrderContainerWidget(
                            reloadTap: () {
                              controller.repetOrderItem(
                                  controller.currentOrderItemList[index].id);
                            },
                            logoColor: mainColor,
                            textColor: mainColor,
                            onTap: () {
                              orderDetailsController.clearList();
                              orderDetailsController.getProducrtDetails(
                                  controller.currentOrderItemList[index].id);
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
                              controller.currentOrderItemList[index].status,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: recGreyClr),
                            ),
                            code: controller.currentOrderItemList[index].code,
                            time: controller
                                .currentOrderItemList[index].createdAt,
                            status:
                                controller.currentOrderItemList[index].status);
                      } else {
                        return OrderContainerWidget(
                            reloadTap: () {
                              controller.repetOrderItem(
                                  controller.currentOrderItemList[index].id);
                            },
                            logoColor: mainColor,
                            textColor: mainColor,
                            onTap: () {
                              orderDetailsController.clearList();
                              orderDetailsController.getProducrtDetails(
                                  controller.currentOrderItemList[index].id);
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
                              controller.currentOrderItemList[index].status,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: GreyClr),
                            ),
                            code: controller.currentOrderItemList[index].code,
                            time: controller
                                .currentOrderItemList[index].createdAt,
                            status:
                                controller.currentOrderItemList[index].status);
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

//  Column(
//       children: [
//         Container(
//           width: MediaQuery.of(context).size.width / 1,
//           height: MediaQuery.of(context).size.height / 6,
//           margin: const EdgeInsets.all(20),
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//           decoration: ShapeDecoration(
//             shape: RoundedRectangleBorder(
//               side: BorderSide(width: 1, color: Color(0xFFCED5E1)),
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               //first row
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const [
//                   TextUtils(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.black,
//                       text: 'يتم تحضير طلبك الان'),
//                   TextUtils(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.black,
//                       text: 'Mon , 15 may 2023'),
//                 ],
//               ),
//               //Timeline
//               Expanded(
//                   child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 physics: const NeverScrollableScrollPhysics(),
//                 children: const [
//                   MyTimeLineTitle(isFirst: false, isLast: true, isPast: true,text: 'تحضير الطلب'),
//                   MyTimeLineTitle(isFirst: false, isLast: false, isPast: false,text: 'تحضير الطلب'),
//                   MyTimeLineTitle(isFirst: false, isLast: false, isPast: false,text: 'تحضير الطلب'),
//                   MyTimeLineTitle(isFirst: true, isLast: false, isPast: false,text: 'تحضير الطلب'),
//                 ],
//               ))
//             ],
//           ),
//         ),
//       ],
//     );
