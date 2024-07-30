import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';

class AppAuthDivider extends StatelessWidget {
  const AppAuthDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 81.w,
        height: 6.w,
        decoration: BoxDecoration(
            color: skyColor, borderRadius: BorderRadius.circular(100)),
      ),
    );
  }
}
