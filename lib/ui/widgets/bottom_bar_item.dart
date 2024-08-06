import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';

class BottomBarItem extends StatelessWidget {
  const BottomBarItem({
    Key? key,
    required this.currentIndex,
    required this.itemIndex,
    required this.itemText,
    required this.itemIcon,
    required this.onTap,
  }) : super(key: key);

  final int currentIndex;
  final int itemIndex;
  final String itemText;
  final SvgGenImage itemIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: () {
          onTap();
        },
        splashColor: primaryBrown,
        borderRadius: BorderRadius.circular(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (itemIcon).svg(
              height: !isTablet ? 28 : 35,
              width: !isTablet ? 28 : 35,
              fit: BoxFit.none,
              colorFilter: ColorFilter.mode(
                currentIndex == itemIndex ? primaryBrown : darkSkyColor,
                BlendMode.srcIn,
              ),
            ),
            (itemText).translateText.appCommonText(
                  weight: FontWeight.w400,
                  color: currentIndex == itemIndex ? blackColor : darkSkyColor,
                  size: !isTablet ? 10.sp : 17.sp,
                )
          ],
        ),
      ),
    );
  }
}
