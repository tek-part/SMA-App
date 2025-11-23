// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controller/check_out_controller.dart';
import '../../../logic/controller/status_cotroller.dart';
import '../../../utils/them.dart';
import '../../screen/check_screen.dart';
import '../text_utils.dart';

// ignore: must_be_immutable
class CartTotal extends StatelessWidget {
  CheckOutController controller = Get.put(CheckOutController());
  StatusContrller statusContrller = Get.put(StatusContrller());

  CartTotal({
    Key? key,
    required this.total,
  }) : super(key: key);
  final String total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          // Expanded(
          //     flex: 2,
          //     child: TextUtils(
          //         fontSize: 16,
          //         fontWeight: FontWeight.w600,
          //         color: Colors.black,
          //         text: '$total د.ع')),
          Expanded(
            flex: 4,
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      elevation: 0,
                      backgroundColor: mainColor,
                      foregroundColor: Colors.black),
                  onPressed: () {
                    controller.getCheckOutPage();
                    // statusContrller.stutus
                    //     ?
                    Get.to(CheckScreen());
                    // : Get.defaultDialog(
                    //     backgroundColor: Colors.white,
                    //     title: '',
                    //     titlePadding: const EdgeInsets.all(0),
                    //     titleStyle: const TextStyle(
                    //       height: 0,
                    //       letterSpacing: -0.30,
                    //     ),
                    //     middleText: '',
                    //     actions: [
                    //       SizedBox(
                    //         width: double.infinity,
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             Lottie.asset(
                    //                 'assets/lottie/Animation - 1700525647440.json',
                    //                 height: 100,
                    //                 width: 100,
                    //                 fit: BoxFit.contain),
                    //             TextUtils(
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.w600,
                    //                 color: mainColor,
                    //                 text: 'عذرا!'.tr),
                    //             SizedBox(
                    //               width: 201.87,
                    //               child: Text(
                    //                 "مركز التسوق مغلق الان  رجائا حاول وقت اخر"
                    //                     .tr
                    //                     .tr,
                    //                 textAlign: TextAlign.center,
                    //                 style: const TextStyle(
                    //                   color: GreyClr,
                    //                   fontSize: 14,
                    //                   fontFamily: 'Cairo',
                    //                   fontWeight: FontWeight.w500,
                    //                   height: 0,
                    //                   letterSpacing: -0.30,
                    //                 ),
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //       ButtonUtils(
                    //           text: 'تم'.tr,
                    //           onPressed: () {
                    //             Get.back();
                    //           },
                    //           colorstext: Colors.white,
                    //           background: mainColor)
                    //     ],
                    //     middleTextStyle: const TextStyle(
                    //       height: 0,
                    //       letterSpacing: -0.30,
                    //     ),
                    //   );
                  },
                  child: TextUtils(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      text: 'إنتقل إلي الدفع'.tr)),
            ),
          )
        ],
      ),
    );
  }
}
