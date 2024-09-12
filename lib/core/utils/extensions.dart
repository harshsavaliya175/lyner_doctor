import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';

extension DateTimeExtension on DateTime {
  DateTime toLocalDateTime({String format = "yyyy-MM-dd HH:mm:ss"}) {
    var dateTime = DateFormat(format).parse(toString(), true);
    return dateTime.toLocal();
  }
}

extension Validation on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

hideKeyBoard(BuildContext context) {
  return FocusScope.of(context).unfocus();
}

extension extOnDynamic on dynamic {
  get debugPrint {
    if (kDebugMode) {
      print("--->(@) ${this.toString()}");
    }
  }

  get printLine {
    if (kDebugMode) {
      print(
          "--------------------------------------------------------------------------------------------->(*)");
    }
  }
}

extension AddPadding on Widget {
  Widget positioned({
    double? bottom,
    double? top,
    double? left,
    double? right,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: this,
    );
  }

  get center {
    return Center(
      child: this,
    );
  }

  get safeArea {
    return SafeArea(child: this);
  }

  Widget onTap(GestureTapCallback onTap) {
    return InkWell(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      onTap: onTap,
      child: this,
    );
  }

  Widget onClick(GestureTapCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: this,
    );
  }
}

// extension DateTimeOB on DateTime {
//   DateTime getLocalDateTime() {
//     String dateUtc = DateFormat('yyyy-MM-dd HH:mm:ss').format(this);
//     var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateUtc, true);
//     var dateLocal = dateTime.toLocal();
//     return dateLocal;
//   }
// }
extension DateTimeOB on DateTime {
  DateTime getLocalDateTime() {
    String dateUtc = DateFormat('yyyy-MM-dd HH:mm:ss',
            preferences.getString(SharedPreference.LANGUAGE_CODE) ?? 'fr')
        .format(this);
    var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss",
            preferences.getString(SharedPreference.LANGUAGE_CODE) ?? 'fr')
        .parse(dateUtc, true);
    var dateLocal = dateTime.toLocal();
    return dateLocal;
  }

  int getDateForChatListGroup() {
    return DateTime(year, month, day, 0, 0, 0)
        .getLocalDateTime()
        .millisecondsSinceEpoch;
  }

  String timeDifferenceForChatListGroup() {
    DateTime currentDate = DateTime.now();

    var different = currentDate.difference(this.getLocalDateTime());

    if (different.inDays > 365)
      return DateFormat(
        "dd MMMM, yyyy",
        (preferences.getString(SharedPreference.LANGUAGE_CODE) ?? 'fr'),
      ).format(this);

    if (different.inDays >= 1)
      return DateFormat(
        "dd MMMM, EEEE",
        (preferences.getString(SharedPreference.LANGUAGE_CODE) ?? 'fr'),
      ).format(this);

    if (different.inDays == 0) return "Today";

    return DateFormat("dd MMMM, yyyy",
            (preferences.getString(SharedPreference.LANGUAGE_CODE) ?? 'fr'))
        .format(this);
  }

  String formatDate() {
    return DateFormat(
      'EEE, MMM d, yyyy',
      (preferences.getString(SharedPreference.LANGUAGE_CODE) ?? 'fr'),
    ).format(this);
  }

  String timeAgo() {
    return DateFormat(
      "h:mm a",
      (preferences.getString(SharedPreference.LANGUAGE_CODE) ?? 'fr'),
    ).format(this);
  }

  String ddEEEFormat() {
    return DateFormat(
      'dd MMM',
      (preferences.getString(SharedPreference.LANGUAGE_CODE) ?? 'fr'),
    ).format(this);
  }

  String ddMMMyyHhSssA() {
    return DateFormat(
      'dd, MMM yy hh:mm a',
      (preferences.getString(SharedPreference.LANGUAGE_CODE) ?? 'fr'),
    ).format(this);
  }

  String ddMMYYYYFormat() {
    return DateFormat(
      'dd/MM/yyyy',
      (preferences.getString(SharedPreference.LANGUAGE_CODE) ?? 'fr'),
    ).format(this);
  }

  String yyyyMMDDFormat() {
    return DateFormat('yyyy-MM-dd',
            (preferences.getString(SharedPreference.LANGUAGE_CODE) ?? 'fr'))
        .format(this);
  }

  String hhMMaFormat() {
    return DateFormat('hh:mm a',
            (preferences.getString(SharedPreference.LANGUAGE_CODE) ?? 'fr'))
        .format(this);
  }

  String hhMMSSFormat() {
    return DateFormat(
      'HH:mm:ss',
      (preferences.getString(SharedPreference.LANGUAGE_CODE) ?? 'fr'),
    ).format(this);
  }

  String Hm() {
    return DateFormat.Hm().format(this);
  }
}

extension AppStyle on String {
  Text boldText({
    FontWeight? fontWeight,
    double? fontSize,
    double? fontHeight,
    Color? color,
    TextOverflow? overflow,
    TextDecoration? decoration,
    int? maxLines,
    FontStyle? fontStyle,
    TextAlign? textAlign,
  }) {
    return Text(
      this,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        fontStyle: fontStyle,
        height: fontHeight ?? 0,
        color: color ?? Colors.black,
        fontFamily: Assets.fonts.maaxBold,
        fontSize: fontSize ?? 50,
        overflow: overflow,
        decoration: decoration,
        decorationColor: color ?? Colors.black,
        fontWeight: fontWeight,
      ),
    );
  }

  Text normalText({
    FontWeight? fontWeight,
    double? fontSize,
    double? fontHeight,
    Color? color,
    TextOverflow? overflow,
    TextDecoration? decoration,
    int? maxLines,
    FontStyle? fontStyle,
    String? fontFamily,
    TextAlign? textAlign,
  }) {
    return Text(
      this,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontStyle: fontStyle,
        height: fontHeight ?? 0,
        color: color ?? Colors.black,
        fontFamily: fontFamily ?? 'maax',
        fontSize: fontSize ?? 20,
        decoration: decoration,
        decorationColor: color ?? Colors.black,
        fontWeight: fontWeight,
      ),
    );
  }
}

showAppSnackBar(String tittle, [bool button = false]) {
  return Get.showSnackbar(
    GetSnackBar(
        message: tittle,
        backgroundColor: primaryBrown,
        borderRadius: 10,
        margin: const EdgeInsets.all(8),
        duration: const Duration(seconds: 5),
        snackStyle: SnackStyle.FLOATING,
        messageText: tittle.boldText(color: Colors.white, fontSize: 15),
        mainButton: button
            ? TextButton(
                onPressed: () {
                  AppSettings.openAppSettings();
                },
                // child: "Setting".mediumText(
                //     color: app_Orange_FF7448, size: 16, fontWeight: FontWeight.w500),
                child: LocaleKeys.setting.translateText.boldText(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              )
            : null),
  );
}

void printData({required dynamic tittle, dynamic val}) {
  log("$tittle:-$val");
}

Decoration indicatorWidth() {
  return UnderlineTabIndicator(
    borderSide: BorderSide(color: primaryBrown, width: 2),
    insets: const EdgeInsets.only(bottom: 3),
  );
}
