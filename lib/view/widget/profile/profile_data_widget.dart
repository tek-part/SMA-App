import 'package:bandora_app/view/widget/profile/profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controller/profile_data_controller.dart';
import '../../../utils/them.dart';
import '../text_utils.dart';

// ignore: must_be_immutable
class ProfileDataWidget extends StatelessWidget {
  ProfileDataWidget({super.key});

  ProfileDataController controller = Get.put(ProfileDataController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Column(
          children: [
            profilePhoto(char: 'u'),
            const TextUtils(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                text: 'User Name'),
            const TextUtils(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: GreyClr,
                text: '+964**********'),
          ],
        );
      } else {
        return Column(
          children: [
            profilePhoto(
                char: controller.productCategoryList[0].firstName
                    .substring(0, 1)),
            TextUtils(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                text:
                    '${controller.productCategoryList[0].firstName} ${controller.productCategoryList[0].lastName}'),
            TextUtils(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: GreyClr,
                text: '+${controller.productCategoryList[0].phone}'),
          ],
        );
      }
    });
  }
}
