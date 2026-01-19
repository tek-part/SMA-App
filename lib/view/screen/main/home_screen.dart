import 'package:bandora_app/notifications/ui/screen/notifications.dart';
import 'package:bandora_app/utils/my_strings.dart';
import 'package:bandora_app/view/screen/bandora_product_screen.dart';
import 'package:bandora_app/view/screen/offer_product_screen.dart';
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:upgrader/upgrader.dart';
import '../../../logic/controller/brand_controller.dart';
import '../../../logic/controller/category_controller.dart';
import '../../../logic/controller/childern_category.dart';
import '../../../logic/controller/featured_product_controller.dart';
import '../../../logic/controller/main_catogery_controller.dart';
import '../../../logic/controller/order_status_controller.dart';
import '../../../logic/controller/product_category_controller.dart';
import '../../../logic/controller/setting_controller.dart';
import '../../../logic/controller/slider_controller.dart';
import '../../../logic/controller/status_cotroller.dart';
import '../../../notifications/logic/cubit/notifications_cubit.dart';
import '../../../notifications/logic/state/notifications_state.dart';
import '../../../utils/them.dart';
import '../../widget/home/feature_product.dart';
import '../../widget/home/image_slider.dart';
import '../../widget/home/markiting_logo.dart';
import '../../widget/loading/loading_category.dart';
import '../order_status_english.dart';
import '../order_status_screen.dart';
import '../product_screen.dart';
import '../../../core/networking/di/dependency_injection.dart' as di;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StatusContrller contrller = Get.put(StatusContrller());

  MainCatogeryController controller = Get.put(MainCatogeryController());

  CategoryController categoryController = Get.put(CategoryController());

  ChildrenCategory childrenCategory = Get.put(ChildrenCategory());

  ProductCatogeryController productCatogeryController =
      Get.put(ProductCatogeryController());

  // NotificationController notificationController =
  //     Get.put(NotificationController());

  OrderStatusController orderStatusController =
      Get.put(OrderStatusController());

  SettingController settingController = Get.put(SettingController());

  FeaturedProductController featuredProductController =
      Get.put(FeaturedProductController());

  BrandController brandController = Get.put(BrandController());

  SliderController sliderController = Get.put(SliderController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sliderController.isContainerVisible.value = true;
      // تحميل الإشعارات عند بدء التطبيق
      try {
        final notificationsCubit = di.getIt<NotificationsCubit>();
        notificationsCubit.fetchFirstPage();
      } catch (e) {
        print('❌ Error loading notifications: $e');
      }
    });
  }

  @override
  void dispose() {
    sliderController.isContainerVisible.value;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 90.h,
          title: Image.asset(
            'assets/images/sme_logo.png',
            height: 90.h,
            fit: BoxFit.contain,
            color: Colors.black,
          ),
          /*    leading: Center(
            child: InkWell(
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: settingController.langlocal == ara
                      ? OrderStatusScreen()
                      : OrderStatusEnglishScreen(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: Center(
                child: GetBuilder<OrderStatusController>(
                  builder: (controller) {
                    Color iconColor = Colors.red;
                    if (controller.orderStatusItemList.isNotEmpty) {
                      bool isAllCompletedOrDeclined =
                          controller.orderStatusItemList.every(
                        (item) =>
                            item.status == 'اكتمل' || item.status == 'ملغي',
                      );
                      if (isAllCompletedOrDeclined) {
                        iconColor = Colors.red.shade50;
                      }
                    }

                    return Center(
                      child: Container(
                        margin: EdgeInsets.only(right: 12.w),
                        child: Column(
                          children: [
                            Icon(
                              Icons.delivery_dining,
                              size: 50.sp,
                              color: iconColor,
                            ),
                            const Text(
                              'تتبع الطلب',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
    */
          actions: [
            BlocProvider(
              create: (_) => di.getIt<NotificationsCubit>(),
              child: BlocBuilder<NotificationsCubit, NotificationsState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: BlocProvider(
                          create: (_) => di.getIt<NotificationsCubit>(),
                          child: const NotificationsScreen(),
                        ),
                        withNavBar: true,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 15, 15, 0),
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: SvgPicture.asset(
                              'assets/images/notiffff.svg',
                              width: 20.w,
                              height: 20.w,
                              colorFilter: const ColorFilter.mode(
                                Colors.black,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          // عداد الإشعارات غير المقروءة
                          state.when(
                                initial: () => const SizedBox.shrink(),
                                loading: () => const SizedBox.shrink(),
                                success: (notificationsResponse) {
                                  final unreadCount =
                                      notificationsResponse.data?.unreadCount ??
                                          0;
                                  if (unreadCount > 0) {
                                    return Positioned(
                                      right: -2,
                                      top: -2,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        constraints: const BoxConstraints(
                                          minWidth: 18,
                                          minHeight: 18,
                                        ),
                                        child: Text(
                                          unreadCount > 99
                                              ? '99+'
                                              : unreadCount.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                                error: (error) => const SizedBox.shrink(),
                              ) ??
                              const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
          elevation: 0,
          centerTitle: true,
          backgroundColor: mainColor,
        ),
        body: UpgradeAlert(
          upgrader: Upgrader(
            languageCode: 'ar',
            messages: UpgraderMessages(code: 'ar'),
            countryCode: 'EG', 
          ),
          child: RefreshIndicator(
            onRefresh: () {
              contrller.getStatus();
              controller.getOfferProducts();
              controller.getOnlyProducts();
              categoryController.getAllCategory();
              //notificationController.getNotificationItem();
              orderStatusController.getOrderStatusItem();
              featuredProductController.getFeaturedProduct();
              brandController.getAllCategory();
              sliderController.getSlider();
              // تحديث الإشعارات
              try {
                final notificationsCubit = di.getIt<NotificationsCubit>();
                notificationsCubit.fetchFirstPage();
              } catch (e) {
                print('❌ Error refreshing notifications: $e');
              }
              return Future.delayed(const Duration(seconds: 2));
            },
            color: mainColor,
            child: Stack(children: [
              ListView(
                children: [
                  const Imagesliders(),
                  Obx(() {
                    return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                // controller.getOnlyProducts();
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: BandoraProductScreen(),
                                  withNavBar: true,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              },
                              child: Container(
                                width: 157.w,
                                height: 68.h,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 0.50, color: Color(0xFFCED5E1)),
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
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 10),
                                      child: TextUtils(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          text: 'فقط عند SMA\n'.tr +
                                              controller.productNum.toString() +
                                              ' منتج'.tr),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Image.asset(
                                          'assets/images/sme_logo.png',
                                          width: 75.w,
                                          fit: BoxFit.contain),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                // controller.getOfferProducts();
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: OfferProductScreen(),
                                  withNavBar:
                                      true, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );

                                // Get.toNamed(Routes.OfferProductScreen);
                              },
                              child: DottedBorder(
                                options: RectDottedBorderOptions(
                                  color: mainColor,
                                  dashPattern: [10, 10],
                                ),
                                child: Container(
                                  width: 156.w,
                                  height: 61.h,
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
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 5),
                                        child: TextUtils(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            text: 'متاح فى العروض\nالأسبوعية '
                                                    .tr +
                                                controller
                                                    .offerProductList.length
                                                    .toString() +
                                                ' منتج'.tr),
                                      ),
                                      Image.asset('assets/images/discound.png',
                                          width: 68.w, fit: BoxFit.cover),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ));
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  //Catogery
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(() {
                      if (categoryController.isLoading.value) {
                        return LoadingCatogery();
                      } else if (categoryController.allCatogeryList.isEmpty) {
                        return Center(
                          child: Lottie.asset(
                              'assets/lottie/Animation - 1699311761861.json'),
                        );
                      } else {
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: categoryController.allCatogeryList.length,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4, mainAxisExtent: 140.h),
                          itemBuilder: (context, index) {
                            return buildCatogeryItem(
                                width: 67.w,
                                height: 68.h,
                                onTap: () {
                                  categoryController.index = index;
                                  if (childrenCategory
                                      .childrenCategoryList.isNotEmpty) {
                                    childrenCategory.clearList();
                                  }
                                  childrenCategory.getProducrtDetails(
                                      categoryController
                                          .allCatogeryList[index].id);
                                  if (productCatogeryController
                                      .productCategoryList.isNotEmpty) {
                                    productCatogeryController.clearList();
                                  }

                                  // categoryController.inputIndex(index);
                                  //navigator
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context, screen: const ProductScreen(),
                                    withNavBar: true,
                                    // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                  // print(categoryController.allCatogeryList[index].name.length);
                                },
                                ellipsis: categoryController
                                            .allCatogeryList[index]
                                            .name
                                            .length >=
                                        21
                                    ? true
                                    : false,
                                text: categoryController
                                    .allCatogeryList[index].name,
                                image: categoryController
                                    .allCatogeryList[index].image);
                          },
                        );
                      }
                    }),
                  ),
                  //featureProduct
                  FeaturedProduct(),
                  //marketing
                  MarkitingLogos(),
                ],
              ),
              Obx(() {
                if (sliderController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (sliderController.sliderList.isNotEmpty &&
                    sliderController.isContainerVisible.value) {
                  return Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 30.h, horizontal: 16.w),
                            height: 528.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image:
                                    NetworkImage(sliderController.defaultImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 70,
                          right: 30,
                          child: GestureDetector(
                            onTap: () {
                              sliderController.isContainerVisible.value = false;
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }),
            ]),
          ),
        ));
  }

  Widget buildCatogeryItem({
    required double width,
    required double height,
    required String image,
    required String text,
    required bool ellipsis,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: width,
            height: height,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.contain,
              ),
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 0.50, color: Color(0xFFCED5E1)),
                borderRadius: BorderRadius.circular(60),
              ),
              shadows: const [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 8,
                  offset: Offset(0.50, 2),
                  spreadRadius: 0,
                )
              ],
            ),
          ),
          ellipsis
              ? Expanded(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w500,
                      height: 0,
                      overflow: TextOverflow.ellipsis,
                      letterSpacing: -0.30,
                    ),
                  ),
                )
              : Expanded(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w500,
                      height: 0,
                      overflow: TextOverflow.clip,
                      letterSpacing: -0.30,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
