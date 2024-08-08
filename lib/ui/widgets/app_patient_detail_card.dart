import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
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
    this.isShowNote = false,
    this.bottomText = '',
    this.note = '',
  }) : super(key: key);

  final String title;
  final String subTitle;
  final String description;
  final String bottomText;
  final bool isShowSubTitle;
  final bool isShowBottomWidget;
  final bool isShowNote;
  final String note;

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
          title
              .normalText(
                  fontWeight: FontWeight.w600, fontSize: !isTablet ? 20 : 24)
              .paddingSymmetric(horizontal: 16),
          6.space(),
          if (isShowSubTitle)
            subTitle
                .normalText(
                  fontWeight: FontWeight.w500,
                  color: hintStepColor,
                  fontSize: !isTablet ? 16 : 19,
                )
                .paddingSymmetric(horizontal: 16),
          16.space(),
          description
              .normalText(
                fontWeight: FontWeight.w500,
                fontSize: !isTablet ? 16 : 19,
              )
              .paddingSymmetric(horizontal: 16),
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
                      fontSize: !isTablet ? 14 : 17,
                      fontStyle: FontStyle.italic,
                    )
                    .paddingOnly(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: 16,
                    ),
              ],
            ),
          if (isShowNote)
            Column(
              children: [
                note
                    .normalText(
                      fontWeight: FontWeight.w500,
                      color: hintStepColor,
                      fontSize: !isTablet ? 16 : 19,
                    )
                    .paddingOnly(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: 16,
                    ),
              ],
            )
        ],
      ),
    );
  }
}
