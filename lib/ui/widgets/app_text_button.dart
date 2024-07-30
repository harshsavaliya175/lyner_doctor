import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final VoidCallback onPressed;

  const AppTextButton({
    super.key,
    required this.text,
    this.style,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed();
      },
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
