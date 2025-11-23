import 'package:bandora_app/utils/my_strings.dart';
import 'package:bandora_app/view/widget/profile/radio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../logic/controller/brand_controller.dart';
import '../../../logic/controller/category_controller.dart';
import '../../../logic/controller/childern_category.dart';
import '../../../logic/controller/featured_product_controller.dart';
import '../../../logic/controller/language_controller.dart';
import '../../../logic/controller/main_catogery_controller.dart';
import '../../../logic/controller/setting_controller.dart';
import '../../../utils/them.dart';
import '../button_utils.dart';
import '../text_utils.dart';

// ignore: must_be_immutable
class ChooseLanguageWidget extends StatelessWidget {
  ChooseLanguageWidget({super.key});

  SettingController controller = Get.put(SettingController());
  LanguageController lanController = Get.put(LanguageController());
  CategoryController categoryController = Get.put(CategoryController());
  FeaturedProductController featuredProductController =
      Get.put(FeaturedProductController());
  BrandController brandController = Get.put(BrandController());
  ChildrenCategory childrenCategory = Get.put(ChildrenCategory());
  MainCatogeryController mainCatogeryController =
      Get.put(MainCatogeryController());
  bool chose = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
      builder: (_) {
        return Container(
          width: 375,
          height: 208,
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TextUtils(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  text: 'تغيير اللغة'),
              const Divider(
                height: 2,
                color: GreyClr,
              ),
              //english
              InkWell(
                onTap: () {
                  controller.change = false;
                  lanController.getLanguage('en');
                  controller.changeLanguage(ene);

                  //refresh app

                  featuredProductController.getFeaturedProduct();
                  categoryController.getAllCategory();
                  brandController.getAllCategory();
                  mainCatogeryController.getOfferProducts();
                  mainCatogeryController.getOnlyProducts();
                  Get.defaultDialog(
                    backgroundColor: Colors.white,
                    title: '',
                    titlePadding: const EdgeInsets.all(0),
                    titleStyle: const TextStyle(
                      height: 0,
                      letterSpacing: -0.30,
                    ),
                    middleText: '',
                    actions: [
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            LottieBuilder.asset(
                                'assets/lottie/Animation - 1700590566145.json',
                                height: 100,
                                width: 100,
                                fit: BoxFit.fill),
                            const TextUtils(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: mainColor,
                                text: 'Changed to English language'),
                          ],
                        ),
                      ),
                      ButtonUtils(
                          text: 'تم',
                          onPressed: () {
                            lanController.getLanguage('en');
                            controller.changeLanguage(ene);

                            //refresh app

                            featuredProductController.getFeaturedProduct();
                            categoryController.getAllCategory();
                            brandController.getAllCategory();
                            mainCatogeryController.getOfferProducts();
                            mainCatogeryController.getOnlyProducts();
                            Get.back();
                          },
                          colorstext: Colors.black,
                          background: mainColor)
                    ],
                    middleTextStyle: const TextStyle(
                      height: 0,
                      letterSpacing: -0.30,
                    ),
                  );
                },
                child: Row(
                  children: [
                    //radio
                    controller.langlocal == ara
                        ? Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            decoration: const ShapeDecoration(
                              shape: OvalBorder(
                                side: BorderSide(width: 2, color: mainColor),
                              ),
                            ),
                          )
                        : radioWidget(),

                    const TextUtils(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        text: 'English')
                  ],
                ),
              ),
              //arabic
              InkWell(
                onTap: () {
                  controller.change = true;
                  controller.changeLanguage(ara);
                  lanController.getLanguage('ar');

                  //refresh app

                  featuredProductController.getFeaturedProduct();
                  categoryController.getAllCategory();
                  brandController.getAllCategory();
                  mainCatogeryController.getOfferProducts();
                  mainCatogeryController.getOnlyProducts();

                  //dialog
                  Get.defaultDialog(
                    backgroundColor: Colors.white,
                    title: '',
                    titlePadding: const EdgeInsets.all(0),
                    titleStyle: const TextStyle(
                      height: 0,
                      letterSpacing: -0.30,
                    ),
                    middleText: '',
                    actions: [
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            LottieBuilder.asset(
                                'assets/lottie/Animation - 1700590566145.json',
                                height: 100,
                                width: 100,
                                fit: BoxFit.fill),
                            const TextUtils(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: mainColor,
                                text: 'تم التغير  الى الغة العربيه '),
                          ],
                        ),
                      ),
                      ButtonUtils(
                          text: 'تم',
                          onPressed: () {
                            controller.changeLanguage(ara);
                            lanController.getLanguage('ar');

                            //refresh app

                            featuredProductController.getFeaturedProduct();
                            categoryController.getAllCategory();
                            brandController.getAllCategory();
                            mainCatogeryController.getOfferProducts();
                            mainCatogeryController.getOnlyProducts();
                            Get.back();
                          },
                          colorstext: Colors.black,
                          background: mainColor)
                    ],
                    middleTextStyle: const TextStyle(
                      height: 0,
                      letterSpacing: -0.30,
                    ),
                  );

                  //assets/lottie/Animation - 1700590566145.json
                },
                child: Row(
                  children: [
                    //radio
                    // controller.change
                    controller.langlocal == ara
                        ? radioWidget()
                        : Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            decoration: const ShapeDecoration(
                              shape: OvalBorder(
                                side: BorderSide(width: 2, color: mainColor),
                              ),
                            ),
                          ),

                    const TextUtils(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        text: 'العربية'),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        );
      },
    );
  }
}

// Widget ChooseLanguageWidget({

// }) {
//   return
// }
