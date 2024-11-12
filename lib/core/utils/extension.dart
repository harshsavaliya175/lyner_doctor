import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

extension MediaQueryValues on BuildContext {
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
  Gap space({double? crossAxisExtent}) {
    return Gap(toDouble(), crossAxisExtent: crossAxisExtent);
  }
}

void printData({required dynamic tittle, dynamic val}) {
  log("$tittle:-$val");
}

extension StringExtension on String {
  String get translateText {
    return this.tr();
  }

  String translateTextWithArgument(String args1) {
    return this.tr(
      args: [args1],
    );
  }

  void launchUrlFun() async {
    await launchUrl(Uri.parse(this));
    // if (await canLaunchUrl(Uri.parse(url))) {
    //   await launchUrl(Uri.parse(url));
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}

extension ExtOnDynamic on dynamic {
  get debugPrint {
    if (kDebugMode) {
      print("--->(@) ${this.toString()}");
    }
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
