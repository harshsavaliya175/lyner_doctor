import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/ui/widgets/custom_radio_button.dart';

class AppRadioButtonWithTitle extends StatelessWidget {
  const AppRadioButtonWithTitle({
    Key? key,
    required this.onTap,
    required this.title,
    required this.radiobuttonValue,
    required this.radiobuttonGroupValue,
    this.height,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final int radiobuttonValue;
  final int radiobuttonGroupValue;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          border: Border.all(color: skyColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title
              .appCommonText(
                size: 16,
                weight: FontWeight.w400,
                color: Colors.black,
              )
              .paddingOnly(left: 15),
          CustomRadioButton(
            value: radiobuttonValue,
            groupValue: radiobuttonGroupValue,
          ).paddingOnly(right: 13)
        ],
      ),
    ).onClick(
      () {
        onTap();
      },
    );
  }
}
