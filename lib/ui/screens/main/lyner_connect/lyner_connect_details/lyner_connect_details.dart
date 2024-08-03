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
              fontSize: 20),
        ),
        backgroundColor: Colors.white,
        leadingWidth: 40,
        leading: Assets.icons.icBack
            .svg(
              height: 25,
              width: 25,
              fit: BoxFit.scaleDown,
            )
            .paddingOnly(
              left: 10,
            )
            .onClick(() {
          Get.back();
        }),
      ),
      body: GetBuilder<LynerConnectDetailsController>(builder: (ctrl) {
        return ListView(
          children: [
            15.space(),
            Container(
              height: 115,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: skyColor),
              ),
              child: Row(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: ctrl.patientImagePath.isEmpty
                        ? HomeImage.assetImage(
                            size: 70,
                            path: Assets.images.imgUserPlaceholder.path,
                          )
                        : HomeImage.networkImage(
                            path: ApiUrl.patientProfileImage +
                                ctrl.patientImagePath,
                            size: 70,
                          ),
                  ).paddingOnly(top: 16, left: 16, right: 12, bottom: 12),
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
                              size: 20,
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
                          size: 14,
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
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: skyColor),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Current Aligner"
                            .appCommonText(
                                weight: FontWeight.w400,
                                size: 16,
                                color: blackColor,
                                align: TextAlign.start)
                            .paddingOnly(left: 15),
                        "01/10"
                            .appCommonText(
                                weight: FontWeight.w500,
                                size: 20,
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
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: skyColor),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Aligner Days"
                            .appCommonText(
                                weight: FontWeight.w400,
                                size: 16,
                                color: blackColor,
                                align: TextAlign.start)
                            .paddingOnly(left: 15),
                        "5"
                            .appCommonText(
                                weight: FontWeight.w500,
                                size: 20,
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
              // isError: ctrl.emailError,
              hintText: "Select current stage",
              labelText: "Current Stage",
              showPrefixWidget: Assets.icons.icDown
                  .svg(
                    color: primaryBrown,
                    height: 10,
                    width: 10,
                  )
                  .paddingOnly(left: 15, right: 15),
              showPrefixIcon: true,
            ),
            15.space(),
            "Gallery".appCommonText(
              size: 20,
              align: TextAlign.start,
              weight: FontWeight.w500,
            ),
            5.space(),
            "Aligners in Place".appCommonText(
                size: 14,
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
                size: 14,
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
        ).paddingSymmetric(horizontal: 15);
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
                    size: 123,
                    shape: BoxShape.rectangle,
                    fit: BoxFit.cover,
                    radius: BorderRadius.circular(10),
                  )
                : HomeImage.assetImage(
                    path: image,
                    height: 123,
                    shape: BoxShape.rectangle,
                    fit: BoxFit.cover,
                    radius: BorderRadius.circular(10),
                    width: 123,
                  ))
            .onClick(onTap),
      ],
    ),
  );
}
