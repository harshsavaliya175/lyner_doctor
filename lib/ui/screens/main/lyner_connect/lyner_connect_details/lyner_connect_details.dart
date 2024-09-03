import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/home_image.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/model/lyner_connect_details_model.dart';
import 'package:lynerdoctor/ui/screens/main/lyner_connect/lyner_connect_details/lyner_connect_details_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_progress_view.dart';

class LynerConnectDetails extends StatelessWidget {
  LynerConnectDetails({super.key});

  final LynerConnectDetailsController controller =
      Get.put(LynerConnectDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: false,
        title: Text(
          LocaleKeys.details.translateText,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: Assets.fonts.maax,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: !isTablet ? 20 : 22,
          ),
        ).paddingOnly(left: 20),
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
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[300],
        titleSpacing: 1,
        elevation: 0.5,
        scrolledUnderElevation: 0,
      ),
      // appBar: appbarWithIcons(
      //   centerTitle: false,
      //   title: Text(
      //     LocaleKeys.details.translateText,
      //     style: TextStyle(
      //         fontFamily: Assets.fonts.maax,
      //         fontWeight: FontWeight.w700,
      //         color: Colors.black,
      //         fontSize: !isTablet ? 20 : 22),
      //   ),
      //   backgroundColor: Colors.white,
      //   leading: Assets.icons.icBack
      //       .svg(
      //         height: !isTablet ? 25 : 30,
      //         width: !isTablet ? 25 : 30,
      //         fit: !isTablet ? BoxFit.scaleDown : BoxFit.fill,
      //       )
      //       .paddingOnly(
      //           left: 10, top: isTablet ? 22 : 0, bottom: isTablet ? 22 : 0)
      //       .onClick(() {
      //     Get.back();
      //   }),
      // ),
      body: GetBuilder<LynerConnectDetailsController>(
        builder: (LynerConnectDetailsController ctrl) {
          return Stack(
            children: [
              ListView(
                children: [
                  15.space(),
                  Container(
                    height: !isTablet ? 115 : 185,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(!isTablet ? 20 : 30)),
                      border: Border.all(color: skyColor),
                    ),
                    child: Row(
                      children: [
                        HomeImage.networkImage(
                          path: (ApiUrl.patientProfileImage.isNotEmpty ||
                                  ApiUrl.patientProfileImage != "")
                              ? ApiUrl.patientProfileImage +
                                  "${ctrl.lynerConnectDetailsData?.userProfilePhoto}"
                              : "",
                          height: !isTablet ? 70 : 140,
                          width: !isTablet ? 70 : 140,
                          fit: BoxFit.cover,
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
                              '${ctrl.lynerConnectDetailsData?.firstName ?? ''} ${ctrl.lynerConnectDetailsData?.lastName ?? ''}'
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
                              ("${LocaleKeys.treatmentStartDateCom.translateText} ${ctrl.lynerConnectDetailsData?.treatmentStartDate?.ddMMYYYYFormat() ?? ''}")
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
                              LocaleKeys.currentAligner.translateText
                                  .appCommonText(
                                      weight: FontWeight.w400,
                                      size: !isTablet ? 16 : 22,
                                      color: blackColor,
                                      align: TextAlign.start)
                                  .paddingOnly(left: 15),
                              "${ctrl.lynerConnectDetailsData?.currentAlignerStage ?? '0'}/${ctrl.lynerConnectDetailsData?.alignerStage ?? '0'}"
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
                              LocaleKeys.alignerDays.translateText
                                  .appCommonText(
                                      weight: FontWeight.w400,
                                      size: !isTablet ? 16 : 22,
                                      color: blackColor,
                                      align: TextAlign.start)
                                  .paddingOnly(left: 15),
                              "${ctrl.lynerConnectDetailsData?.alignerDay ?? '0'}"
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
                        return LocaleKeys.pleaseEnterDoctor.translateText;
                      }
                      ctrl.update();
                      return null;
                    },
                    readOnly: true,
                    showCursor: false,
                    onTap: () {
                      ctrl.onAlignerStageTap();
                    },
                    textFieldPadding: EdgeInsets.zero,
                    keyboardType: TextInputType.text,
                    hintText: LocaleKeys.selectCurrentStage.translateText,
                    labelText: LocaleKeys.currentStage.translateText,
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
                  Visibility(
                    visible: ctrl.showCurrentStageDropDown,
                    replacement: const SizedBox.shrink(),
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: primaryBrown),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 15),
                        physics: const PageScrollPhysics(),
                        itemBuilder: (BuildContext builder, int index) {
                          Gallery? data = ctrl
                                  .lynerConnectDetailsData?.gallery?[
                              index]; // Display filtered data when search is not empty
                          return InkWell(
                            onTap: () {
                              print("onTap : $index");
                              ctrl.showCurrentStageDropDown =
                                  !ctrl.showCurrentStageDropDown;
                              ctrl.updateGalleryImageData(data!);
                              ctrl.update();
                            },
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child:
                                          "${LocaleKeys.stage.translateText} ${data?.alignerStage} (${data?.stageCompletedDate?.ddMMYYYYFormat()})"
                                              .appCommonText(
                                        color: Colors.black,
                                        maxLine: 1,
                                        align: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        weight: FontWeight.w400,
                                        size: !isTablet ? 15 : 18,
                                      ),
                                    ),
                                    if (ctrl.currentStageController.text.contains(
                                        "${LocaleKeys.stage.translateText} ${data?.alignerStage} (${data?.stageCompletedDate?.ddMMYYYYFormat()})")) ...[
                                      Assets.icons.icSelectArrow.svg(
                                          colorFilter: ColorFilter.mode(
                                        primaryBrown,
                                        BlendMode.srcIn,
                                      )),
                                    ] else ...[
                                      const SizedBox.shrink(),
                                    ]
                                  ],
                                ).paddingOnly(
                                    left: 20, right: 20, bottom: 10, top: 10),
                                Divider(
                                  color: skyColor,
                                  height: 2,
                                  thickness: 1,
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount:
                            ctrl.lynerConnectDetailsData?.gallery?.length,
                      ).paddingOnly(top: 5, bottom: 5),
                    ).paddingOnly(top: 15),
                  ),
                  15.space(),
                  LocaleKeys.gallery.translateText.appCommonText(
                    size: !isTablet ? 20 : 24,
                    align: TextAlign.start,
                    weight: FontWeight.w500,
                  ),
                  5.space(),
                  LocaleKeys.alignersInPlace.translateText.appCommonText(
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
                        urlImage:
                            ctrl.selectedGalleryData?.rightWithLyner ?? '',
                        fileImage: ctrl.alignerLeftImageFile ?? File(''),
                      ),
                      10.space(),
                      photoCardWidget(
                        image: Assets.images.imgCentreAligner.path,
                        urlImage:
                            ctrl.selectedGalleryData?.straightWithLyner ?? '',
                        fileImage: ctrl.alignerCentreImageFile ?? File(''),
                      ),
                      10.space(),
                      photoCardWidget(
                        image: Assets.images.imgRightAligner.path,
                        urlImage: ctrl.selectedGalleryData?.leftWithLyner ?? '',
                        fileImage: ctrl.alignerRightImageFile ?? File(''),
                      ),
                    ],
                  ),
                  10.space(),
                  LocaleKeys.withoutAligners.translateText.appCommonText(
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
                        urlImage: ctrl.selectedGalleryData?.right ?? '',
                        fileImage:
                            ctrl.withoutAlignerRightImageFile ?? File(''),
                      ),
                      10.space(),
                      photoCardWidget(
                        image: Assets.images.imgCentreAligner.path,
                        urlImage: ctrl.selectedGalleryData?.straight ?? '',
                        fileImage:
                            ctrl.withoutAlignerCentreImageFile ?? File(''),
                      ),
                      10.space(),
                      photoCardWidget(
                        image: Assets.images.imgRightAligner.path,
                        urlImage: ctrl.selectedGalleryData?.left ?? '',
                        fileImage: ctrl.withoutAlignerLeftImageFile ?? File(''),
                      ),
                    ],
                  ),
                  50.space(),
                ],
              ).paddingSymmetric(horizontal: 15),
              ctrl.isLoading ? AppProgressView() : Container()
            ],
          );
        },
      ),
    );
  }
}

Widget photoCardWidget({
  required String image,
  required File? fileImage,
  required String urlImage,
}) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        (urlImage.isEmpty || urlImage == "")
            ? ((fileImage != null && fileImage.path != "")
                ? HomeImage.fileImage(
                    path: fileImage.path,
                    size: !isTablet ? 123 : 200,
                    shape: BoxShape.rectangle,
                    fit: BoxFit.cover,
                    radius: BorderRadius.circular(15),
                  )
                : HomeImage.assetImage(
                    path: image,
                    height: !isTablet ? 123 : 200,
                    shape: BoxShape.rectangle,
                    width: !isTablet ? 123 : 200,
                  ))
            : HomeImage.networkImage(
                path: "${ApiUrl.lynerDetailsBaseUrl}/$urlImage",
                height: !isTablet ? 123 : 200,
                shape: BoxShape.rectangle,
                fit: BoxFit.cover,
                radius: BorderRadius.circular(15),
                width: !isTablet ? 123 : 200,
              ),
      ],
    ),
  );
}
