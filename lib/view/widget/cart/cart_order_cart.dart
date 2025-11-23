// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/them.dart';

class CartOrderCard extends StatelessWidget {
  const CartOrderCard({
    Key? key,
    required this.image,
    required this.name,
    required this.descriptoin,
    required this.qty,
    required this.price,
  }) : super(key: key);
  final String image;
  final String name;
  final String descriptoin;
  final int qty;
  final String price;

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
                        // height: double.infinity,
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
                            Text(
                              descriptoin,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontFamily: 'Cairo',
                                  letterSpacing: -0.30,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            //count
                            Row(
                              children: [
                                const TextUtils(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    text: 'الكمية'),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Container(
                                  width: 24.w,
                                  height: 24.h,
                                  decoration: ShapeDecoration(
                                    color: mainColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4.r)),
                                  ),
                                  child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        '$qty',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.w400,
                                          height: 1.5,
                                        ),
                                      )),
                                )
                              ],
                            ),

                            //price
                            // TextUtils(
                            //     fontSize: 14,
                            //     fontWeight: FontWeight.w500,
                            //     color: Colors.black,
                            //     text: '$price د.ع'),

                            // SizedBox(height: 50,),
                          ],
                        ),
                      ))
                ],
              ),
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
      height: 25.h,
      width: 25.w,
      decoration: BoxDecoration(
          color: colors,
          borderRadius: BorderRadius.all(Radius.circular(4.r))),
      child: Align(alignment: Alignment.center, child: icons),
    );
  }
}
