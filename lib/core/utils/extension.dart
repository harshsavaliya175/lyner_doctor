import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_color.dart';

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;
}

extension AddSpace on num {
  Widget H() {
    return SizedBox(height: toDouble());
  }

  Widget W() {
    return SizedBox(width: toDouble());
  }
}


String dateWidget(String down) {
  if ((down) == '1') {
    return '${down}st';
  } else if ((down).toString().endsWith('1') &&
      !(down).toString().startsWith('1')) {
    return '${down}st';
  } else if ((down).toString().endsWith('2') &&
      !(down).toString().startsWith('1')) {
    return '${down}nd';
  } else if ((down).toString().endsWith('3') &&
      !(down).toString().startsWith('1')) {
    return '${down}rd';
  } else {
    return '${down}th';
  }
}

replaceId(String id) {
  String fistId = id.split(',').first;
  String secondId = id.split(',').last;

  if (fistId.contains("-")) {
    return fistId;
  } else if (secondId.contains("-")) {
    return secondId;
  } else {
    return id;
  }
}

void printData({required dynamic tittle, dynamic val}) {
  log("$tittle:-$val");
}

bool isHistory = false;

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension AddText on String {
  Widget appCommonText(
      {Color color = blackColor,
      double size = 20,
      double letterSpacing = 0,
      TextAlign align = TextAlign.center,
      FontWeight weight = FontWeight.w500,
      TextDecoration? decoration,
      Color decorationColor = blackColor,
      // FontStyle fontStyle = FontStyle.normal,
      int? maxLine,
      TextOverflow? overflow}) {
    return Text(
      this,
      style: TextStyle(
          fontSize: size,
          color: color,
          letterSpacing: letterSpacing,
          // color: isDarkMode ? Colors.white : color,
          fontWeight: weight,
          fontFamily: 'maax-medium-medium',
          decorationColor: decorationColor,
          // fontStyle: fontStyle,
          decoration: decoration),
      textAlign: align,
      overflow: overflow,
      maxLines: maxLine,
    );
  }

  Widget lightText(
      {Color color = const Color(0XFF0D0D0D),
      num size = 14,
      FontWeight weight = FontWeight.w300,
      TextDecoration? decoration}) {
    return Text(
      this,
      style: defaultTextStyle(
        color: blackColor,
        size: 18.h,
      ),
      textAlign: TextAlign.start,
    );
  }
}

TextStyle defaultTextStyle(
    {Color color = const Color(0XFF9A9A9A),
    num size = 16,
    FontWeight weight = FontWeight.normal,
    TextDecoration? decoration}) {
  return TextStyle(
      color: color,  fontFamily: 'maax-medium',
      fontSize: size.toDouble(),
      fontWeight: weight,
      decoration: decoration);
}


TextStyle hintTextStyle(
    {Color color = const Color(0XFF9A9A9A),
    num size = 14,
    FontWeight weight = FontWeight.normal,
    TextDecoration? decoration}) {
  return TextStyle(
      fontFamily: 'maax',
      color: color,
      fontSize: size.toDouble(),
      fontWeight: weight,
      decoration: decoration);
}

TextStyle textFieldTextStyle(
    {Color color = const Color(0XFF0D0D0D),
    num size = 14,
    FontWeight weight = FontWeight.w500,
    TextDecoration? decoration}) {
  return TextStyle(
      fontFamily: 'maax-medium',
      color: color,
      fontSize: size.toDouble(),
      fontWeight: weight,
      decoration: decoration);
}
