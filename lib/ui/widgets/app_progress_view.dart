import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';

class AppProgressView extends StatelessWidget {
  final Color? progressColor;
  final Color? backgroundColor;
  final double heightMargin;

  const AppProgressView(
      {Key? key,
      this.progressColor,
      this.backgroundColor,
      this.heightMargin = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Get.height / heightMargin,
      color: backgroundColor ?? Colors.white.withOpacity(0.4),
      child: CircularProgressIndicator(
        color: progressColor ?? primaryBrown,
      ).center,
    );
  }
}
