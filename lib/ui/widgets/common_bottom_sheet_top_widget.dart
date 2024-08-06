import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';

class CommonBottomSheetTopWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CommonBottomSheetTopWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.space(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            Center(
              child: Text(
                title,
                style: hintTextStyle(
                  size: !isTablet ?20:22,
                  weight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            Spacer(),
            Ink(
              decoration: BoxDecoration(
                color: lightGrayColor.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(40),
                onTap: () {
                  onTap();
                },
                child: Container(
                  height: !isTablet ?40:45,
                  width: !isTablet ?40:45,
                  decoration: BoxDecoration(
                    color: lightGrayColor.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Assets.icons.icCancel.svg(
                    colorFilter: ColorFilter.mode(
                      Colors.red,
                      BlendMode.srcIn,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 20),
        12.space(),
        const Divider(color: skyColor, thickness: 1, height: 0),
      ],
    );
  }
}
