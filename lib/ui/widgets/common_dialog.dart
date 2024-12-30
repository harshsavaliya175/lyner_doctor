import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/utils/extension.dart';

import 'app_button.dart';

Future datePickerDialog({
  required BuildContext context,
  bool isDateOfBirth = false,
  bool isStartFirstDayIsCurrentDay = false,
  DateTime? currentTime,
}) {
  DateTime currentDate = currentTime ?? DateTime.now();
  DateTime minDate = isStartFirstDayIsCurrentDay
      ? DateTime.now()
      : DateTime(currentDate.year - 200, currentDate.month, currentDate.day);
  // DateTime maxDate = currentDate.add(Duration(days: 15));

  return showDatePicker(
    context: context,
    initialDate: currentDate,
    firstDate: minDate,
    // Start from 100 years ago
    lastDate: isDateOfBirth ? DateTime.now() : DateTime(3000),
    // Up to the current date

    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            // change the border color
            primary: primaryBrown,
            // change the text color
            onSurface: Colors.black,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.black),
          ),
        ),
        child: child!,
      );
    },
  );
}

Future bondingDatePickerDialog({
  required BuildContext context,
  DateTime? currentTime,
}) {
  DateTime currentDate = currentTime ?? DateTime.now();
  DateTime minDate = DateTime.now().add(Duration(days: 10));
  // DateTime maxDate = currentDate.add(Duration(days: 15));

  return showDatePicker(
    context: context,
    initialDate: currentDate,
    firstDate: minDate,
    // Start from 100 years ago
    lastDate: DateTime(3000),
    // Up to the current date

    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            // change the border color
            primary: primaryBrown,
            // change the text color
            onSurface: Colors.black,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.black),
          ),
        ),
        child: child!,
      );
    },
  );
}

class CommonDialog extends StatelessWidget {
  CommonDialog(
      {Key? key,
      required this.alignment,
      this.bottomMargin,
      this.tittleText,
      this.tittleColor,
      this.onTap,
      this.cancelOnTap,
      this.buttonCancelText,
      this.buttonText,
      this.descriptionText,
      this.dialogBackColor,
      this.topMargin,
      this.rowMargin,
      this.mainContent})
      : super(key: key);

  final AlignmentGeometry alignment;
  final double? bottomMargin;
  final Widget? mainContent;
  final double? topMargin;
  final double? rowMargin;
  final Color? dialogBackColor;
  final String? tittleText;
  final String? descriptionText;
  final String? buttonCancelText;
  final String? buttonText;
  final Color? tittleColor;
  Function? onTap;
  Function? cancelOnTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: alignment,
        child: IntrinsicHeight(
          child: Container(
              margin: EdgeInsets.only(
                  left: 25,
                  right: 25,
                  bottom: bottomMargin ?? 40,
                  top: topMargin ?? 0),
              width: Get.width,
              decoration: BoxDecoration(
                  color: dialogBackColor ?? Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  5.space(),
                  (tittleText ?? "").appCommonText(
                      size: 18,
                      weight: FontWeight.bold,
                      color: tittleColor ?? blackColor),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: (descriptionText ?? "").appCommonText(
                        weight: FontWeight.w400,
                        size: 16,
                        align: TextAlign.center,
                        color: blackColor),
                  ),
                  15.space(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: AppBorderButton(
                        borderColor: primaryBrown,
                        borderWidth: 1,
                        fontColor: primaryBrown,
                        text: buttonCancelText ?? "",
                        onTap: () {
                          cancelOnTap!();
                        },
                      )),
                      20.space(),
                      Expanded(
                        child: AppButton(
                          text: buttonText ?? "",
                          onTap: () {
                            onTap!();
                          },
                          boxShadow: [],
                          fontSize: 18,
                          bgColor: primaryBrown,
                          fontColor: Colors.white,
                        ),
                      ),
                    ],
                  ).paddingOnly(bottom: 10, right: 16, left: 16),
                  10.space()
                ],
              ).paddingOnly(top: rowMargin ?? 10)),
        ),
      ),
    );
  }
}
