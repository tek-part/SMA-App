import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget loadingSlider() {
  return SizedBox(
      width: double.infinity,
      height: 210,
      child: Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.5),
          highlightColor: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4)),
          )));
}
