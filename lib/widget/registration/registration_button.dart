import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget {
  final int indexDots;
  final ValueChanged<int> onPageChanged;
  final String textButton;
  final Color buttonColor;
  final Color textColor;

  const WelcomeButton({
    Key? key,
    required this.indexDots,
    required this.onPageChanged,
    required this.textButton,
    required this.buttonColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 286,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: buttonColor,
      ),
      child: TextButton(
        child: Text(
          textButton,
          style: TextStyle(color: textColor),
        ),
        onPressed: () {
          int newIndex = indexDots + 1;
          onPageChanged(newIndex);
        },
      ),
    );
  }
}
