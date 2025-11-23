import 'package:flutter/material.dart';

class MessageTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Function validator;
  final String hintText;

  const MessageTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextFormField(
        maxLines: 20,
        minLines: 10,
        style: const TextStyle(
          color: Colors.black,
        ),
        controller: controller,
        cursorColor: Colors.black,
        keyboardType: TextInputType.text,
        validator: (value) => validator(value),
        decoration: InputDecoration(
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: const TextStyle(
                color: Colors.black45,
                fontSize: 16,
                fontWeight: FontWeight.w500),
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(4)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(4)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(4)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(4))),
      ),
    );
  }
}
