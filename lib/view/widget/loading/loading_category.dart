import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// ignore: non_constant_identifier_names
Widget LoadingCatogery() {
  return SizedBox(
    width: double.infinity,
    child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.6),
        highlightColor: Colors.transparent,
        child: Wrap(
          spacing: 15,
          verticalDirection: VerticalDirection.down,
          runSpacing: 10,
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
            // Container(
            //   width: 65,
            //   height: 65,
            //   decoration: BoxDecoration(
            //     color: Colors.grey.withOpacity(0.3),
            //     shape: BoxShape.circle,
            //   ),
            // ),
            // Container(
            //   width: 65,
            //   height: 65,
            //   decoration: BoxDecoration(
            //     color: Colors.grey.withOpacity(0.3),
            //     shape: BoxShape.circle,
            //   ),
            // ),
            // Container(
            //   width: 65,
            //   height: 65,
            //   decoration: BoxDecoration(
            //     color: Colors.grey.withOpacity(0.3),
            //     shape: BoxShape.circle,
            //   ),
            // ),
            // Container(
            //   width: 65,
            //   height: 65,
            //   decoration: BoxDecoration(
            //     color: Colors.grey.withOpacity(0.3),
            //     shape: BoxShape.circle,
            //   ),
            // ),
            // Container(
            //   width: 65,
            //   height: 65,
            //   decoration: BoxDecoration(
            //     color: Colors.grey.withOpacity(0.3),
            //     shape: BoxShape.circle,
            //   ),
            // ),
            // const SizedBox(
            //   width: 20,
            // ),
            // Container(
            //   width: 65,
            //   height: 65,
            //   decoration: BoxDecoration(
            //     color: Colors.grey.withOpacity(0.3),
            //     shape: BoxShape.circle,
            //   ),
            // ),
            // // const SizedBox(
            // //   width: 20,
            // // ),
            // Container(
            //   width: 65,
            //   height: 65,
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: Colors.grey.withOpacity(0.3),
            //   ),
            // ),
            // // const SizedBox(
            // //   width: 20,
            // // ),
            // Container(
            //   width: 65,
            //   height: 65,
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: Colors.grey.withOpacity(0.3),
            //   ),
            // )
          ],
        )),
  );
}
