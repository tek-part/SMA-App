import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../logic/controller/brand_controller.dart';
import '../../../logic/controller/brand_product_controller.dart';
import '../../brand_product_screen.dart';
import '../loading/loading_marker.dart';

// ignore: must_be_immutable
class MarkitingLogos extends StatelessWidget {
  BrandController controller = Get.put(BrandController());
  BrandProoductController brandProoductController =
      Get.put(BrandProoductController());

  MarkitingLogos({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Column(
          children: [
            //المزيد
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Align(
                alignment: AlignmentDirectional.bottomStart,
                child: TextUtils(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    text: 'العلامات التجارية الرائجة'.tr),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            loadingMarker(),
            const SizedBox(
              height: 40,
            ),
          ],
        );
      } else if (controller.brandList.isEmpty) {
        return const Text('');
      } else {
        return SizedBox(
          width: MediaQuery.of(context).size.width / 1,
          height: MediaQuery.of(context).size.height / 5.5,
          child: Column(
            children: [
              //المزيد
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Align(
                  alignment: AlignmentDirectional.bottomStart,
                  child: TextUtils(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      text: 'العلامات التجارية الرائجة'.tr),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.brandList.length,
                  itemBuilder: (context, index) {
                    return UniqueProduct(
                      onTap: () {
                        brandProoductController.brandProductList.clear();
                        brandProoductController
                            .getProducrtDetails(controller.brandList[index].id);
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: BrandProductScreen(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      image: controller.brandList[index].image,
                      name: controller.brandList[index].name,
                    );
                  },
                ),
              ),
              // Obx(() {
              //   if (controller.isLoading.value) {
              //     return loadingMarker();
              //   } else {
              //     return Expanded(
              //       child: ListView.builder(
              //         physics: const BouncingScrollPhysics(),
              //         scrollDirection: Axis.horizontal,
              //         itemCount: controller.brandList.length,
              //         itemBuilder: (context, index) {
              //           return UniqueProduct(
              //             onTap: () {
              //               brandProoductController.brandProductList.clear();
              //               brandProoductController
              //                   .getProducrtDetails(controller.brandList[index].id);
              //               PersistentNavBarNavigator.pushNewScreen(
              //                 context,
              //                 screen: BrandProductScreen(),
              //                 withNavBar: true, // OPTIONAL VALUE. True by default.
              //                 pageTransitionAnimation:
              //                     PageTransitionAnimation.cupertino,
              //               );
              //             },
              //             image: controller.brandList[index].image,
              //             name: controller.brandList[index].name,
              //           );
              //         },
              //       ),
              //     );
              //   }
              // })
            ],
          ),
        );
      }
    });
  }

  // ignore: non_constant_identifier_names
  Widget UniqueProduct({
    required String image,
    required String name,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.fill,
                ),
                shape: const OvalBorder(),
              ),
            ),
            TextUtils(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                text: name),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
