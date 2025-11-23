import 'package:bandora_app/utils/them.dart';
import 'package:flutter/material.dart';

class CobonTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Function validator;
  final String hintText;
  final TextInputType keyboardType;
  final Widget suffix;

  const CobonTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.hintText,
    required this.keyboardType,
    required this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      style: const TextStyle(
        color: Colors.black,
      ),
      controller: controller,
      cursorColor: Colors.black,
      keyboardType: keyboardType,
      validator: (value) => validator(value),
      decoration: InputDecoration(
          fillColor: Colors.white,
          suffix: suffix,
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
