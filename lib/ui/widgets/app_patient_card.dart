import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/circle_tab_indicator.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/home_image.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/model/patient_model.dart';
import 'package:lynerdoctor/model/patient_resposne_model.dart';

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
    this.isShowBottomWidget = true,
    this.isShowDeleteButtonOnBottom = false,
    this.isDraft = 0,
    this.clinicItem = '',
    required this.isUnread,
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
  final bool isShowBottomWidget;
  final bool isShowDeleteButtonOnBottom;
  final int isDraft;
  final String clinicItem;
  final int isUnread;

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
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          patientName.appCommonText(
                            weight: FontWeight.w500,
                            size: !isTablet ? 16 : 20,
                            maxLine: 1,
                            overflow: TextOverflow.ellipsis,
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
                    ),
                    if (isDraft == 1) ...[
                      Align(
                        alignment: Alignment.topRight,
                        child: Assets.icons.icDeleteIcon.svg(
                          height: 23,
                          width: 21,
                        ),
                      ).onClick(
                        () {
                          deleteOnTap();
                        },
                      ).paddingOnly(right: 12, bottom: 25)
                    ],
                    isUnread == 1
                        ? Assets.icons.icDots.svg().paddingOnly(right: 20)
                        : SizedBox()
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
              Row(
                children: [
                  Expanded(
                    child: patientCardTitleAndData(
                      title: title1.translateText,
                      data: data1,
                    ),
                  ),
                  if (isShowDeleteButtonOnBottom)
                    Align(
                      alignment: Alignment.topRight,
                      child: Assets.icons.icDeleteIcon.svg(
                        height: 23,
                        width: 21,
                      ),
                    ).onClick(
                      () {
                        deleteOnTap();
                      },
                    ).paddingOnly(right: 12),
                ],
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
              if (isShowBottomWidget)
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      editOrSubmitOnTap();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryBrown,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: (isEditCard
                                ? LocaleKeys.edit.translateText
                                : isDraft == 1
                                    ? LocaleKeys.check_draft.translateText
                                    : isDraft == 0 &&
                                            clinicItem == reviewModification
                                        ? LocaleKeys
                                            .check_modification.translateText
                                        : LocaleKeys.checkPlan.translateText)
                            .appCommonText(
                          size: !isTablet ? 16 : 20,
                          color: Colors.white,
                        ),
                      ),
                    ).paddingOnly(top: 5),
                  ),
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

class EditPatientCard extends StatelessWidget {
  const EditPatientCard({
    Key? key,
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
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: skyColor),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              HomeImage.networkImage(
                path: (patientImagePath != "" || patientImagePath.isNotEmpty)
                    ? ApiUrl.patientProfileImage + patientImagePath
                    : "",
                fit: BoxFit.cover,
                shape: BoxShape.circle,
                size: !isTablet ? 110.w : 120.w,
              ).paddingOnly(top: 12, left: 10, right: 12, bottom: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    15.space(),
                    patientName
                        .appCommonText(
                          weight: FontWeight.w500,
                          size: !isTablet ? 18 : 22,
                          align: TextAlign.start,
                          maxLine: 2,
                          color: Colors.black,
                        )
                        .paddingOnly(right: 20),
                    ("${LocaleKeys.treatmentStartDateCom.translateText} $treatmentStartDate")
                        .appCommonText(
                          weight: FontWeight.w400,
                          align: TextAlign.start,
                          maxLine: 2,
                          overflow: TextOverflow.ellipsis,
                          size: !isTablet ? 12 : 15,
                          color: hintStepColor,
                        )
                        .paddingOnly(right: 20),
                    10.space(),
                    Divider(
                      color: skyColor,
                      height: 2,
                      thickness: 1,
                    ),
                    10.space(),
                    patientCardTitleAndData(
                      title: title1.translateText,
                      data: data1,
                    ),
                    5.space(),
                    patientCardTitleAndData(
                      title: title2.translateText,
                      data: data2,
                    ),
                    5.space(),
                    patientCardTitleAndData(
                      title: title3.translateText,
                      data: data3,
                    ),
                    15.space(),
                  ],
                ),
              ),
            ],
          ),
          PopupMenuButton<MenuOptions>(
            onSelected: (MenuOptions result) {
              if (result == MenuOptions.edit) {
                editOrSubmitOnTap();
              } else if (result == MenuOptions.delete) {
                deleteOnTap();
              }
            },
            color: Colors.white,
            padding: EdgeInsets.zero,
            icon: HomeImage.assetImage(
              path: Assets.icons.icDotsMenu.path,
              height: 21,
              width: 25,
              color: primaryBrown,
            ),
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<MenuOptions>>[
              PopupMenuItem<MenuOptions>(
                value: MenuOptions.edit,
                child: Text(
                  LocaleKeys.edit.translateText,
                  textAlign: TextAlign.center,
                ).paddingOnly(left: 5),
              ),
              PopupMenuItem<MenuOptions>(
                value: MenuOptions.delete,
                child:
                    Text(LocaleKeys.delete.translateText).paddingOnly(left: 5),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget patientCardTitleAndData({
    required String title,
    required String data,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title.appCommonText(weight: FontWeight.w400, size: !isTablet ? 16 : 18),
        5.space(),
        Expanded(
            child: data.appCommonText(
                weight: FontWeight.w500,
                size: !isTablet ? 16 : 18,
                align: TextAlign.start)),
      ],
    );
  }
}

enum MenuOptions { edit, delete }
