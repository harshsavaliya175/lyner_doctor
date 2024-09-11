import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/home_image.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/patients_details/patients_details_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';
import 'package:lynerdoctor/ui/widgets/app_download_button.dart';
import 'package:lynerdoctor/ui/widgets/app_download_text_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GetBuilder<PatientsDetailsController>(
        builder: (PatientsDetailsController controller) {
          return ListView(
            padding: EdgeInsets.only(top: 10, bottom: 50),
            children: [
              if (controller.patientDetailsModel?.isDelivered == 0)
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: isTablet ? 60 : 40,
                    width: isTablet ? 140 : 110,
                    alignment: Alignment.center,
                    child: (controller.patientDetailsModel?.isDeleted == 0
                            ? LocaleKeys.archive.translateText
                            : LocaleKeys.unArchive.translateText)
                        .normalText(
                      fontWeight: FontWeight.w600,
                      color: primaryBrown,
                      fontSize: !isTablet ? 16 : 19,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(color: primaryBrown, width: 1),
                    ),
                  ).onClick(
                    () {
                      controller.deletePatient(
                        controller.patientDetailsModel?.patientId.toString() ??
                            '',
                        controller.patientDetailsModel?.isDeleted,
                      );
                    },
                  ),
                ),
              LocaleKeys.information.translateText.normalText(
                fontWeight: FontWeight.w600,
                fontSize: !isTablet ? 20 : 24,
              ),
              12.space(),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: skyColor),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              LocaleKeys.firstName.translateText.normalText(
                                fontWeight: FontWeight.w500,
                                color: hintStepColor,
                                fontSize: !isTablet ? 16 : 19,
                              ),
                              6.space(),
                              (controller.patientDetailsModel?.firstName ?? "-")
                                  .normalText(
                                fontWeight: FontWeight.w500,
                                color: blackColor,
                                fontSize: !isTablet ? 16 : 19,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              LocaleKeys.lastName.translateText.normalText(
                                fontWeight: FontWeight.w500,
                                color: hintStepColor,
                                fontSize: !isTablet ? 16 : 19,
                              ),
                              6.space(),
                              (controller.patientDetailsModel?.lastName ?? "-")
                                  .normalText(
                                fontWeight: FontWeight.w500,
                                color: blackColor,
                                fontSize: !isTablet ? 16 : 19,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    isTablet ? 20.space() : 12.space(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              LocaleKeys.doctor.translateText.normalText(
                                fontWeight: FontWeight.w500,
                                color: hintStepColor,
                                fontSize: !isTablet ? 16 : 19,
                              ),
                              6.space(),
                              controller.patientDetailsModel?.doctor != null
                                  ? "Dr. ${controller.patientDetailsModel!.doctor!.firstName} ${controller.patientDetailsModel!.doctor!.lastName}"
                                      .normalText(
                                      fontWeight: FontWeight.w500,
                                      color: blackColor,
                                      fontSize: !isTablet ? 16 : 19,
                                    )
                                  : "-".normalText(
                                      fontWeight: FontWeight.w500,
                                      color: blackColor,
                                      fontSize: !isTablet ? 16 : 19,
                                    ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              LocaleKeys.dateOfBirth.translateText.normalText(
                                fontWeight: FontWeight.w500,
                                color: hintStepColor,
                                fontSize: !isTablet ? 16 : 19,
                              ),
                              6.space(),
                              (controller.patientDetailsModel?.dateOfBirth
                                          ?.isBlank ??
                                      true)
                                  ? "-".normalText(
                                      fontWeight: FontWeight.w500,
                                      color: blackColor,
                                      fontSize: !isTablet ? 16 : 19,
                                    )
                                  : "${controller.patientDetailsModel!.dateOfBirth!.ddMMYYYYFormat()}"
                                      .normalText(
                                      fontWeight: FontWeight.w500,
                                      color: blackColor,
                                      fontSize: !isTablet ? 16 : 19,
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              isTablet ? 20.space() : 12.space(),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: skyColor),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LocaleKeys.clinic.translateText.normalText(
                      fontWeight: FontWeight.w500,
                      color: hintStepColor,
                      fontSize: !isTablet ? 16 : 19,
                    ),
                    6.space(),
                    "${controller.patientDetailsModel?.clinicLoc?.address ?? "-"}"
                        .normalText(
                      fontWeight: FontWeight.w500,
                      color: blackColor,
                      fontSize: !isTablet ? 16 : 19,
                    ),
                  ],
                ),
              ),
              isTablet ? 20.space() : 12.space(),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: skyColor),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LocaleKeys.billing.translateText.normalText(
                      fontWeight: FontWeight.w500,
                      color: hintStepColor,
                      fontSize: !isTablet ? 16 : 19,
                    ),
                    6.space(),
                    "${controller.patientDetailsModel?.clinicBill?.billingName ?? "-"}"
                        .normalText(
                      fontWeight: FontWeight.w500,
                      color: blackColor,
                      fontSize: !isTablet ? 16 : 19,
                    ),
                  ],
                ),
              ),
              isTablet ? 20.space() : 12.space(),
              LocaleKeys.plan.translateText.normalText(
                fontWeight: FontWeight.w600,
                fontSize: !isTablet ? 20 : 24,
              ),
              12.space(),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                    border: Border.all(color: skyColor),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: Get.width,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: lightBrown,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(13),
                            topLeft: Radius.circular(13),
                          ),
                        ),
                        child:
                            "${controller.patientDetailsModel?.toothCase?.caseName ?? "-"}"
                                .normalText(
                                  fontWeight: FontWeight.w600,
                                  fontSize: !isTablet ? 20 : 24,
                                )
                                .paddingAll(
                                  !isTablet ? 15 : 20,
                                ),
                      ),
                      isTablet ? 20.space() : 12.space(),
                      "${controller.patientDetailsModel?.toothCase?.caseSteps ?? "-"}"
                          .appCommonText(
                            weight: FontWeight.w500,
                            align: TextAlign.start,
                            size: !isTablet ? 16 : 19,
                          )
                          .paddingSymmetric(horizontal: 15),
                      isTablet ? 20.space() : 12.space(),
                      "${controller.patientDetailsModel?.toothCase?.caseDesc ?? "-"}"
                          .appCommonText(
                            weight: FontWeight.w300,
                            size: !isTablet ? 16 : 19,
                            color: hintColor,
                            maxLine: 2,
                            overflow: TextOverflow.ellipsis,
                            align: TextAlign.start,
                          )
                          .paddingSymmetric(horizontal: 15),
                      isTablet ? 20.space() : 12.space(),
                      "${controller.patientDetailsModel?.toothCase?.casePrice ?? "-"}"
                          .appCommonText(
                            weight: FontWeight.w500,
                            size: !isTablet ? 16 : 19,
                          )
                          .paddingSymmetric(horizontal: 15),
                      isTablet ? 20.space() : 12.space(),
                    ],
                  ),
                ),
              ),
              if (controller
                      .patientDetailsModel?.patient3DModalLink?.isNotEmpty ??
                  false)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.space(),
                    LocaleKeys.link.translateText.normalText(
                      fontWeight: FontWeight.w600,
                      fontSize: !isTablet ? 20 : 24,
                    ),
                    12.space(),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        border: Border.all(color: skyColor),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    LocaleKeys.inTreatmentPlanning.translateText
                                        .appCommonText(
                                      weight: FontWeight.w500,
                                      align: TextAlign.start,
                                      size: !isTablet ? 16 : 19,
                                    ),
                                    20.space(),
                                    AppButton(
                                      btnHeight: !isTablet ? 45 : 55,
                                      btnWidth: !isTablet ? 125 : 150,
                                      bgColor: primaryBrown,
                                      fontColor: whiteColor,
                                      radius: 100,
                                      fontSize: !isTablet ? 16 : 19,
                                      weight: FontWeight.w600,
                                      text: LocaleKeys.approved.translateText,
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                              ),
                              Assets.icons.icTeethWithScreen.svg(
                                height: !isTablet ? 50 : 70,
                                width: !isTablet ? 50 : 70,
                              ),
                            ],
                          ).paddingAll(20),
                          Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: lightBrown,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(13),
                                bottomLeft: Radius.circular(13),
                              ),
                            ),
                            child: (controller.patientDetailsModel
                                        ?.technicianStartDate ==
                                    null)
                                ? "-"
                                    .appCommonText(
                                      weight: FontWeight.w600,
                                      size: !isTablet ? 16 : 19,
                                      color: primaryBrown,
                                    )
                                    .paddingAll(12)
                                : "${controller.patientDetailsModel!.technicianStartDate!.yyyyMMDDFormat()}"
                                    .appCommonText(
                                      weight: FontWeight.w600,
                                      size: !isTablet ? 16 : 19,
                                      color: primaryBrown,
                                    )
                                    .paddingAll(12),
                          ),
                        ],
                      ),
                    ).onClick(
                      () {
                        Get.toNamed(Routes.treatmentPlanning);
                      },
                    ),
                  ],
                ),
              20.space(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  LocaleKeys.photos.translateText.normalText(
                    fontWeight: FontWeight.w600,
                    fontSize: !isTablet ? 20 : 24,
                  ),
                  10.space(),
                  AppDownloadTextButton(
                    downloadUrls: [
                      ApiUrl.patientGauche +
                          "${controller.patientDetailsModel?.patientPhoto?.gauche ?? ""}",
                      ApiUrl.patientFace +
                          "${controller.patientDetailsModel?.patientPhoto?.face ?? ""}",
                      ApiUrl.patientSourire +
                          "${controller.patientDetailsModel?.patientPhoto?.sourire ?? ""}",
                      ApiUrl.patientSourire +
                          "${controller.patientDetailsModel?.patientPhoto?.sourire ?? ""}",
                      ApiUrl.patientInterMandi +
                          "${controller.patientDetailsModel?.patientPhoto?.interMandi ?? ""}",
                      ApiUrl.patientInterGauche +
                          "${controller.patientDetailsModel?.patientPhoto?.interGauche ?? ""}",
                      ApiUrl.patientInterFace +
                          "${controller.patientDetailsModel?.patientPhoto?.interFace ?? ""}",
                      ApiUrl.patientIntraDroite +
                          "${controller.patientDetailsModel?.patientPhoto?.interDroite ?? ""}",
                    ],
                  ),
                ],
              ),
              12.space(),
              Row(
                children: [
                  Expanded(
                    child: photoWithTitle(
                      title: LocaleKeys.profile.translateText,
                      imagePath: ApiUrl.patientGauche +
                          "${controller.patientDetailsModel?.patientPhoto?.gauche ?? ""}",
                      radiosHeight: isTablet ? 120 : null,
                    ),
                  ),
                  isTablet ? 60.space() : 10.space(),
                  Expanded(
                    child: photoWithTitle(
                      title: LocaleKeys.face.translateText,
                      imagePath: ApiUrl.patientFace +
                          "${controller.patientDetailsModel?.patientPhoto?.face ?? ""}",
                      radiosHeight: isTablet ? 120 : null,
                    ),
                  ),
                  isTablet ? 60.space() : 10.space(),
                  Expanded(
                    child: photoWithTitle(
                      title: LocaleKeys.smile.translateText,
                      imagePath: ApiUrl.patientSourire +
                          "${controller.patientDetailsModel?.patientPhoto?.sourire ?? ""}",
                      radiosHeight: isTablet ? 120 : null,
                    ),
                  ),
                ],
              ),
              16.space(),
              Row(
                children: [
                  Expanded(
                    child: photoWithTitle(
                      title: LocaleKeys.intraMax.translateText,
                      imagePath: ApiUrl.patientSourire +
                          "${controller.patientDetailsModel?.patientPhoto?.sourire ?? ""}",
                      radiosHeight: isTablet ? 120 : null,
                    ),
                  ),
                  isTablet ? 60.space() : 10.space(),
                  Expanded(child: SizedBox()),
                  isTablet ? 60.space() : 10.space(),
                  Expanded(
                    child: photoWithTitle(
                      title: LocaleKeys.intraMand.translateText,
                      imagePath: ApiUrl.patientInterMandi +
                          "${controller.patientDetailsModel?.patientPhoto?.interMandi ?? ""}",
                      radiosHeight: isTablet ? 120 : null,
                    ),
                  ),
                ],
              ),
              16.space(),
              Row(
                children: [
                  Expanded(
                    child: photoWithTitle(
                      title: LocaleKeys.intraRight.translateText,
                      imagePath: ApiUrl.patientInterGauche +
                          "${controller.patientDetailsModel?.patientPhoto?.interGauche ?? ""}",
                      radiosHeight: isTablet ? 120 : null,
                    ),
                  ),
                  isTablet ? 60.space() : 10.space(),
                  Expanded(
                    child: photoWithTitle(
                      title: LocaleKeys.intraFace.translateText,
                      imagePath: ApiUrl.patientInterFace +
                          "${controller.patientDetailsModel?.patientPhoto?.interFace ?? ""}",
                      radiosHeight: isTablet ? 120 : null,
                    ),
                  ),
                  isTablet ? 60.space() : 10.space(),
                  Expanded(
                    child: photoWithTitle(
                      title: LocaleKeys.intraLeft.translateText,
                      imagePath: ApiUrl.patientIntraDroite +
                          "${controller.patientDetailsModel?.patientPhoto?.interDroite ?? ""}",
                      radiosHeight: isTablet ? 120 : null,
                    ),
                  ),
                ],
              ),
              20.space(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  LocaleKeys.radios.translateText.normalText(
                    fontWeight: FontWeight.w600,
                    fontSize: !isTablet ? 20 : 24,
                  ),
                  10.space(),
                  AppDownloadTextButton(
                    downloadUrls: [
                      ApiUrl.patientPanoramique +
                          "${controller.patientDetailsModel?.patientPhoto?.paramiqueRadio ?? ""}",
                      ApiUrl.patientCephalometrique +
                          "${controller.patientDetailsModel?.patientPhoto?.cephalRadio ?? ""}",
                    ],
                  ),
                ],
              ),
              12.space(),
              Row(
                children: [
                  Expanded(
                    child: photoWithTitle(
                      title: LocaleKeys.panoramic.translateText,
                      photoHeight: isTablet ? 180 : 125,
                      radiosHeight: 180,
                      photoWidth: Get.width,
                      imagePath: ApiUrl.patientPanoramique +
                          "${controller.patientDetailsModel?.patientPhoto?.paramiqueRadio ?? ""}",
                    ),
                  ),
                  isTablet ? 50.space() : 16.space(),
                  Expanded(
                    child: photoWithTitle(
                      title: LocaleKeys.cephalometric.translateText,
                      photoHeight: isTablet ? 180 : 125,
                      radiosHeight: 180,
                      photoWidth: Get.width,
                      imagePath: ApiUrl.patientCephalometrique +
                          "${controller.patientDetailsModel?.patientPhoto?.cephalRadio ?? ""}",
                    ),
                  ),
                ],
              ),
              20.space(),
              LocaleKeys.stlFile.translateText.normalText(
                fontWeight: FontWeight.w600,
                fontSize: !isTablet ? 20 : 24,
              ),
              12.space(),
              (controller.patientDetailsModel?.patientPhoto?.is3Shape == 1)
                  ? Container(
                      padding: EdgeInsets.all(!isTablet ? 15 : 20),
                      decoration: BoxDecoration(
                        color: primaryBrown.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: primaryBrown,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: LocaleKeys.postedBy3shape.translateText
                                .normalText(
                              fontWeight: FontWeight.w500,
                              color: primaryBrown,
                              fontSize: !isTablet ? 16 : 19,
                            ),
                          ),
                          Assets.icons.icTeethWithScreen.svg(
                            height: !isTablet ? 28 : 34,
                            width: !isTablet ? 28 : 34,
                          ),
                        ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LocaleKeys.upperJawStlFile.translateText.appCommonText(
                          size: !isTablet ? 14 : 18,
                          weight: FontWeight.w400,
                          align: TextAlign.start,
                        ),
                        6.space(),
                        Container(
                          padding: EdgeInsets.all(!isTablet ? 8 : 12),
                          decoration: BoxDecoration(
                            color: primaryBrown.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: primaryBrown,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child:
                                    "${controller.patientDetailsModel?.patientPhoto?.upperJawStlFile ?? "-"}"
                                        .normalText(
                                  fontWeight: FontWeight.w500,
                                  color: primaryBrown,
                                  fontSize: !isTablet ? 16 : 19,
                                ),
                              ),
                              AppDownloadButton(
                                url: ApiUrl.upperJawStlFile +
                                    (controller.patientDetailsModel
                                            ?.patientPhoto?.upperJawStlFile ??
                                        ''),
                              ),
                            ],
                          ),
                        ).onClick(
                          () {},
                        ),
                        12.space(),
                        LocaleKeys.lowerJawStlFile.translateText.appCommonText(
                          size: !isTablet ? 14 : 18,
                          weight: FontWeight.w400,
                          align: TextAlign.start,
                        ),
                        6.space(),
                        Container(
                          padding: EdgeInsets.all(!isTablet ? 8 : 12),
                          decoration: BoxDecoration(
                            color: primaryBrown.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: primaryBrown,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child:
                                    "${controller.patientDetailsModel?.patientPhoto?.lowerJawStlFile ?? "-"}"
                                        .normalText(
                                  fontWeight: FontWeight.w500,
                                  color: primaryBrown,
                                  fontSize: !isTablet ? 16 : 19,
                                ),
                              ),
                              AppDownloadButton(
                                url: ApiUrl.lowerJawStlFile +
                                    (controller.patientDetailsModel
                                            ?.patientPhoto?.lowerJawStlFile ??
                                        ''),
                              ),
                            ],
                          ),
                        ).onClick(
                          () {
                            // controller.downloadFile(ApiUrl.lowerJawStlFile+controller.patientDetailsModel?.patientPhoto?.lowerJawStlFile);
                          },
                        ),
                      ],
                    ),
              20.space(),
              if (controller.patientDetailsModel?.patientPhoto?.dcomFileName
                      ?.isNotEmpty ??
                  false)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LocaleKeys.dicomFile.translateText.normalText(
                      fontWeight: FontWeight.w600,
                      fontSize: !isTablet ? 20 : 24,
                    ),
                    12.space(),
                    Container(
                      padding: EdgeInsets.all(!isTablet ? 8 : 12),
                      decoration: BoxDecoration(
                        color: primaryBrown.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: primaryBrown,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: controller.patientDetailsModel!.patientPhoto!
                                .dcomFileName!
                                .normalText(
                              fontWeight: FontWeight.w500,
                              color: primaryBrown,
                              fontSize: !isTablet ? 16 : 19,
                            ),
                          ),
                          AppDownloadButton(
                            url: ApiUrl.dicomFile +
                                controller.patientDetailsModel!.patientPhoto!
                                    .dcomFileName!,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              20.space(),
              AppButton(
                text: LocaleKeys.downloadAll.translateText,
                radius: 100,
                btnHeight: !isTablet ? 55 : 70,
                fontColor: Colors.white,
                onTap: () {
                  List downloadUrls = [
                    ApiUrl.patientGauche +
                        "${controller.patientDetailsModel?.patientPhoto?.gauche ?? ""}",
                    ApiUrl.patientFace +
                        "${controller.patientDetailsModel?.patientPhoto?.face ?? ""}",
                    ApiUrl.patientSourire +
                        "${controller.patientDetailsModel?.patientPhoto?.sourire ?? ""}",
                    ApiUrl.patientSourire +
                        "${controller.patientDetailsModel?.patientPhoto?.sourire ?? ""}",
                    ApiUrl.patientInterMandi +
                        "${controller.patientDetailsModel?.patientPhoto?.interMandi ?? ""}",
                    ApiUrl.patientInterGauche +
                        "${controller.patientDetailsModel?.patientPhoto?.interGauche ?? ""}",
                    ApiUrl.patientInterFace +
                        "${controller.patientDetailsModel?.patientPhoto?.interFace ?? ""}",
                    ApiUrl.patientIntraDroite +
                        "${controller.patientDetailsModel?.patientPhoto?.interDroite ?? ""}",
                    if (controller
                            .patientDetailsModel?.patientPhoto?.is3Shape ==
                        0)
                      ApiUrl.upperJawStlFile +
                          (controller.patientDetailsModel?.patientPhoto
                                  ?.upperJawStlFile ??
                              ''),
                    if (controller
                            .patientDetailsModel?.patientPhoto?.is3Shape ==
                        0)
                      ApiUrl.lowerJawStlFile +
                          (controller.patientDetailsModel?.patientPhoto
                                  ?.lowerJawStlFile ??
                              ''),
                    if (controller.patientDetailsModel?.patientPhoto
                            ?.dcomFileName?.isNotEmpty ??
                        false)
                      ApiUrl.dicomFile +
                          controller
                              .patientDetailsModel!.patientPhoto!.dcomFileName!,
                  ];
                  downloadUrls.forEach(
                    (url) async {
                      Directory? baseStorage;
                      PermissionStatus status =
                          await Permission.notification.request();

                      String ext = url.split('.').last;
                      String name = url.split('/').last.split('.').first;
                      String fileName =
                          '${name}_${DateTime.now().millisecondsSinceEpoch}.$ext';

                      if (status.isGranted) {
                        if (Platform.isIOS) {
                          baseStorage =
                              await getApplicationDocumentsDirectory();
                        } else {
                          baseStorage = await getExternalStorageDirectory();
                        }
                        String? taskId = await FlutterDownloader.enqueue(
                          url: url,
                          savedDir: baseStorage!.path,
                          showNotification: true,
                          openFileFromNotification: true,
                          saveInPublicStorage: true,
                          fileName: fileName,
                        );

                        downloadTaskId['taskId'] = taskId;
                        downloadTaskId['path'] =
                            '${baseStorage.path}/$fileName';

                        if (taskId != null) {
                          downloadTaskId.putIfAbsent(
                            taskId,
                            () => downloadTaskId['path'],
                          );
                        }
                        isDownloadRunning = true;
                        downloadProgress = 0.0;
                      } else if (status.isDenied) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              LocaleKeys
                                  .withoutThisPermissionAppCanNotDownloadFile
                                  .translateText,
                            ),
                            action: SnackBarAction(
                              label: LocaleKeys.setting.translateText,
                              textColor: Colors.white,
                              onPressed: () {
                                openAppSettings();
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              },
                            ),
                            backgroundColor: primaryBrown,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      } else if (status.isPermanentlyDenied) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              LocaleKeys
                                  .toAccessThisFeaturePleaseGrantPermissionFromSettings
                                  .translateText,
                            ),
                            action: SnackBarAction(
                              label: LocaleKeys.setting.translateText,
                              textColor: Colors.white,
                              onPressed: () {
                                openAppSettings();
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              },
                            ),
                            backgroundColor: primaryBrown,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                  );
                },
                bgColor: primaryBrown,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget photoWithTitle({
    required String title,
    double? photoHeight,
    double? photoWidth,
    double? radiosHeight,
    required String imagePath,
    // AssetGenImage? assetImage,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: HomeImage.networkImage(
            path: imagePath,
            radius: BorderRadius.circular(6),
            shape: BoxShape.rectangle,
            fit: BoxFit.cover,
            width: Get.width,
            height: !isTablet ? 120 : radiosHeight,
          ),
        ),
        12.space(),
        title.normalText(
          fontWeight: FontWeight.w500,
          color: blackColor,
          fontSize: !isTablet ? 16 : 19,
        ),
      ],
    );
  }
}
