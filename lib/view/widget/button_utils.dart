import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonUtils extends StatelessWidget {
  final Color colorstext;
  final Color background;
  final String text;
  final Function() onPressed;

  const ButtonUtils(
      {required this.text,
      required this.onPressed,
      super.key,
      required this.colorstext,
      required this.background});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize: const Size(227, 50),
              backgroundColor: background,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (text == 'إضافة إلي السلة'.tr)
                Icon(
                  Icons.add_shopping_cart,
                  color: Colors.black,
                  size: 22,
                ),
              if (text == 'إضافة إلي السلة'.tr)
                const SizedBox(
                  width: 10,
                ),
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colorstext,
                    fontSize: 16,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
