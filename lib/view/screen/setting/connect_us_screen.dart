import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../logic/controller/contact_controller.dart';
import '../../../utils/them.dart';
import '../../widget/profile/connect_us_container.dart';
import 'message_screen.dart';

// ignore: must_be_immutable
class ConnectUsScreen extends StatelessWidget {
  ConnectUsScreen({super.key});

  ContactController controller = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'تواصل معنا'.tr,
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
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: GetBuilder<ContactController>(
          builder: (_) {
            return Container(
              height: MediaQuery.of(context).size.height / 2,
              margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //massege
                  InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: MessageScreen(),
                        //  AddLocationScreen(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    child: ConnectUSContainer(
                        image: 'assets/images/message.png', text: 'رسالة'.tr),
                  ),
                  //call
                  InkWell(
                    onTap: () async {
                      final url = Uri(scheme: 'tel', path: controller.phone);
                      if (await canLaunchUrl(url)) {
                        launchUrl(url);
                      }
                    },
                    child: ConnectUSContainer(
                        image: 'assets/images/phone.png', text: 'مكالمة'.tr),
                  ),
                  //FaceBook
                  InkWell(
                    onTap: () {
                      launchUrl(Uri.parse(controller.facebookLink),
                          mode: LaunchMode.externalApplication);
                    },
                    child: ConnectUSContainer(
                        image: 'assets/images/facebook.png', text: 'Facebook'),
                  ),
                  //WhatsApp
                  InkWell(
                    onTap: () {
                      launchUrl(Uri.parse(controller.watsappLink),
                          mode: LaunchMode.externalApplication);
                    },
                    child: ConnectUSContainer(
                        image: 'assets/images/whatsapp.png', text: 'Whatsaap'),
                  ),
                  //Instgram
                  InkWell(
                    onTap: () {
                      launchUrl(Uri.parse(controller.instgramLink),
                          mode: LaunchMode.externalApplication);
                    },
                    child: ConnectUSContainer(
                        image: 'assets/images/instagram.png',
                        text: 'Instagram'),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
