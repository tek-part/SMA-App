import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/them.dart';

Widget loadingFeatured() {
  return SizedBox(
      width: double.infinity,
      height: 150,
      child: Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.3),
          highlightColor: Colors.transparent,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (context, index) {
              return uniqueProduct(
                width: MediaQuery.of(context).size.width / 3.5,
              );
            },
          )));
}

Widget uniqueProduct({
  required double width,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    padding: const EdgeInsets.symmetric(horizontal: 8),
    width: width,
    decoration: ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 0.50, color: GreyClr),
        borderRadius: BorderRadius.circular(4),
      ),
      shadows: const [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 4,
          offset: Offset(0.50, 2),
          spreadRadius: 0,
        )
      ],
    ),
  );
}
