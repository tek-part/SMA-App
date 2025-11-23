// import 'package:bandora_app/view/widget/cart/prices_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../logic/controller/check_out_controller.dart';
import '../../../utils/them.dart';
import '../text_utils.dart';

class SummeryPayMent extends StatelessWidget {
  SummeryPayMent({super.key});

  CheckOutController controller = Get.put(CheckOutController());

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 230.h,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 2.50, color: mainColor),
            borderRadius: BorderRadius.circular(8.r),
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
        child: GetBuilder<CheckOutController>(
          builder: (_) {
            if (controller.isLoading.value) {
              return Center(
                child: Lottie.asset(
                    'assets/lottie/Animation - 1700235949032.json',
                    fit: BoxFit.fill),
              );
            } else {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: TextUtils(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          text: 'ملخص الدفع'.tr),
                    ),
                    const SizedBox(height: 10),
                    // PricesWidget(
                    //   textColor: Colors.black,
                    //   priceColor: Colors.black,
                    //   text: 'المجموع الأولي'.tr,
                    //   price: '${controller.checkOutPageList[0].total} د.ع',
                    // ),
                    // Container(
                    //     margin:const EdgeInsetsDirectional.symmetric(vertical: 6),
                    //     child: const Divider(color: Colors.black, height: 1)),
                    // PricesWidget(
                    //   textColor: Colors.black,
                    //   priceColor: Colors.black,
                    //   text: 'تكلفة التوصيل'.tr,
                    //   price:
                    //       '${controller.checkOutPageList[0].deliveryCost} د.ع',
                    // ),
                    // Container(
                    //     margin:const EdgeInsetsDirectional.symmetric(vertical: 6),
                    //     child: const Divider(color: Colors.black, height: 1)),
                    // PricesWidget(
                    //   textColor: mainColor,
                    //   priceColor: mainColor,
                    //   text: 'كوبون الخصم'.tr,
                    //   price:
                    //       '${controller.checkOutPageList[0].couponDiscount} د.ع',
                    // ),
                    // Container(
                    //     margin:const EdgeInsetsDirectional.symmetric(vertical: 6),
                    //     child: const Divider(color: Colors.black, height: 1)),
                    // PricesWidget(
                    //   textColor: Colors.black,
                    //   priceColor: Colors.black,
                    //   text: 'المجموع النهائي النقدي'.tr,
                    //   price: '${controller.checkOutPageList[0].subTotal} د.ع',
                    // ),
                  ]);
            }
          },
        ));
  }
}
