import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget loadingMarker() {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.6),
        highlightColor: Colors.transparent,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            );
          },
        )),
  );
}
