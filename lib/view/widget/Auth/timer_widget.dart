import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerWIdget extends StatefulWidget {
  const TimerWIdget({super.key});

  @override
  State<TimerWIdget> createState() => _TimerWIdgetState();
}

class _TimerWIdgetState extends State<TimerWIdget> {
  late int timerLeft = 59;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountDown();
  }

  void _startCountDown() {
    timerLeft = 59;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted && timerLeft >= 1) {
        setState(() {
          timerLeft = timerLeft - 1;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 95,
      height: 42,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(children: [
              const TextSpan(text: '00:'),
              TextSpan(text: timerLeft.toString()),
            ]),
          ),
        ],
      ),
    );
  }
}
