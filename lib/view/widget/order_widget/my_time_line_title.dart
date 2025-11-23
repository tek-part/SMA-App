import 'package:bandora_app/utils/them.dart';
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimeLineTitle extends StatelessWidget {
  const MyTimeLineTitle({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.isPast,
    required this.text,
    required this.isText,
  });

  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final bool isText;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4.4,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        alignment: TimelineAlign.center,
        axis: TimelineAxis.horizontal,
        afterLineStyle: LineStyle(
          color: isPast ? mainColor : Colors.grey.withOpacity(0.9),
        ),
        beforeLineStyle: LineStyle(
          color: isPast ? mainColor : Colors.grey.withOpacity(0.9),
        ),
        hasIndicator: true,
        indicatorStyle: IndicatorStyle(
            indicator: Container(
          width: 13,
          height: 13,
          decoration: ShapeDecoration(
            color: isPast ? mainColor : Colors.grey.withOpacity(0.9),
            shape: const OvalBorder(
              side: BorderSide(width: 1, color: Colors.white),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 3,
                offset: Offset(0, 2),
                spreadRadius: 0,
              )
            ],
          ),
        )),
        endChild: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: isText
              ? TextUtils(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: GreyClr,
                  text: text)
              : const Text(''),
        ),
      ),
    );
  }
}
