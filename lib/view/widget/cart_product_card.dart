// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../logic/controller/cart_controller.dart';
import '../../logic/controller/cart_item_controller.dart';
import '../../logic/controller/product_details_controller.dart';
import '../../utils/them.dart';

// ignore: must_be_immutable
class CartProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String describtion;
  final int price;
  final int qty;
  final int id;
  final Function() add;
  final Function() min;
  final Function() deleatTap;
  CartItemController controller = Get.put(CartItemController());
  CartController cartController = Get.put(CartController());
  ProductDetails productDetails = Get.put(ProductDetails());

  CartProductCard({
    Key? key,
    required this.image,
    required this.name,
    required this.describtion,
    required this.price,
    required this.qty,
    required this.add,
    required this.min,
    required this.deleatTap,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
          width: double.infinity,
          height: 170.h,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 0.50, color: Color(0xFFCED5E1)),
              borderRadius: BorderRadius.circular(4.r),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x4C7785DB),
                blurRadius: 1,
                offset: Offset(0.50, 1),
                spreadRadius: 0,
              )
            ],
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: double.infinity,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: NetworkImage(image),
                          fit: BoxFit.contain,
                        ),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0.50, color: Color(0xFFCED5E1)),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Container(
                        height: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //name
                            TextUtils(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                text: name),

                            //describtion
                            TextUtils(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                text: describtion),

                            //add / minus
                            Obx(() {
                              return controller.isLoading.value
                                  ? Row(
                                      children: [
                                        AM(
                                          colors: mainColor.withOpacity(0.3),
                                          icons: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Lottie.asset(
                                            'assets/lottie/Animation - 1700235949032.json',
                                            height: 32,
                                            width: 32,
                                            fit: BoxFit.fill),
                                        AM(
                                          colors: const Color(0xFFF6F9FF)
                                              .withOpacity(0.7),
                                          icons: const Icon(
                                            Icons.remove,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        InkWell(
                                          onTap: add,
                                          child: AM(
                                            colors: mainColor,
                                            icons: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: TextUtils(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                              text: '$qty'),
                                        ),
                                        InkWell(
                                          onTap: min,
                                          child: AM(
                                            colors: const Color(0xFFF6F9FF),
                                            icons: const Icon(
                                              Icons.remove,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                            }),

                            //price
                            // TextUtils(
                            //     fontSize: 14,
                            //     fontWeight: FontWeight.w500,
                            //     color: Colors.black,
                            //     text: '$price د.ع'),
                          ],
                        ),
                      ))
                ],
              ),
              PositionedDirectional(
                  end: 16,
                  top: 20,
                  child: InkWell(
                    onTap: deleatTap,
                    child: const Icon(
                      Icons.delete,
                      color: mainColor,
                    ),
                  )),
              Obx(() {
                return PositionedDirectional(
                  end: 16,
                  bottom: 16,
                  child: InkWell(
                      onTap: () {
                        productDetails.isFavourites(id)
                            ? productDetails.manageFavourites(id)
                            : controller.manageFavourites(id);
                      },
                      child: controller.isFavourites(id) ||
                              productDetails.isFavourites(id)
                          ? Icon(
                              Icons.favorite,
                              color: Get.isDarkMode ? mainColor : mainColor,
                            )
                          : Icon(
                              Icons.favorite_border_outlined,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            )),
                );
              }),
            ],
          )),
    );
  }

  // ignore: non_constant_identifier_names
  Widget AM({
    required Color colors,
    required Icon icons,
  }) {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
          color: colors,
          borderRadius: const BorderRadius.all(Radius.circular(4))),
      child: Align(alignment: Alignment.center, child: icons),
    );
  }
}
