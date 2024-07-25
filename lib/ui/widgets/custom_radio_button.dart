import 'package:flutter/material.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';

class CustomRadioButton extends StatelessWidget {
  final int value;
  final int groupValue;


  CustomRadioButton({
    required this.value,
    required this.groupValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        border: Border.all(color: primaryBrown, width: 1),
        shape: BoxShape.circle,
      ),
      child: Container(
        alignment: Alignment.center,
        width: 14.0,
        height: 14.0,
        decoration: BoxDecoration(
          color: groupValue == value ? primaryBrown : Colors.transparent,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
