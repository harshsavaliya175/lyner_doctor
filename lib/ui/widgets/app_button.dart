import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? bgColor;
  final Color? fontColor;
  final double? fontSize;
  final double? btnHeight;
  final double? btnWidth;
  final double? radius;
  final List<BoxShadow>? boxShadow;
  final FontWeight weight;
  AppButton({
    super.key,
    required this.text,
    required this.onTap,
    this.bgColor,
    this.weight = FontWeight.w600,
    this.btnHeight,
    this.btnWidth,
    this.radius,
    this.boxShadow,
    this.fontSize,
    this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: btnHeight ?? 50,
        width: btnWidth ?? double.infinity,
        decoration: BoxDecoration(
          color: bgColor ?? Colors.white,
          boxShadow: boxShadow ??
              [
                BoxShadow(
                  color: bgColor!.withOpacity(0.5), // Color of the shadow
                  spreadRadius: 2, // Spread radius
                  blurRadius: 5, // Blur radius
                  offset: Offset(0, 2), // Offset of the shadow
                ),
              ],
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),
        child: text
            .appCommonText(
              size: fontSize ?? 20,
              color: fontColor ?? primaryBrown,
              weight: weight,
            )
            .center,
      ),
    ).paddingOnly(bottom: 10);
  }
}

class AppBorderButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? borderColor;
  final Color? fontColor;
  final double? btnWidth;
  final double? btnHeight;
  final double? radius;
  final double? borderWidth;
  final double? fontSize;
  final FontWeight? fontWeight;

  AppBorderButton({
    super.key,
    required this.text,
    required this.onTap,
    this.borderColor,
    this.fontColor,
    this.radius,
    this.fontSize,
    this.btnWidth,
    this.borderWidth,
    this.fontWeight,
    this.btnHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: btnHeight ?? 50,
      width: btnWidth ?? double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 10),
        border: Border.all(
            color: borderColor ?? Colors.white, width: borderWidth ?? 2),
      ),
      child: text
          .appCommonText(
            weight: fontWeight ?? FontWeight.w500,
            color: fontColor ?? blackColor,
            size: fontSize ?? 16,
          )
          .center,
    ).paddingOnly(bottom: 10).onTap(onTap);
  }
}
