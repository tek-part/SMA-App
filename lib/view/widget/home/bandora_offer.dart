// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../utils/them.dart';
import '../../screen/bandora_product_screen.dart';
import '../../screen/offer_product_screen.dart';
import '../text_utils.dart';

class BandoraOffer extends StatelessWidget {
  const BandoraOffer({
    Key? key,
    required this.offerNumber,
    required this.bandoranumber,
  }) : super(key: key);
  final String offerNumber;
  final String bandoranumber;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          //Bandora
          InkWell(
            onTap: () {
              // PersistentNavBarNavigator.pushNewScreen(
              //   context,
              //   screen: BandoraProductScreen(),
              //   withNavBar: true, // OPTIONAL VALUE. True by default.
              //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
              // );
              Get.to(() => BandoraProductScreen());
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2.38,
              height: MediaQuery.of(context).size.height / 12,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.50, color: Color(0xFFCED5E1)),
                  borderRadius: BorderRadius.circular(4),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x7FCCCCCC),
                    blurRadius: 8,
                    offset: Offset(1, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 10),
                    child: TextUtils(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: mainColor,
                        text: 'فقط عند SAM\n'.tr + bandoranumber + ' منتج'.tr),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Image.asset(
                        'assets/images/WhatsApp_Image_2023-12-22_at_12.49.01_PM-removebg-preview.png',
                        width: MediaQuery.of(context).size.width / 5,
                        fit: BoxFit.contain),
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
          //offer
          InkWell(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: OfferProductScreen(),
                withNavBar: true, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
              // Get.toNamed(Routes.OfferProductScreen);
            },
            child: DottedBorder(
              radius: const Radius.circular(4),
              borderType: BorderType.RRect,
              color: mainColor,
              child: Container(
                width: MediaQuery.of(context).size.width / 2.4,
                height: MediaQuery.of(context).size.height / 13.4,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(),
                  shadows: [
                    BoxShadow(
                      color: Color(0x7FCCCCCC),
                      blurRadius: 8,
                      offset: Offset(1, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 5),
                      child: TextUtils(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: mainColor,
                          // 'متاح فى العروض\nالأسبوعية ${offerNumber} منتج'
                          text: 'متاح فى العروض\nالأسبوعية '.tr +
                              offerNumber +
                              ' منتج'.tr),
                    ),
                    Image.asset('assets/images/discound.png',
                        width: MediaQuery.of(context).size.width / 5.5,
                        fit: BoxFit.cover),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
