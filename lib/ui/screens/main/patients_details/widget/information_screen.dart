import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/home_image.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/model/clinic_model.dart';
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          AppTextField(
                            textEditingController:
                                controller.refinementController,
                            onChanged: (value) {},
                            validator: (value) {
                              if (value.isEmpty) {
                                controller.emailError = true;
                                controller.update();
                                return LocaleKeys
                                    .pleaseSelectBillingAddress.translateText;
                              }
                              controller.update();
                              return null;
                            },
                            readOnly: true,
                            showCursor: false,
                            onTap: () {
                              controller.showRefinementDropDown =
                                  !controller.showRefinementDropDown;
                              controller.update();
                            },
                            textFieldPadding: EdgeInsets.zero,
                            keyboardType: TextInputType.text,
                            // isError: ctrl.emailError,
                            hintText: LocaleKeys.select.translateText,
                            showPrefixWidget: Assets.icons.icDown
                                .svg(
                                  height: 10,
                                  width: 10,
                                )
                                .paddingOnly(left: 15, right: 15),
                            showPrefixIcon: true,
                          ),
                          Visibility(
                            visible: controller.showRefinementDropDown,
                            replacement: const SizedBox.shrink(),
                            child: Container(
                              // height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: primaryBrown),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const PageScrollPhysics(),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        DottedBorder(
                                  borderType: BorderType.RRect,
                                  color: primaryBrown,
                                  padding: EdgeInsets.zero,
                                  radius: const Radius.circular(35),
                                  dashPattern: const [5, 5, 5, 5],
                                  child: Container(),
                                ),
                                itemBuilder: (BuildContext builder, int index) {
                                  String data = controller.refinementList[
                                      index]; // Display filtered data when search is not empty
                                  return InkWell(
                                    onTap: () {
                                      print("onTap : $index");
                                      controller.showRefinementDropDown =
                                          !controller.showRefinementDropDown;
                                      controller.refinementController.text =
                                          '${data}';

                                      print(controller.selectedRefinementData);
                                      controller
                                              .selectedRefinementDropDownIndex =
                                          index == 0 ? -1 : index - 1;
                                      controller
                                          .selectedRefinementData = controller
                                                  .selectedRefinementDropDownIndex ==
                                              -1
                                          ? null
                                          : controller.patientDetailsModel!
                                                  .refinementList![
                                              controller
                                                  .selectedRefinementDropDownIndex];
                                      controller.update();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: '${data}'.appCommonText(
                                            color: Colors.black,
                                            maxLine: 1,
                                            align: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                            weight: FontWeight.w400,
                                            size: !isTablet ? 15 : 18,
                                          ),
                                        ),
                                        if (controller.refinementController.text
                                            .contains('${data}')) ...[
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
                                        left: 20,
                                        right: 20,
                                        top: 10,
                                        bottom: 10),
                                  );
                                },
                                itemCount: controller.refinementList.length,
                              ).paddingOnly(top: 5, bottom: 5),
                            ).paddingOnly(top: 15),
                          ),
                        ])),
                    10.space(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.only(top: 8),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: isTablet ? 70 : 52,
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
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: primaryBrown, width: 1),
                        ),
                      ).onClick(
                        () {
                          controller.deletePatient(
                            controller.patientDetailsModel?.patientId
                                    .toString() ??
                                '',
                            controller.patientDetailsModel?.isDeleted,
                          );
                        },
                      ),
                    )
                  ],
                ),
              12.space(),
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
                                  : "${controller.patientDetailsModel!.createdAt!.ddMMYYYYFormat()}"
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
              12.space(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: LocaleKeys.finishesAndContention.translateText
                        .normalText(
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w600,
                      fontSize: !isTablet ? 20 : 24,
                    ),
                  ),
                  /*Expanded(
                      child: LocaleKeys.finisher.translateText.normalText(
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w600,
                    fontSize: !isTablet ? 20 : 24,
                  )),*/
                ],
              ),
              12.space(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        Routes.uploadPhotographsScreen,
                        arguments: {
                          patientIdString:
                              controller.patientDetailsModel?.patientId,
                          isRefinementString: true,
                        },
                        // arguments: controller.patientDetailsModel?.patientId,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: lightBrown,
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        border: Border.all(color: skyColor),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          LocaleKeys.finishingGutters.translateText
                              .normalText(
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w600,
                                fontSize: !isTablet ? 16 : 20,
                              )
                              .paddingOnly(right: 5, left: 5, top: 15),
                          "0/2"
                              .normalText(
                                color: hintColor,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w600,
                                fontSize: !isTablet ? 16 : 20,
                              )
                              .paddingOnly(
                                  right: 5, left: 5, top: 10, bottom: 10),
                        ],
                      ),
                    ),
                  )),
                  10.space(),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: lightBrown,
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        border: Border.all(color: skyColor),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          LocaleKeys.retentionGutters.translateText
                              .normalText(
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w600,
                                fontSize: !isTablet ? 16 : 20,
                              )
                              .paddingOnly(right: 5, left: 5, top: 15),
                          "0/1"
                              .normalText(
                                color: hintColor,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w600,
                                fontSize: !isTablet ? 16 : 20,
                              )
                              .paddingOnly(
                                  right: 5, left: 5, top: 10, bottom: 10),
                        ],
                      ),
                    ),
                  ))
                ],
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
                                : "${controller.patientDetailsModel!.technicianStartDate!.ddMMYYYYFormat()}"
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
                      //
                      imagePath: controller.getPatientAndRefinementPath(
                          ApiUrl.patientGauche +
                              "${controller.patientDetailsModel?.patientPhoto?.gauche ?? ""}",
                          ApiUrl.patientGauche +
                              "${controller.selectedRefinementData?.profile ?? ""}"),
                      radiosHeight: isTablet ? 120 : null,
                    ),
                  ),
                  isTablet ? 60.space() : 10.space(),
                  Expanded(
                    child: photoWithTitle(
                      title: LocaleKeys.face.translateText,
                      imagePath: /*ApiUrl.patientFace +
                          "${controller.patientDetailsModel?.patientPhoto?.face ?? ""}"*/
                          controller.getPatientAndRefinementPath(
                              ApiUrl.patientFace +
                                  "${controller.patientDetailsModel?.patientPhoto?.face ?? ""}",
                              ApiUrl.patientFace +
                                  "${controller.selectedRefinementData?.face ?? ""}"),
                      radiosHeight: isTablet ? 120 : null,
                    ),
                  ),
                  isTablet ? 60.space() : 10.space(),
                  Expanded(
                    child: photoWithTitle(
                      title: LocaleKeys.smile.translateText,
                      imagePath: /*ApiUrl.patientSourire +
                          "${controller.patientDetailsModel?.patientPhoto?.sourire ?? ""}"*/
                          controller.getPatientAndRefinementPath(
                              ApiUrl.patientSourire +
                                  "${controller.patientDetailsModel?.patientPhoto?.sourire ?? ""}",
                              ApiUrl.patientSourire +
                                  "${controller.selectedRefinementData?.smile ?? ""}"),
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
                      imagePath: /*ApiUrl.patientSourire +
                          "${controller.patientDetailsModel?.patientPhoto?.sourire ?? ""}"*/
                          controller.getPatientAndRefinementPath(
                              ApiUrl.patientSourire +
                                  "${controller.patientDetailsModel?.patientPhoto?.interMax ?? ""}",
                              ApiUrl.patientSourire +
                                  "${controller.selectedRefinementData?.intraMax ?? ""}"),
                      radiosHeight: isTablet ? 120 : null,
                    ),
                  ),
                  isTablet ? 60.space() : 10.space(),
                  Expanded(child: SizedBox()),
                  isTablet ? 60.space() : 10.space(),
                  Expanded(
                    child: photoWithTitle(
                      title: LocaleKeys.intraMand.translateText,
                      imagePath: /*ApiUrl.patientInterMandi +
                          "${controller.patientDetailsModel?.patientPhoto?.interMandi ?? ""}"*/
                          controller.getPatientAndRefinementPath(
                              ApiUrl.patientInterMandi +
                                  "${controller.patientDetailsModel?.patientPhoto?.interMandi ?? ""}",
                              ApiUrl.patientInterMandi +
                                  "${controller.selectedRefinementData?.intraMand ?? ""}"),
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
                      imagePath: /*ApiUrl.patientInterGauche +
                          "${controller.patientDetailsModel?.patientPhoto?.interGauche ?? ""}"*/
                          controller.getPatientAndRefinementPath(
                              ApiUrl.patientInterGauche +
                                  "${controller.patientDetailsModel?.patientPhoto?.interGauche ?? ""}",
                              ApiUrl.patientInterGauche +
                                  "${controller.selectedRefinementData?.interRight ?? ""}"),
                      radiosHeight: isTablet ? 120 : null,
                    ),
                  ),
                  isTablet ? 60.space() : 10.space(),
                  Expanded(
                    child: photoWithTitle(
                      title: LocaleKeys.intraFace.translateText,
                      imagePath: /*ApiUrl.patientInterFace +
                          "${controller.patientDetailsModel?.patientPhoto?.interFace ?? ""}"*/
                          controller.getPatientAndRefinementPath(
                              ApiUrl.patientInterFace +
                                  "${controller.patientDetailsModel?.patientPhoto?.interFace ?? ""}",
                              ApiUrl.patientInterFace +
                                  "${controller.selectedRefinementData?.interFace ?? ""}"),
                      radiosHeight: isTablet ? 120 : null,
                    ),
                  ),
                  isTablet ? 60.space() : 10.space(),
                  Expanded(
                    child: photoWithTitle(
                      title: LocaleKeys.intraLeft.translateText,
                      imagePath: /*ApiUrl.patientIntraDroite +
                          "${controller.patientDetailsModel?.patientPhoto?.interDroite ?? ""}"*/
                          controller.getPatientAndRefinementPath(
                              ApiUrl.patientIntraDroite +
                                  "${controller.patientDetailsModel?.patientPhoto?.interDroite ?? ""}",
                              ApiUrl.patientIntraDroite +
                                  "${controller.selectedRefinementData?.interLeft ?? ""}"),
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
                      imagePath: /*ApiUrl.patientPanoramique +
                          "${controller.patientDetailsModel?.patientPhoto?.paramiqueRadio ?? ""}"*/
                          controller.getPatientAndRefinementPath(
                              ApiUrl.patientPanoramique +
                                  "${controller.patientDetailsModel?.patientPhoto?.paramiqueRadio ?? ""}",
                              ApiUrl.patientIntraDroite +
                                  "${controller.selectedRefinementData?.panRadio ?? ""}"),
                    ),
                  ),
                  isTablet ? 50.space() : 16.space(),
                  Expanded(
                    child: photoWithTitle(
                      title: LocaleKeys.cephalometric.translateText,
                      photoHeight: isTablet ? 180 : 125,
                      radiosHeight: 180,
                      photoWidth: Get.width,
                      imagePath: /*ApiUrl.patientCephalometrique +
                          "${controller.patientDetailsModel?.patientPhoto?.cephalRadio ?? ""}"*/
                          controller.getPatientAndRefinementPath(
                              ApiUrl.patientPanoramique +
                                  "${controller.patientDetailsModel?.patientPhoto?.cephalRadio ?? ""}",
                              ApiUrl.patientIntraDroite +
                                  "${controller.selectedRefinementData?.cephalRadio ?? ""}"),
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
              (controller.selectedRefinementDropDownIndex == -1)
                  ? (controller.patientDetailsModel?.patientPhoto?.is3Shape ==
                          1)
                      ? stlFile()
                      : upperAndLowerJaw(controller)
                  : (controller.selectedRefinementData?.is3Shape == 1)
                      ? stlFile()
                      : upperAndLowerJaw(controller),
              /*(controller.patientDetailsModel?.patientPhoto?.is3Shape == 1)
                  ? stlFile()
                  : upperAndLowerJaw(controller),*/
              20.space(),

              /*if (controller.patientDetailsModel?.patientPhoto?.dcomFileName
                      ?.isNotEmpty ??
                  false)*/
              (controller.selectedRefinementDropDownIndex == -1)
                  ? (controller.patientDetailsModel?.patientPhoto?.dcomFileName
                              ?.isNotEmpty ??
                          false)
                      ? dicomFile(controller
                          .patientDetailsModel!.patientPhoto!.dcomFileName!)
                      : SizedBox.shrink()
                  : dicomFile(controller.selectedRefinementData!.dicomFileName),
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

  Widget stlFile() {
    return Container(
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
            child: LocaleKeys.postedBy3shape.translateText.normalText(
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
    );
  }

  Widget upperAndLowerJaw(PatientsDetailsController controller) {
    return Column(
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
                    (controller.patientDetailsModel?.patientPhoto
                            ?.upperJawStlFile ??
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
                    (controller.patientDetailsModel?.patientPhoto
                            ?.lowerJawStlFile ??
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
    );
  }

  Widget dicomFile(String dcomFileName) {
    return Column(
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
                child: dcomFileName.normalText(
                  fontWeight: FontWeight.w500,
                  color: primaryBrown,
                  fontSize: !isTablet ? 16 : 19,
                ),
              ),
              AppDownloadButton(
                url: ApiUrl.dicomFile + dcomFileName,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
