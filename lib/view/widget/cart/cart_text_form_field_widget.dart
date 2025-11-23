import 'package:flutter/material.dart';

import '../../../utils/them.dart';

class CartTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Function validator;
  final String hintText;
  final TextInputType keyboardType;
  final Function(String?) onsave;

  const CartTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.hintText,
    required this.keyboardType,
    required this.onsave,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.black,
      ),
      controller: controller,
      cursorColor: mainColor,
      keyboardType: keyboardType,
      validator: (value) => validator(value),
      onSaved: onsave,
      decoration: InputDecoration(
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Colors.black45, fontSize: 16, fontWeight: FontWeight.w500),
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(4)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: mainColor),
              borderRadius: BorderRadius.circular(4)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(4)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(4))),
    );
  }
}
