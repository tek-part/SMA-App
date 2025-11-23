import 'package:bandora_app/view/screen/main/cart_screen.dart';
import 'package:bandora_app/view/screen/main/fav_screen.dart';
import 'package:bandora_app/view/screen/main/home_screen.dart';
import 'package:bandora_app/view/screen/main/profile_screen.dart';
import 'package:bandora_app/view/screen/main/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../logic/controller/cart_item_controller.dart';
import '../../logic/controller/main_controller.dart';
import '../../utils/them.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  CartItemController cartItemController = Get.put(CartItemController());

  // final controller = Get.find<Maincontroller>();
  Maincontroller conntroller = Get.put(Maincontroller());
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: buildScreens(),
      items: navBarsItems(),
      // confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      // hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      // popAllScreensOnTapOfSelectedTab: true,
      // popActionScreens: PopActionScreensType.all,
      // itemAnimationProperties: const ItemAnimationProperties(
      //   duration: Duration(milliseconds: 200),
      //   curve: Curves.ease,
      // ),
      // screenTransitionAnimation: const ScreenTransitionAnimation(
      //   animateTabTransition: true,
      //   curve: Curves.ease,
      //   duration: Duration(milliseconds: 200),
      // ),
      navBarStyle: NavBarStyle.style1,
    );
  }

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        iconSize: 25,
        textStyle: const TextStyle(fontSize: 10),
        icon: const Icon(Icons.home_filled),
        title: "الرئيسية".tr,
        activeColorPrimary: mainColor,
        activeColorSecondary: Colors.black,
        inactiveColorPrimary: GreyClr,
      ),
      PersistentBottomNavBarItem(
        iconSize: 25,
        textStyle: const TextStyle(fontSize: 10),
        icon: const Icon(CupertinoIcons.search),
        title: ' بحث'.tr,
        activeColorPrimary: mainColor,
        activeColorSecondary: Colors.black,
        inactiveColorPrimary: GreyClr,
      ),
      PersistentBottomNavBarItem(
        iconSize: 25,
        textStyle: const TextStyle(fontSize: 10),
        icon: GetBuilder<CartItemController>(
          builder: (_) {
            return Badge(
              isLabelVisible:
                  cartItemController.cartItemList.isEmpty ? false : true,
              child: const Icon(Icons.shopping_cart_outlined),
            );
          },
        ),
        title: 'عربة التسوق'.tr,
        activeColorPrimary: mainColor,
        activeColorSecondary: Colors.black,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        iconSize: 25,
        textStyle: const TextStyle(fontSize: 10),
        icon: const Icon(CupertinoIcons.heart),
        title: 'المفضلة'.tr,
        activeColorPrimary: mainColor,
        activeColorSecondary: Colors.black,
        inactiveColorPrimary: GreyClr,
      ),
      PersistentBottomNavBarItem(
        iconSize: 25,
        textStyle: const TextStyle(fontSize: 10),
        icon: const Icon(CupertinoIcons.person),
        title: 'حساب تعريفي'.tr,
        activeColorPrimary: mainColor,
        activeColorSecondary: Colors.black,
        inactiveColorPrimary: GreyClr,
      ),
    ];
  }

  List<Widget> buildScreens() {
    return [
      const HomeScreen(),
      SearchScreen(),
      CartScreen(),
      FavScreen(),
      ProfileScreen()
    ];
  }
}
