// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bandora_app/utils/them.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final Function validator;
  final TextInputType textInputType;
  final String hintText;
  final Function(String?) onsave;

  const AuthTextFormField({
    Key? key,
    required this.controller,
    required this.obscureText,
    required this.validator,
    required this.textInputType,
    required this.hintText,
    required this.onsave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.black,
      ),
      controller: controller,
      obscureText: obscureText,
      cursorColor: Colors.black,
      keyboardType: textInputType,
      validator: (value) => validator(value),
      onSaved: onsave,
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.h, vertical: 10.h),
          fillColor: Colors.grey.shade200,
          hintText: hintText,
          hintStyle: const TextStyle(
              color: GreyClr, fontSize: 14, fontWeight: FontWeight.w400),
          filled: false,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: GreyClr),
              borderRadius: BorderRadius.circular(4)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: GreyClr),
              borderRadius: BorderRadius.circular(4)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: GreyClr),
              borderRadius: BorderRadius.circular(4)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: GreyClr),
              borderRadius: BorderRadius.circular(4))),
    );
  }
}
