import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  double size;
  final String text;
  AppText({
    super.key,
    this.size = 15,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
