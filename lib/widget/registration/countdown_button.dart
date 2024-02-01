import 'package:flutter/material.dart';
import 'dart:async';

import '../../all_colors.dart';

class CountdownButton extends StatefulWidget {
  const CountdownButton({super.key});

  @override
  State<CountdownButton> createState() => _CountdownButtonState();
}

class _CountdownButtonState extends State<CountdownButton> {
  int countdown = 60;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        countdown--;
        if (countdown == 0) {
          timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (countdown == 0)
          ? () => {
                setState(() {
                  countdown = 60;
                }),
                startCountdown(),
              }
          : null,
      child: Text(
        (countdown == 0)
            ? 'Отправить код еще раз'
            : '$countdown сек до повтора отправки кода',
        style: TextStyle(color: (countdown == 0) ? kActiveColor : kTextColor),
      ),
    );
  }
}
