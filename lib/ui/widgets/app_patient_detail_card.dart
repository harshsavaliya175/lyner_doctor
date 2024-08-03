import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';

class AppPatientDetailCard extends StatelessWidget {
  const AppPatientDetailCard({
    Key? key,
    required this.title,
    this.isShowSubTitle = false,
    this.subTitle = '',
    required this.description,
    this.isShowBottomWidget = false,
    this.bottomText = '',
  }) : super(key: key);

  final String title;
  final String subTitle;
  final String description;
  final String bottomText;
  final bool isShowSubTitle;
  final bool isShowBottomWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: skyColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.space(),
          title.normalText(fontWeight: FontWeight.w600).paddingOnly(left: 16),
          6.space(),
          if (isShowSubTitle)
            subTitle
                .normalText(
                  fontWeight: FontWeight.w500,
                  color: hintStepColor,
                  fontSize: 16,
                )
                .paddingOnly(left: 16),
          16.space(),
          description
              .normalText(fontWeight: FontWeight.w500, fontSize: 16)
              .paddingOnly(left: 16),
          16.space(),
          if (isShowBottomWidget)
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  height: 0,
                  color: dividerColor,
                ),
                bottomText
                    .normalText(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontStyle: FontStyle.italic)
                    .paddingOnly(left: 16, right: 16),
              ],
            )
        ],
      ),
    );
  }
}
