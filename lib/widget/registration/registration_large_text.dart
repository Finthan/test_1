import 'package:flutter/material.dart';

class AppLargeText extends StatelessWidget {
  double size;
  final String text;
  AppLargeText({
    super.key,
    this.size = 34,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
