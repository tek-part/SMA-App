import 'package:bandora_app/view/screen/setting/connect_us_screen.dart';
import 'package:bandora_app/view/screen/setting/map_location.dart';
import 'package:bandora_app/view/screen/setting/order_evaluation_view.dart';
import 'package:bandora_app/view/widget/button_utils.dart';
import 'package:bandora_app/view/widget/order_widget/my_time_line_title.dart';
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../logic/controller/details_order_controller.dart';
import '../../logic/controller/order_status_controller.dart';
import '../../logic/controller/setting_controller.dart';
import '../../utils/them.dart';
import '../widget/empty_page.dart';
import 'main/home_screen.dart';
import 'main_screen.dart';
import 'order_details_screen.dart';

// ignore: must_be_immutable
class OrderStatusScreen extends StatelessWidget {
  OrderStatusScreen({super.key});

  OrderStatusController controller = Get.put(OrderStatusController());
  OrderDetailsController orderDetailsController =
      Get.put(OrderDetailsController());
  SettingController settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    controller.getOrderStatusItem();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'تتبع الطلب'.tr,
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
          leading: InkWell(
              onTap: () {
                PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                    context,
                    screen: MainScreen(),
                    withNavBar: true,
                    settings: const MaterialPage(child: HomeScreen()));
              },
              child: const Icon(Icons.arrow_back, color: Colors.black)),
          elevation: 0,
          centerTitle: true,
          backgroundColor: mainColor,
        ),
        body: GetBuilder<OrderStatusController>(
          builder: (_) {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (controller.orderStatusItemList.isEmpty) {
              return Center(
                  child: EmptyPage(
                image: 'assets/images/utils.svg',
                text: 'لم يتم إضافة طلب'.tr,
              ));
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: controller.orderStatusItemList.length,
                physics: const PageScrollPhysics(),
                itemBuilder: (context, index) {
                  var item = controller.orderStatusItemList[index];
                  print("===============================${item.id}");
                  print("===============================${item.status}");
                  return Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 70),
                    child: Column(
                      children: [
                        //image
                        GestureDetector(
                          onTap: () => item.type == 3
                              ? Get.to(() => Map_Location(
                                    code: item.id.toString(),
                                  ))
                              : {},
                          child: Image.asset(
                            'assets/images/googlemps.png',
                            height: MediaQuery.of(context).size.height / 4,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              //الحاله
                              TextUtils(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  text: item.status),
                              const SizedBox(
                                height: 10,
                              ),
                              //time
                              TextUtils(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  text: item.remaing),
                              //stauts
                              const TextUtils(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: GreyClr,
                                  text: 'الوقت المتوقع للوصول'),
                              //stauts
                              //arabic status
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 6,
                                // color: Colors.green,
                                child: item.type == 0
                                    ? Container(
                                        margin:
                                            const EdgeInsetsDirectional.all(30),
                                        padding:
                                            const EdgeInsetsDirectional.all(12),
                                        decoration: BoxDecoration(
                                            color: Colors.red.shade300,
                                            border: Border.all(
                                                color: Colors.teal, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: const Center(
                                          child: TextUtils(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              fontSize: 16,
                                              text:
                                                  'الطلب مرفوض يرجي الاعادة لاحقا'),
                                        ),
                                      )
                                    : ListView(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        // physics: const NeverScrollableScrollPhysics(),
                                        children: [
                                          MyTimeLineTitle(
                                              isText: true,
                                              isFirst: false,
                                              isLast: true,
                                              isPast: item.type == 1 ||
                                                      item.type == 2 ||
                                                      item.type == 3 ||
                                                      item.type == 4
                                                  ? true
                                                  : false,
                                              text: item.type == 1
                                                  ? item.status
                                                  : 'الطلب معلق'.tr),
                                          MyTimeLineTitle(
                                              isText: item.type == 1 ||
                                                      item.type == 2 ||
                                                      item.type == 3 ||
                                                      item.type == 4
                                                  ? true
                                                  : false,
                                              //تم قبول الطلب
                                              isFirst: false,
                                              isLast: false,
                                              isPast: item.type == 3 ||
                                                      item.type == 2 ||
                                                      item.type == 4
                                                  ? true
                                                  : false,
                                              text: item.type == 2
                                                  ? item.status
                                                  : 'تحضير الطلب'.tr),
                                          MyTimeLineTitle(
                                              isText: item.type == 2 ||
                                                      item.type == 3 ||
                                                      item.type == 4
                                                  ? true
                                                  : false,
                                              //تم قبول الطلب
                                              isFirst: false,
                                              isLast: false,
                                              isPast: item.type == 3 ||
                                                      item.type == 4
                                                  ? true
                                                  : false,
                                              text: item.type == 3
                                                  ? item.status
                                                  : "التوصيل".tr),
                                          MyTimeLineTitle(
                                              isText: item.type == 4 ||
                                                      item.type == 3
                                                  ? true
                                                  : false,
                                              isFirst: true,
                                              isLast: false,
                                              isPast:
                                                  item.type == 4 ? true : false,
                                              text: item.type == 4
                                                  ? item.status
                                                  : "مكتمل".tr),
                                        ],
                                      ),
                              )
                            ],
                          ),
                        ),
                        // if(item.type != 4)
                        TextButton(
                            onPressed: () {
                              orderDetailsController.clearList();
                              orderDetailsController.getProducrtDetails(
                                  controller.orderStatusItemList[index].id);
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: OrderDetailsScreen(),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: const TextUtils(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: mainColor,
                                text: 'تفاصيل الطلب')),
                        //       TextButton(
                        //           onPressed:()=> item.type == 3  ?  Get.to(()=>Order_evaluation_view(code: item.id.toString(),)) : {},
                        //
                        // child: const TextUtils(
                        //               fontSize: 16,
                        //               fontWeight: FontWeight.w500,
                        //               color: mainColor,
                        //               text: 'تقييم الطلب')),
                        // if(item.type != 4)
                        const SizedBox(
                          height: 15,
                        ),
                        // if(item.type != 4)
                        ButtonUtils(
                            text: 'تواصل معنا',
                            onPressed: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: ConnectUsScreen(),
                                //  AddLocationScreen(),
                                withNavBar:
                                    true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            colorstext: Colors.black,
                            background: mainColor),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () => orderDetailsController
                                .sendWhatsAppForOrder(item.id,
                                    fromUserTap: true),
                            icon: const Icon(Icons.message),
                            label: const Text(
                              'إرسال عبر واتساب',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        if (item.type == 4)
                          const SizedBox(
                            height: 15,
                          ),
                        if (item.type == 4)
                          Container(
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1.50, color: mainColor),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: ButtonUtils(
                                text: 'تقييم الطلب',
                                onPressed: () =>
                                    Get.to(() => Order_evaluation_view(
                                          code: item.id.toString(),
                                        )),
                                colorstext: mainColor,
                                background: Colors.white),
                          ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1.50, color: mainColor),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: ButtonUtils(
                              text: 'العودة إلي الصفحة الرئيسية',
                              onPressed: () {
                                PersistentNavBarNavigator
                                    .pushNewScreenWithRouteSettings(context,
                                        screen: MainScreen(),
                                        withNavBar: false,
                                        settings: const MaterialPage(
                                            child: HomeScreen()));
                              },
                              colorstext: mainColor,
                              background: Colors.white),
                        ),
                        // if(item.type == 4)
                        //   Container(
                        //     decoration: ShapeDecoration(
                        //       shape: RoundedRectangleBorder(
                        //         side: const BorderSide(
                        //             width: 1.50, color: mainColor),
                        //         borderRadius: BorderRadius.circular(4),
                        //       ),
                        //     ),
                        //     child: ButtonUtils(
                        //         text: 'تقييم الطلب',
                        //         onPressed: () {
                        //
                        //           var _rating = '' ;
                        //           TextEditingController mesg = TextEditingController();
                        //           showDialog(
                        //             context: context,
                        //             builder: (context) =>  AlertDialog(
                        //               surfaceTintColor: Colors.transparent,
                        //               shape: RoundedRectangleBorder(
                        //                 //    side: BorderSide(width: 1),
                        //                 borderRadius: BorderRadius.circular(15),
                        //               ),
                        //               content: Container(
                        //                 width:  Get.width ,
                        //                 height: 250, // Change as per your requirement
                        //                 child: Column(
                        //                   children: [
                        //                     Text('تقييم الطلب',style: TextStyle(
                        //                       color: mainColor,
                        //                       fontSize: 22,
                        //                       fontFamily: 'Cairo',
                        //                       fontWeight: FontWeight.w500,
                        //                     ),),
                        //                     SizedBox(height: 25,),
                        //
                        //                      Row(
                        //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //                       children: [
                        //                         Container(
                        //                             width: 100,
                        //                             child: Center(child: TextUtils(
                        //                                 fontSize: 15,
                        //                                 fontWeight: FontWeight.w600,
                        //                                 color: Colors.black,
                        //                                 text: 'خدمة التوصيل'),)),
                        //
                        //                         RatingBar.builder(
                        //                           initialRating: 3,
                        //                           minRating: 1,
                        //                           direction: Axis.horizontal,
                        //                           allowHalfRating: true,
                        //                           itemCount: 5,
                        //                           // itemPadding: EdgeInsets.symmetric(horizontal:  size.maxWidth > 600 ?  16.0 : 4.0),
                        //                           itemBuilder: (context, _) => Icon(
                        //                             Icons.star,
                        //                             color: Colors.amber,
                        //                           ),
                        //                           onRatingUpdate: (rating) {
                        //                             _rating = rating.toInt().toString();
                        //                           },
                        //                         ),
                        //
                        //                       ],
                        //                     ),
                        //                     SizedBox(height: 15,),
                        //                     TextFormField(
                        //                       controller: mesg,
                        //                       decoration: const InputDecoration(
                        //                         prefixIcon: Row(
                        //                           mainAxisSize: MainAxisSize.min,
                        //                           children: [Icon(Icons.face_outlined), Text("تعليقك...")],
                        //                         ),
                        //                         focusedBorder: OutlineInputBorder(
                        //                           borderSide: BorderSide(
                        //                             color: Colors.grey,
                        //                             width: 1,
                        //                           ),
                        //                         ),
                        //                         enabledBorder: OutlineInputBorder(
                        //                           borderSide: BorderSide(color: Colors.grey, width: 1),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                     SizedBox(height: 25,),
                        //                     Container(
                        //                       width: 150,
                        //                       decoration: ShapeDecoration(
                        //                         shape: RoundedRectangleBorder(
                        //                           side: const BorderSide(
                        //                               width: 1.50, color: mainColor),
                        //                           borderRadius: BorderRadius.circular(4),
                        //                         ),
                        //                       ),
                        //                       child: ButtonUtils(
                        //                           text: 'ارسال',
                        //                           onPressed: (){
                        //
                        //                             if(_rating.isEmpty){
                        //                               Get.snackbar('خطا', 'برجاء تقييم خدمة التوصيل',backgroundColor: Colors.deepOrangeAccent) ;
                        //                             }else{
                        //                               var body = {
                        //                                 "representative_id":item.id,
                        //                                 "rate_category_id":'2',
                        //                                 "rating":_rating,
                        //                                 "comment": mesg.text.trim(),
                        //                               };
                        //                               controller.show_Customer_rating(body);
                        //                               Navigator.pop(context);
                        //                             }
                        //
                        //                             },
                        //                           colorstext: mainColor,
                        //                           background: Colors.white),
                        //                     ),
                        //
                        //                   ],
                        //                 ),
                        //               ),
                        //
                        //             ),
                        //           );
                        //         },
                        //         colorstext: mainColor,
                        //         background: Colors.white),
                        //   ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}

// ListView(
//                             shrinkWrap: true,
//                             scrollDirection: Axis.horizontal,
//                             physics: const NeverScrollableScrollPhysics(),
//                             children: [
//                               MyTimeLineTitle(
//                                   isText: true, //الطلب معلق
//                                   isFirst: true,
//                                   isLast: false,
//                                   isPast: controller.orderStatusItemList[index].type== 1 ||
//                                           controller.orderStatusItemList[index].type== 2 ||
//                                           controller.orderStatusItemList[index].type== 3
//                                       ? true
//                                       : false,
//                                   text: controller.orderStatusItemList[index].type== 1
//                                       ? '${controller.status}'
//                                       : 'الطلب معلق'.tr),
//                               MyTimeLineTitle(
//                                   isText: controller.orderStatusItemList[index].type== 2 ||
//                                           controller.orderStatusItemList[index].type== 3
//                                       ? true
//                                       : false, //تم قبول الطلب
//                                   isFirst: false,
//                                   isLast: false,
//                                   isPast: controller.orderStatusItemList[index].type== 3 ||
//                                           controller.orderStatusItemList[index].type== 2
//                                       ? true
//                                       : false,
//                                   text: controller.orderStatusItemList[index].type== 2
//                                       ? '${controller.status}'
//                                       : 'تم قبول الطلب'.tr),
//                               MyTimeLineTitle(
//                                   isText: controller.orderStatusItemList[index].type== 3 ? true : false,
//                                   isFirst: false,
//                                   isLast: true,
//                                   isPast: controller.orderStatusItemList[index].type== 3 ? true : false,
//                                   text: '${controller.status}'),
//                             ],
//                           ),
