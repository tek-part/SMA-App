import 'package:bandora_app/core/helpers/spacing.dart';
import 'package:bandora_app/view/screen/prouct_details_screen.dart';
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../logic/controller/cart_controller.dart';
import '../../logic/controller/category_controller.dart';
import '../../logic/controller/childern_category.dart';
import '../../logic/controller/product_category_controller.dart';
import '../../logic/controller/product_details_controller.dart';
import '../../utils/them.dart';
import '../widget/like_list.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  PageController pageController = PageController();

  CategoryController categoryController = Get.put(CategoryController());
  ChildrenCategory controller = Get.put(ChildrenCategory());
  ProductCatogeryController productCatogeryController = Get.put(ProductCatogeryController());
  ProductDetails productcontroller = Get.put(ProductDetails());
  CartController cartController = Get.put(CartController());

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    int current = categoryController.index;
    setState(() {
      categoryController.index = current;
      print(current);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'المنتجات'.tr,
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
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            /// Tab Bar
            SizedBox(
                width: double.infinity,
                height: Get.height * 0.1,
                child: Obx(() {
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: categoryController.allCatogeryList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (categoryController.index != index) {
                                  setState(() {
                                    // current = index;
                                    categoryController.index = index;
                                    controller.getProducrtDetails(
                                        categoryController.allCatogeryList[index].id);
                                    if (controller
                                        .childrenCategoryList.isNotEmpty) {
                                      controller.clearList();
                                    }
                                    if (productCatogeryController
                                        .productCategoryList.isNotEmpty) {
                                      productCatogeryController.clearList();
                                    }
                                  });
                                  pageController.animateToPage(
                                    current,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.ease,
                                  );
                                }

                                pageController.animateToPage(
                                  current,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.ease,
                                );
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),

                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: current == index
                                      ? BorderRadius.circular(12)
                                      : BorderRadius.circular(7),
                                ),
                                //الكاتوجرى
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    categoryController
                                                        .allCatogeryList[index]
                                                        .image),
                                                fit: BoxFit.fill)),
                                      ),
                                      Text(
                                        categoryController
                                            .allCatogeryList[index].name,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.w500,
                                          height: 0.08,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            //الخط
                            Visibility(
                              visible: categoryController.index == index,
                              //  current == index,
                              child: Container(
                                width: 80,
                                height: 2,
                                decoration: const BoxDecoration(
                                  color: mainColor,
                                ),
                              ),
                            )
                          ],
                        );
                      });
                })),

            /// MAIN BODY
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1.38,
                child: PageView.builder(
                  itemCount: categoryController.allCatogeryList.length,
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    print(pageController);
                    return Column(
                      children: [
                        GetBuilder<ChildrenCategory>(
                          builder: (_) {
                            if (controller.isLoading.value) {
                              return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 1.6,
                                  child: Lottie.asset(
                                      'assets/lottie/Animation - 1699229588778.json',
                                      fit: BoxFit.contain,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1,
                                      width: MediaQuery.of(context).size.width /
                                          1.5));
                            } else if (controller
                                .childrenCategoryList.isEmpty) {
                              return const Text('');
                            } else {
                              return const SizedBox(
                                height: 60,
                                width: double.infinity,
                                child: LikeList(),
                              );
                            }
                          },
                        ),
                        GetBuilder<ProductCatogeryController>(
                          builder: (_) {
                            if (productCatogeryController.isLoading.value &
                                controller.childrenCategoryList.isEmpty) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: mainColor,
                                ),
                              );
                            } else if (productCatogeryController.empty.value &
                                controller.childrenCategoryList.isNotEmpty) {
                              return Center(
                                child: Lottie.asset(
                                    'assets/lottie/Animation - 1699311761861.json'),
                              );
                            } else {
                              return NotificationListener(
                                onNotification: (notification) {
                                  if (notification is ScrollEndNotification &&
                                      notification.metrics.extentAfter == 0) {
                                    productCatogeryController.isLoadMore(true);

                                    productCatogeryController.page++;
                                    // controller.getAllCategory();
                                    productCatogeryController.paginateTask();
                                    print(productCatogeryController.page);
                                  }
                                  return true;
                                },
                                child: Expanded(
                                  child: ListView(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    children: [
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: productCatogeryController
                                            .productCategoryList.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 10.0,
                                                mainAxisExtent: 250),
                                        itemBuilder: (context, index) {
                                          return Product(
                                              cartTap: () {
                                                cartController.qty.value = 1;
                                                cartController.postCartData(productCatogeryController.productCategoryList[index].id.toString());
                                              },
                                              onTap: () {
                                                productcontroller
                                                    .productDetailsList
                                                    .clear();
                                                cartController.qty.value = 1;
                                                productcontroller.getProducrtDetails(productCatogeryController.productCategoryList[index].id);
                                                PersistentNavBarNavigator
                                                    .pushNewScreen(
                                                  context,
                                                  screen:
                                                      ProductDetailsScreen(),
                                                  withNavBar: true,
                                                  pageTransitionAnimation:
                                                      PageTransitionAnimation
                                                          .cupertino,
                                                );
                                              },
                                              image: productCatogeryController
                                                  .productCategoryList[index]
                                                  .image,
                                              name: productCatogeryController
                                                  .productCategoryList[index]
                                                  .name,
                                              price: productCatogeryController
                                                  .productCategoryList[index]
                                                  .price
                                                  .toString());
                                        },
                                      ),
                                      // productCatogeryController.isEmpty.value ==
                                      //         false
                                      //     ? Center(
                                      //         child: TextUtils(
                                      //             fontSize: 12,
                                      //             fontWeight: FontWeight.w500,
                                      //             color: GreyClr,
                                      //             text: ''.tr))
                                      //     : Center(
                                      //         child: TextUtils(
                                      //             fontSize: 12,
                                      //             fontWeight: FontWeight.w500,
                                      //             color: GreyClr,
                                      //             text:
                                      //                 'لا توجد طلبات اخرى '.tr)),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Product({
    required String name,
    required String price,
    required String image,
    required Function() onTap,
    required Function() cartTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 200,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 0.50, color: Color(0xFFCED5E1)),
            borderRadius: BorderRadius.circular(15),
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
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.contain),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      name,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  // TextUtils(
                  //     fontSize: 12,
                  //     fontWeight: FontWeight.w500,
                  //     color: Colors.black,
                  //     text: '$price د.ع'),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: double.infinity,
                    height: 30,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                      ),
                      onPressed: cartTap,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.black,
                            size: 12,
                          ),
                          const SizedBox(width: 3),
                          Flexible(
                            child: Text(
                              'اضافة الي السلة'.tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
