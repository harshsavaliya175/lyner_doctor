import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';

AppBar appbarWithIcons(
    {required Widget title,
    required Widget leading,
    Widget? rightIcon,
    bool centerTitle = false,
    double leadingWidth = 55,
    double elevation = 0.5,
    Color? backgroundColor}) {
  return AppBar(
    toolbarHeight: isTablet ? 90 : 70,
    centerTitle: centerTitle,
    leading: leading,
    title: title,
    backgroundColor: backgroundColor ?? primaryBrown,
    shadowColor: Colors.grey[300],
    elevation: elevation,
    leadingWidth: leadingWidth,
    titleSpacing: 15,
    scrolledUnderElevation: 0,
    actions: <Widget>[rightIcon ?? Container().paddingOnly(right: 10)],
  );
}
