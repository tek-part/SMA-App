import 'package:bandora_app/view/screen/prouct_details_screen.dart';
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../logic/controller/cart_controller.dart';
import '../../logic/controller/featured_product_controller.dart';
import '../../logic/controller/product_details_controller.dart';
import '../../utils/them.dart';

// ignore: must_be_immutable
class FeaturedProductScreen extends StatelessWidget {
  FeaturedProductScreen({super.key});

  FeaturedProductController controller = Get.put(FeaturedProductController());
  ProductDetails productcontroller = Get.put(ProductDetails());
  CartController cartController = Get.put(CartController());

  /// List of Tab Bar Item
  List<String> items = [
    "مخبوزات",
    "حليب و ألبان",
    "فواكه و خضروات",
    "أيس كريم",
    "Posts",
    "Activity",
    "Setting",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'المنتجات المميزة',
            textAlign: TextAlign.center,
            style: TextStyle(
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
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Obx(() {
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
                    controller.getFeaturedProduct();
                    return Future.delayed(const Duration(seconds: 1));
                  },
                  color: mainColor,
                  child: ListView(
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.featuredProductList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 30.0,
                                mainAxisExtent: 210),
                        itemBuilder: (context, index) {
                          return Product(
                              cartTap: () {
                                cartController.qty.value = 1;
                                cartController.postCartData(controller
                                    .featuredProductList[index].id
                                    .toString());
                              },
                              onTap: () {
                                productcontroller.productDetailsList.clear();
                                cartController.qty.value = 1;
                                productcontroller.getProducrtDetails(
                                    controller.featuredProductList[index].id);
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: ProductDetailsScreen(),
                                  withNavBar:
                                      true, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              },
                              image:
                                  controller.featuredProductList[index].image,
                              name: controller.featuredProductList[index].name,
                              Price: controller.featuredProductList[index].price
                                  .toString());
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
            })));
  }

  // ignore: non_constant_identifier_names
  Widget Product({
    required String image,
    required String name,
    // ignore: non_constant_identifier_names
    required String Price,
    required Function() onTap,
    required Function() cartTap,
  }) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 0.50, color: Color(0xFFCED5E1)),
            borderRadius: BorderRadius.circular(4),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x7FCCCCCD),
              blurRadius: 4,
              offset: Offset(0.50, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Stack(
          children: [
            InkWell(
              onTap: onTap,
              child: Column(
                children: [
                  Container(
                    height: 130,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(image), fit: BoxFit.fill)),
                  ),
                  // Image.network(image, height: 130, fit: BoxFit.fill),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        name,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis),
                      )),
                  // Align(
                  //   alignment: Alignment.bottomRight,
                  //   child: TextUtils(
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w400,
                  //       color: Colors.black,
                  //       text: '$Price د.ع'),
                  // ),
                ],
              ),
            ),
            Positioned(
                left: 5,
                top: 5,
                child: InkWell(
                  onTap: cartTap,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: mainColor),
                    child: const Center(
                        child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 14,
                    )),
                  ),
                )),
          ],
        ));
  }
}
