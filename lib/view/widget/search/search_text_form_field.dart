import 'package:bandora_app/utils/them.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controller/search_controller.dart';

// ignore: must_be_immutable
class SerchFormText extends StatelessWidget {
  SerchFormText({super.key});

  Search controller = Get.put(Search());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Search>(
      builder: (_) {
        return TextField(
          controller: controller.searchTextController,
          onChanged: (searchName) {
            if (searchName == '') {
              return controller.clearSearch();
            }
            controller.getSearchProduct(searchName);
          },
          style: const TextStyle(color: Colors.black),
          cursorColor: Colors.black,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            fillColor: Colors.white,
            focusColor: Colors.red,
            prefixIcon: const Icon(
              Icons.search,
              color: mainColor,
            ),
            suffix: InkWell(
                onTap: () {
                  controller.clearSearch();
                },
                child: Icon(
                  CupertinoIcons.clear_circled_solid,
                  color: Colors.grey.withOpacity(0.7),
                )),
            hintText: "بحث".tr,
            hintStyle: const TextStyle(
              color: Colors.black45,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            filled: true,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: GreyClr),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: GreyClr),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: GreyClr),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: GreyClr),
            ),
          ),
        );
      },
    );
  }
}
