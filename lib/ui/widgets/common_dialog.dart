import 'package:flutter/material.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';

Future datePickerDialog(BuildContext context, DateTime? initialDate) {
  DateTime currentDate = DateTime.now();
  // DateTime maxDate = currentDate.add(Duration(days: 15));

  return showDatePicker(
    context: context,
    initialDate: initialDate ?? currentDate,
    firstDate: currentDate,
    // Start from the current date
    lastDate: DateTime.utc(3000),

    builder: (context, child) {
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
