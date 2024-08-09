import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/home_image.dart';
import 'package:lynerdoctor/core/utils/image_picker.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/lyner_connect/lyner_connect_details/lyner_connect_details_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_bar.dart';
import 'package:lynerdoctor/ui/widgets/app_progress_view.dart';

class LynerConnectDetails extends StatelessWidget {
  LynerConnectDetails({super.key});

  var controller = Get.put(LynerConnectDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: appbarWithIcons(
        centerTitle: false,
        title: Text(
          LocaleKeys.details.translateText,
          style: TextStyle(
              fontFamily: Assets.fonts.maax,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: !isTablet ? 20 : 22),
        ),
        backgroundColor: Colors.white,
        leadingWidth: !isTablet ? 40 : 50,
        leading: Assets.icons.icBack
            .svg(
              height: !isTablet ? 25 : 30,
              width: !isTablet ? 25 : 30,
              fit: !isTablet ? BoxFit.scaleDown : BoxFit.fill,
            )
            .paddingOnly(
                left: 10, top: isTablet ? 22 : 0, bottom: isTablet ? 22 : 0)
            .onClick(() {
          Get.back();
        }),
      ),
      body: GetBuilder<LynerConnectDetailsController>(builder: (ctrl) {
        return Stack(
          children: [
            ListView(
              children: [
                15.space(),
                Container(
                  height: !isTablet ? 115 : 185,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(!isTablet ? 20 : 30)),
                    border: Border.all(color: skyColor),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: !isTablet ? 70 : 140,
                        width: !isTablet ? 70 : 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: ctrl.patientImagePath.isEmpty
                            ? HomeImage.assetImage(
                                size: !isTablet ? 70 : 100,
                                path: Assets.images.imgUserPlaceholder.path,
                              )
                            : HomeImage.networkImage(
                                path: ApiUrl.patientProfileImage +
                                    ctrl.patientImagePath,
                                size: !isTablet ? 70 : 100,
                              ),
                      ).paddingOnly(
                          top: 16,
                          left: !isTablet ? 16 : 25,
                          right: !isTablet ? 12 : 25,
                          bottom: 12),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            'Leslie Alexander'
                                .appCommonText(
                                  weight: FontWeight.w500,
                                  align: TextAlign.start,
                                  maxLine: 2,
                                  overflow: TextOverflow.ellipsis,
                                  size: !isTablet ? 20 : 25,
                                  color: Colors.black,
                                )
                                .paddingOnly(right: 5),
                            3.space(),
                            ("${LocaleKeys.treatmentStartDateCom.translateText} 12/07/2024")
                                .appCommonText(
                              weight: FontWeight.w400,
                              align: TextAlign.start,
                              maxLine: 2,
                              overflow: TextOverflow.ellipsis,
                              size: !isTablet ? 14 : 18,
                              color: hintStepColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                15.space(),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: !isTablet ? 90 : 140,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(!isTablet ? 20 : 30)),
                          border: Border.all(color: skyColor),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Current Aligner"
                                .appCommonText(
                                    weight: FontWeight.w400,
                                    size: !isTablet ? 16 : 22,
                                    color: blackColor,
                                    align: TextAlign.start)
                                .paddingOnly(left: 15),
                            "01/10"
                                .appCommonText(
                                    weight: FontWeight.w500,
                                    size: !isTablet ? 20 : 25,
                                    color: primaryBrown,
                                    align: TextAlign.start)
                                .paddingOnly(left: 15),
                          ],
                        ),
                      ),
                    ),
                    15.space(),
                    Expanded(
                      child: Container(
                        height: !isTablet ? 90 : 140,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(!isTablet ? 20 : 30)),
                          border: Border.all(color: skyColor),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Aligner Days"
                                .appCommonText(
                                    weight: FontWeight.w400,
                                    size: !isTablet ? 16 : 22,
                                    color: blackColor,
                                    align: TextAlign.start)
                                .paddingOnly(left: 15),
                            "5"
                                .appCommonText(
                                    weight: FontWeight.w500,
                                    size: !isTablet ? 20 : 25,
                                    color: primaryBrown,
                                    align: TextAlign.start)
                                .paddingOnly(left: 15),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                15.space(),
                AppTextField(
                  textEditingController: ctrl.currentStageController,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value.isEmpty) {
                      ctrl.update();
                      return 'Please enter Doctor';
                    }
                    ctrl.update();
                    return null;
                  },
                  readOnly: true,
                  showCursor: false,
                  onTap: () {
                    // ctrl.showDoctorDropDown = !ctrl.showDoctorDropDown;
                    // ctrl.update();
                  },
                  textFieldPadding: EdgeInsets.zero,
                  keyboardType: TextInputType.text,
                  hintText: "Select current stage",
                  labelText: "Current Stage",
                  labelTextSize: (!isTablet ? 14 : 19),
                  showPrefixWidget: Assets.icons.icDown
                      .svg(
                        colorFilter: ColorFilter.mode(
                          primaryBrown,
                          BlendMode.srcIn,
                        ),
                        height: 10,
                        width: 10,
                      )
                      .paddingOnly(left: 15, right: 15),
                  showPrefixIcon: true,
                ),
                15.space(),
                "Gallery".appCommonText(
                  size: !isTablet ? 20 : 24,
                  align: TextAlign.start,
                  weight: FontWeight.w500,
                ),
                5.space(),
                "Aligners in Place".appCommonText(
                    size: !isTablet ? 14 : 18,
                    align: TextAlign.start,
                    weight: FontWeight.w400,
                    color: blackColor),
                10.space(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    photoCardWidget(
                      image: Assets.images.imgLeftAligner.path,
                      title: "Profile",
                      ctrl: ctrl,
                      fileImage: ctrl.alignerLeftImageFile ?? File(''),
                      onTap: () {
                        imageUploadUtils.openImageChooser(
                            context: Get.context!,
                            onImageChose: (File? file) async {
                              ctrl.alignerLeftImageFile = file!;
                              ctrl.update();
                            });
                      },
                    ),
                    10.space(),
                    photoCardWidget(
                      image: Assets.images.imgCentreAligner.path,
                      title: "Face",
                      ctrl: ctrl,
                      fileImage: ctrl.alignerCentreImageFile ?? File(''),
                      onTap: () {
                        imageUploadUtils.openImageChooser(
                            context: Get.context!,
                            onImageChose: (File? file) async {
                              ctrl.alignerCentreImageFile = file!;
                              ctrl.update();
                            });
                      },
                    ),
                    10.space(),
                    photoCardWidget(
                      image: Assets.images.imgRightAligner.path,
                      title: "Smile",
                      ctrl: ctrl,
                      fileImage: ctrl.alignerRightImageFile ?? File(''),
                      onTap: () {
                        imageUploadUtils.openImageChooser(
                            context: Get.context!,
                            onImageChose: (File? file) async {
                              ctrl.alignerRightImageFile = file!;
                              ctrl.update();
                            });
                      },
                    ),
                  ],
                ),
                10.space(),
                "Without Aligners".appCommonText(
                    size: !isTablet ? 14 : 18,
                    align: TextAlign.start,
                    weight: FontWeight.w400,
                    color: blackColor),
                10.space(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    photoCardWidget(
                      image: Assets.images.imgLeftAligner.path,
                      title: "Profile",
                      ctrl: ctrl,
                      fileImage: ctrl.withoutAlignerRightImageFile ?? File(''),
                      onTap: () {
                        imageUploadUtils.openImageChooser(
                            context: Get.context!,
                            onImageChose: (File? file) async {
                              ctrl.withoutAlignerRightImageFile = file!;
                              ctrl.update();
                            });
                      },
                    ),
                    10.space(),
                    photoCardWidget(
                      image: Assets.images.imgCentreAligner.path,
                      title: "Face",
                      ctrl: ctrl,
                      fileImage: ctrl.withoutAlignerCentreImageFile ?? File(''),
                      onTap: () {
                        imageUploadUtils.openImageChooser(
                            context: Get.context!,
                            onImageChose: (File? file) async {
                              ctrl.withoutAlignerCentreImageFile = file!;
                              ctrl.update();
                            });
                      },
                    ),
                    10.space(),
                    photoCardWidget(
                      image: Assets.images.imgRightAligner.path,
                      title: "Smile",
                      ctrl: ctrl,
                      fileImage: ctrl.withoutAlignerLeftImageFile ?? File(''),
                      onTap: () {
                        imageUploadUtils.openImageChooser(
                            context: Get.context!,
                            onImageChose: (File? file) async {
                              // ctrl.cuisinePhoto?[0] =(file!);
                              ctrl.withoutAlignerLeftImageFile = file!;
                              ctrl.update();
                            });
                      },
                    ),
                  ],
                ),
                50.space(),
              ],
            ).paddingSymmetric(horizontal: 15),
            ctrl.isLoading
                ? AppProgressView(
                    progressColor: Colors.black,
                  )
                : Container()
          ],
        );
      }),
    );
  }
}

Widget photoCardWidget(
    {required String title,
    required String image,
    required File? fileImage,
    required GestureTapCallback onTap,
    required LynerConnectDetailsController ctrl}) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ((fileImage != null && fileImage.path != "")
                ? HomeImage.fileImage(
                    path: fileImage.path,
                    // size: !isTablet ?123:220,
                    height: !isTablet ? 123 : 215,
                    width: !isTablet ? 123 : 240,
                    shape: BoxShape.rectangle,
                    fit: BoxFit.cover,
                    radius: BorderRadius.circular(10),
                  )
                : HomeImage.assetImage(
                    path: image,
                    height: !isTablet ? 123 : 215,
                    width: !isTablet ? 123 : 240,
                    shape: BoxShape.rectangle,
                    fit: BoxFit.cover,
                    radius: BorderRadius.circular(10),
                    // width: 123,
                  ))
            .onClick(onTap),
      ],
    ),
  );
}
