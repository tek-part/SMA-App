import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/my_strings.dart';
import '../../../utils/them.dart';
import '../Auth/auth_text_form_field.dart';
import '../text_utils.dart';
import 'cobon_text_from_field.dart';

class CheckOutWidget extends StatelessWidget {
  CheckOutWidget({super.key});

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController messagecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextUtils(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              text: 'هل تود أن نتصل بك علي رقم أخر'.tr),
          const SizedBox(
            height: 10,
          ),
          //another phone number
          SizedBox(
            width: double.infinity,
            height: 48,
            // color: Colors.green,
            child: Row(children: [
              //الكود
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: GreyClr,
                      ),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4)),
                    ),
                  ),
                  child: const Center(
                      child: TextUtils(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          text: '+964')),
                ),
              ),
              //number
              Expanded(
                flex: 5,
                child: AuthTextFormField(
                    onsave: (v) {
                      namecontroller.text = v!;
                    },
                    textInputType: TextInputType.phone,
                    controller: namecontroller,
                    obscureText: false,
                    validator: (value) {
                      if (value.length <= 5) {
                        return 'this is Wrong phone';
                      } else {
                        return null;
                      }
                    },
                    hintText: 'رقم الهاتف'.tr),
              )
            ]),
          ),

          const SizedBox(
            height: 10,
          ),
          TextUtils(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              text: 'هل لديك كوبون خصم'.tr),
          const SizedBox(
            height: 10,
          ),
          //cobon
          SizedBox(
            height: 48,
            child: Expanded(
              child: CobonTextFormField(
                  suffix: TextButton(
                    onPressed: () {},
                    child: const TextUtils(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: mainColor,
                        text: 'تحقق'),
                  ),
                  controller: messagecontroller,
                  validator: (value) {
                    if (value.toString().length <= 2 ||
                        !RegExp(validationName).hasMatch(value)) {
                      return 'Enter Valid Name';
                    } else {
                      return null;
                    }
                  },
                  hintText: 'مثال: PI6EV7JTDW',
                  keyboardType: TextInputType.name),
            ),
          ),
        ],
      ),
    );
  }
}
