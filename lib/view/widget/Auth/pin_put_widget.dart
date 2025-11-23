// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../logic/controller/auth_controller.dart';
import '../../../utils/them.dart';

// ignore: must_be_immutable
class PinPutWidget extends StatelessWidget {
  PinPutWidget({
    Key? key,
    required this.phone,
  }) : super(key: key);
  TextEditingController verification = TextEditingController();
  SignupController controller = SignupController();
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      // controller: controller.verification,
      length: 5,
      onCompleted: (v) {
        controller.code = v;

        controller.verificationCheck(phone);

        // Get.offAllNamed(Routes.MainScreen);
      },
      focusedPinTheme: PinTheme(
        height: 55,
        width: 55,
        textStyle: const TextStyle(fontSize: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: mainColor,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      defaultPinTheme: PinTheme(
        margin: const EdgeInsets.symmetric(horizontal: 7),
        height: 50,
        width: 55,
        textStyle: const TextStyle(fontSize: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: GreyClr),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
