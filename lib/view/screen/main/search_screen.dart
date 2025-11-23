import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../logic/controller/cart_controller.dart';
import '../../../logic/controller/product_details_controller.dart';
import '../../../logic/controller/search_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/them.dart';
import '../../widget/search/search_text_form_field.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  Search controller = Get.put(Search());
  ProductDetails productcontroller = Get.put(ProductDetails());
  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'بحث'.tr,
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
          elevation: 0,
          centerTitle: true,
          backgroundColor: mainColor,
          leading: const Text(''),
        ),
        body: Obx(() {
          if (controller.productCategoryList.isEmpty ||
              // ignore: unrelated_type_equality_checks
              controller.searchTextController == '') {
            return SerchFormText();
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SerchFormText(),
                //تم العثور
                Container(
                    height: MediaQuery.of(context).size.height / 9,
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: Text.rich(TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'تم العثور علي ${controller.productCategoryList.length} نتائج فى',
                          style: const TextStyle(
                            color: Color(0xFF262626),
                            fontSize: 14,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: -0.30,
                          ),
                        ),
                        const TextSpan(
                          text: ' “ ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: -0.30,
                          ),
                        ),
                        TextSpan(
                          text: controller.searchTextController.text,
                          style: const TextStyle(
                            color: Color(0xFF7785DB),
                            fontSize: 14,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: -0.30,
                          ),
                        ),
                        const TextSpan(
                          text: ' “',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: -0.30,
                          ),
                        ),
                      ],
                    ))),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextUtils(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: GreyClr,
                      text: 'نتائج التصنيفات'.tr),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() {
                  if (controller.productCategoryList.isEmpty) {
                    return const Text('');
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: controller.productCategoryList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Products(
                                onTap: () {
                                  productcontroller.productDetailsList.clear();
                                  cartController.qty.value = 1;
                                  productcontroller.getProducrtDetails(
                                      controller.productCategoryList[index].id);
                                  Get.toNamed(Routes.productDetailsScreen);
                                },
                                product:
                                    controller.productCategoryList[index].name),
                          );
                        },
                      ),
                    );
                  }
                })
              ],
            );
          }
        }));
  }

  // ignore: non_constant_identifier_names
  Widget Products({
    required String product,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/images/searchproduct.svg',
          ),
          const SizedBox(
            width: 7,
          ),
          TextUtils(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              text: product)
        ],
      ),
    );
  }
}
