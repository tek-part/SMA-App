import 'package:bandora_app/routes/routes.dart';
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../logic/controller/auth_controller.dart';
import '../../../logic/controller/current_order_controller.dart';
import '../../../logic/controller/order_controller.dart';
import '../../../logic/controller/previous_order_controller.dart';
import '../../../logic/controller/profile_data_controller.dart';
import '../../../utils/them.dart';
import '../../widget/profile/profile_data_widget.dart';
import '../../widget/profile/profile_widget.dart';
import '../setting/choose_location_screen.dart';
import '../setting/edit_profile_screen.dart';
import '../setting/order_screen.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  SignupController controller = SignupController();
  ProfileDataController profileController = ProfileDataController();
  OrderController orderController = Get.put(OrderController());
  PreviousOrderController previousOrderController =
      Get.put(PreviousOrderController());
  CurrentOrderController currentOrderController =
      Get.put(CurrentOrderController());

  // SettingController settingController = Get.put(SettingController());
  // LanguageController lanController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ملفي الشخصي'.tr,
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
        body: SingleChildScrollView(
            child: Container(
          // height: MediaQuery.of(context).size.height / 1.25,
          width: double.infinity,
          padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 16.h),
          child: GetStorage().read<bool>('auth') == true
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //profile photo
                    ProfileDataWidget(),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 325.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Profile
                          InkWell(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: EditProfileScreen(),
                                //  AddLocationScreen(),
                                withNavBar:
                                    true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: profileWidget(
                              icon: 'assets/images/profilelogo.svg',
                              text: 'تعديل الملف الشخصي'.tr,
                              textColor: Colors.black,
                            ),
                          ),
                          const Divider(
                            color: GreyClr,
                          ),
                          //order
                          InkWell(
                            onTap: () {
                              orderController.orderItemList.clear();
                              orderController.getCartItem();
                              previousOrderController.previousorderItemList
                                  .clear();
                              previousOrderController.getCartItem();
                              currentOrderController.currentOrderItemList
                                  .clear();
                              currentOrderController.getCartItem();
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: const OrderScreen(),
                                withNavBar:
                                    true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: profileWidget(
                              icon: 'assets/images/solar_bag.svg',
                              text: 'طلباتي'.tr,
                              textColor: Colors.black,
                            ),
                          ),
                          const Divider(
                            color: GreyClr,
                          ),
                          //location
                          InkWell(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: ChooseLocationScreen(),
                                //  AddLocationScreen(),
                                withNavBar:
                                    true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                              // Get.toNamed(Routes.AddLocationScreen);
                            },
                            child: profileWidget(
                              icon: 'assets/images/locationlogo.svg',
                              text: 'العناوين'.tr,
                              textColor: Colors.black,
                            ),
                          ),
                          // const Divider(
                          //   color: GreyClr,
                          // ),
                          //
                          // //contact us
                          // InkWell(
                          //   onTap: () {
                          //     if (controller.isAuth()) {
                          //     } else {}
                          //     PersistentNavBarNavigator.pushNewScreen(
                          //       context,
                          //       screen: ConnectUsScreen(),
                          //       //  AddLocationScreen(),
                          //       withNavBar:
                          //           true, // OPTIONAL VALUE. True by default.
                          //       pageTransitionAnimation:
                          //           PageTransitionAnimation.cupertino,
                          //     );
                          //     // Get.toNamed(Routes.ConnectUsScreen);
                          //   },
                          //   child: profileWidget(
                          //     icon: 'assets/images/earphoneslogo.svg',
                          //     text: 'تواصل معنا'.tr,
                          //     textColor: Colors.black,
                          //   ),
                          // ),
                          // const Divider(
                          //   color: GreyClr,
                          // ),

                          //local
                          // InkWell(
                          //   onTap: () {
                          //     Get.bottomSheet(
                          //       ChooseLanguageWidget(),
                          //       backgroundColor: Colors.grey,
                          //       elevation: 10,
                          //     );
                          //   },
                          //   child: profileWidget(
                          //     icon: 'assets/images/logolanguage.svg',
                          //     text: 'العربية'.tr,
                          //     textColor: Colors.black,
                          //   ),
                          // ),
                          const Divider(
                            color: GreyClr,
                          ),
                          //logout
                          InkWell(
                            onTap: () => _baseDialog(context),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete_forever_outlined,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                TextUtils(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFEB001B),
                                    text: "delete".tr)
                              ],
                            ),
                          ),
                          const Divider(
                            color: GreyClr,
                          ),
                          InkWell(
                            onTap: () {
                              controller.doLogout();
                              // lanController.getLanguage('en');
                              // settingController.ChangeLanguage(ene);
                            },
                            child: profileWidget(
                              icon: 'assets/images/logoutlogo.svg',
                              text: 'تسجيل الخروج'.tr,
                              textColor: const Color(0xFFEB001B),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/lottie/Animation - 1700588382977.json',
                        height: 162.h,
                        width: 108.w,
                        fit: BoxFit.contain),
                    const SizedBox(
                      height: 20,
                    ),
                    //contact us
                    // InkWell(
                    //   onTap: () {
                    //     // FeaturedProductServices.getProduct();
                    //     if (controller.isAuth()) {
                    //     } else {}
                    //     Get.toNamed(Routes.connectUsScreen);
                    //   },
                    //   child: profileWidget(
                    //     icon: 'assets/images/earphoneslogo.svg',
                    //     text: 'تواصل معنا'.tr,
                    //     textColor: Colors.black,
                    //   ),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: GreyClr,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          Get.offNamed(Routes.signupScreen);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/logoutlogo.svg',
                              fit: BoxFit.fill,
                              // ignore: deprecated_member_use
                              color: mainColor,
                              height: 22,
                              width: 22,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            TextUtils(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: mainColor,
                                text: 'تسجيل الدخول'.tr),
                          ],
                        ))
                  ],
                ),
        )));
  }

  _baseDialog(context) {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        surfaceTintColor: Colors.transparent,
        title: new Text('delete'.tr),
        content: Text('you_delete_account'.tr),
        actions: <Widget>[
          new TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pop(false); // dismisses only the dialog and returns false
            },
            child: Text('cancel'.tr),
          ),
          TextButton(
            onPressed: () {
              controller.doLogout();
            },
            child: Text('ok'.tr),
          ),
        ],
      ),
    );
  }
}
