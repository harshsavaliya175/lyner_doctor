import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/home_image.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';

class AppPatientCard extends StatelessWidget {
  const AppPatientCard({
    Key? key,
    this.isEditCard = true,
    this.treatmentStartDate,
    required this.title1,
    required this.title2,
    required this.title3,
    required this.data1,
    required this.data2,
    required this.data3,
    required this.patientName,
    required this.deleteOnTap,
    required this.editOrSubmitOnTap,
    required this.patientImagePath,
    this.isShowTitle = true,
  }) : super(key: key);

  final bool isEditCard;
  final String? treatmentStartDate;
  final String title1;
  final String title2;
  final String title3;
  final String data1;
  final String data2;
  final String data3;
  final String patientName;
  final String patientImagePath;
  final VoidCallback deleteOnTap;
  final VoidCallback editOrSubmitOnTap;
  final bool isShowTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: skyColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isShowTitle)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    HomeImage.networkImage(
                      path: (patientImagePath != "" ||
                              patientImagePath.isNotEmpty)
                          ? ApiUrl.patientProfileImage + patientImagePath
                          : "",
                      fit: BoxFit.cover,
                      shape: BoxShape.circle,
                      size: !isTablet ? 44.w : 54.w,
                    ).paddingOnly(top: 16, left: 16, right: 12, bottom: 12),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        patientName.appCommonText(
                          weight: FontWeight.w500,
                          size: !isTablet ? 16 : 20,
                          color: Colors.black,
                        ),
                        if (isEditCard)
                          ("${LocaleKeys.treatmentStartDateCom.translateText} $treatmentStartDate")
                              .appCommonText(
                            weight: FontWeight.w400,
                            size: !isTablet ? 12 : 15,
                            color: hintStepColor,
                          ),
                      ],
                    ),
                  ],
                ),
                DottedBorder(
                  borderType: BorderType.RRect,
                  color: skyColor,
                  padding: EdgeInsets.zero,
                  radius: Radius.circular(35),
                  dashPattern: [5, 5, 5, 5],
                  child: Container(),
                ),
              ],
            ),
          16.space(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              patientCardTitleAndData(
                title: title1.translateText,
                data: data1,
              ),
              12.space(),
              patientCardTitleAndData(
                title: title2.translateText,
                data: data2,
              ),
              12.space(),
              patientCardTitleAndData(
                title: title3.translateText,
                data: data3,
              ),
              28.space(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: AppButton(
                      btnHeight: !isTablet ? 50 : 60,
                      text: LocaleKeys.delete.translateText,
                      fontSize: !isTablet ? 16 : 20,
                      fontColor: pinkColor,
                      bgColor: deleteButtonColor,
                      radius: 100,
                      onTap: () {
                        deleteOnTap();
                      },
                    ),
                  ),
                  20.space(),
                  Expanded(
                    child: AppButton(
                      text: isEditCard
                          ? LocaleKeys.edit.translateText
                          : LocaleKeys.submitTheCase.translateText,
                      bgColor: primaryBrown,
                      fontSize: !isTablet ? 16 : 20,
                      btnHeight: !isTablet ? 50 : 60,
                      fontColor: whiteColor,
                      radius: 100,
                      onTap: () {
                        editOrSubmitOnTap();
                      },
                    ),
                  )
                ],
              ),
              10.space(),
            ],
          ).paddingSymmetric(horizontal: 16),
        ],
      ),
    );
  }

  Widget patientCardTitleAndData({
    required String title,
    required String data,
  }) {
    return Row(
      children: [
        title.appCommonText(weight: FontWeight.w400, size: !isTablet ? 16 : 18),
        5.space(),
        data.appCommonText(weight: FontWeight.w500, size: !isTablet ? 16 : 18),
      ],
    );
  }
}
