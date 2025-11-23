import 'package:bandora_app/utils/them.dart';
import 'package:bandora_app/view/screen/main/home_screen.dart';
import 'package:bandora_app/view/screen/main_screen.dart';
import 'package:bandora_app/view/widget/button_utils.dart';
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../logic/controller/main_controller.dart';

// ignore: must_be_immutable
class EmptyPage extends StatelessWidget {
  EmptyPage({super.key, required this.image, required this.text});

  final String image;
  final String text;
  PersistentTabController connnntroller = PersistentTabController();
  Maincontroller controller = Get.put(Maincontroller());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //logo
        SvgPicture.asset(
          image,
          // ignore: deprecated_member_use
          color: mainColor,
          height: 48,
          width: 48,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 15,
        ),
        //text
        TextUtils(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: GreyClr,
            text: text),
        const SizedBox(
          height: 15,
        ),
        //button
        ButtonUtils(
            text: 'إبدأ بالتصفح'.tr,
            onPressed: () {
              PersistentNavBarNavigator.pushNewScreenWithRouteSettings(context,
                  screen: MainScreen(),
                  withNavBar: false,
                  settings: MaterialPage(child: HomeScreen()));
            },
            colorstext: Colors.black,
            background: mainColor)
      ],
    );
  }
}
