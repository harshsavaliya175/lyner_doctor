import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  hideKeyBoard(BuildContext context) {
    return FocusScope.of(context).unfocus();
  }

  Future showAppBottomSheet({required Widget contentWidget}) {
    return showModalBottomSheet(
      context: this,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return contentWidget;
      },
    );
  }
}

extension AddSpace on num {
  Widget H() {
    return SizedBox(height: toDouble());
  }

  Widget W() {
    return SizedBox(width: toDouble());
  }

  Gap space() {
    return Gap(toDouble());
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

extension StringExtension on String {
  String? get appendZeroPrefix {
    return length <= 1 ? "0$this" : this;
  }

  String format({required String outputFormat, required String inputFormat}) {
    DateTime dateTime = DateTime.now();
    dateTime = DateFormat(inputFormat).parse(this);
    return DateFormat(outputFormat).format(dateTime);
  }

  List<double> get toDoubleList {
    return replaceAll('[', '')
        .replaceAll(']', '')
        .split(',')
        .map((e) => e.isEmpty ? 0.1 : double.parse(e))
        .toList();
  }

  String get translateText {
    return this.tr();
  }

  bool isImageFileName() {
    final ext = toLowerCase();
    return ext.endsWith(".jpg") ||
        ext.endsWith(".jpeg") ||
        ext.endsWith(".png") ||
        ext.endsWith(".gif") ||
        ext.endsWith(".bmp") ||
        ext.endsWith(".heic") ||
        ext.endsWith(".heif");
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
      FontStyle fontStyle = FontStyle.normal,
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
        fontStyle: fontStyle,
        decoration: decoration,
      ),
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
      color: color,
      fontFamily: 'maax-medium',
      fontSize: size.toDouble(),
      fontWeight: weight,
      decoration: decoration);
}

TextStyle hintTextStyle({
  Color color = const Color(0XFF9A9A9A),
  num size = 14,
  FontWeight weight = FontWeight.normal,
  TextDecoration? decoration,
}) {
  return TextStyle(
    fontFamily: 'maax',
    color: color,
    fontSize: size.toDouble(),
    fontWeight: weight,
    decoration: decoration,
  );
}

TextStyle textFieldTextStyle({
  Color color = const Color(0XFF0D0D0D),
  num size = 14,
  FontWeight weight = FontWeight.w500,
  TextDecoration? decoration,
}) {
  return TextStyle(
    fontFamily: 'maax-medium',
    color: color,
    fontSize: size.toDouble(),
    fontWeight: weight,
    decoration: decoration,
  );
}

String getFileIcon(int? isYoutube) {
  switch (isYoutube) {
    case 0:
      return Assets.images.imgPdfLibrary.path;
    case 1:
      return Assets.images.imgVideo.path;
    default:
      return Assets.images.imgPdfLibrary.path;
  }
}
