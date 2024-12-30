import 'dart:developer';
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
import 'package:lynerdoctor/model/patient_details_model.dart';
import 'package:lynerdoctor/ui/screens/main/patients_details/patients_details_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';
import 'package:lynerdoctor/ui/widgets/app_download_button.dart';
import 'package:lynerdoctor/ui/widgets/app_download_text_button.dart';
import 'package:lynerdoctor/ui/widgets/image_view.dart';
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
              // if (controller.patientDetailsModel?.isDelivered == 0)
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
                          onChanged: (String value) {},
                          validator: (String value) {
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
                              itemCount: controller.refinementList.length,
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
                                String data = controller.refinementList[index];
                                return InkWell(
                                  onTap: () {
                                    controller.showRefinementDropDown =
                                        !controller.showRefinementDropDown;

                                    if (index == 0) {
                                      controller.refinementController.text =
                                          '${data}';
                                      // controller
                                      //         .selectedRefinementDropDownIndex =
                                      //     (index > 0) ? index - 1 : -1;
                                      controller
                                          .selectedRefinementDropDownIndex = -1;
                                      controller.link = controller
                                              .patientDetailsModel
                                              ?.patient3DModalLink ??
                                          "";
                                      controller.isApprove = controller
                                              .patientDetailsModel
                                              ?.isApproved ==
                                          1;
                                      if (controller
                                              .patientDetailsModel?.linkDate !=
                                          null) {
                                        controller.linkDate = controller
                                            .patientDetailsModel?.linkDate;
                                      }
                                    }

                                    if (((index != 0 &&
                                                index !=
                                                    (controller.refinementList
                                                            .length -
                                                        1)) &&
                                            ((controller.patientDetailsModel
                                                        ?.stage ??
                                                    "") ==
                                                refinement)) ||
                                        ((controller.patientDetailsModel
                                                    ?.stage ??
                                                "") ==
                                            containment)) {
                                      bool isTapped = false;
                                      if (controller.patientDetailsModel
                                              ?.refinementStage?.isNotEmpty ??
                                          false) {
                                        int refinementStageNumber = int.parse(
                                            controller.patientDetailsModel!
                                                .refinementStage!);
                                        if (index <= refinementStageNumber) {
                                          isTapped = true;
                                        }
                                      }

                                      if (isTapped) {
                                        controller.refinementController.text =
                                            '${data}';
                                        // controller.isApprove = controller.selectedRefinementData.is
                                        controller
                                                .selectedRefinementDropDownIndex =
                                            (index > 0) ? index - 1 : -1;
                                        if (controller.patientDetailsModel !=
                                                null &&
                                            controller.patientDetailsModel!
                                                    .refinementList !=
                                                null &&
                                            (controller
                                                    .patientDetailsModel!
                                                    .refinementList
                                                    ?.isNotEmpty ??
                                                false)) {
                                          controller
                                              .selectedRefinementData = (controller
                                                      .selectedRefinementDropDownIndex ==
                                                  -1
                                              ? null
                                              : (controller
                                                          .selectedRefinementDropDownIndex <=
                                                      (controller
                                                              .patientDetailsModel!
                                                              .refinementList!
                                                              .length -
                                                          1))
                                                  ? controller
                                                          .patientDetailsModel!
                                                          .refinementList![
                                                      controller
                                                          .selectedRefinementDropDownIndex]
                                                  : null);

                                          controller.link = controller
                                                  .selectedRefinementData
                                                  ?.refinePatient3dModalLink ??
                                              "";
                                          controller.isApprove = controller
                                                  .selectedRefinementData
                                                  ?.isRefineApproved ==
                                              1;
                                          if (controller.patientDetailsModel
                                                  ?.linkDate !=
                                              null) {
                                            controller.linkDate = controller
                                                .selectedRefinementData
                                                ?.refineLinkDate;
                                          }
                                          print(
                                              "--> ${controller.selectedRefinementData}");
                                        } else {
                                          controller.selectedRefinementData =
                                              null;
                                          controller.link = "";
                                          controller.isApprove = false;
                                        }
                                      }
                                    }

                                    // if (((controller.patientDetailsModel
                                    //                 ?.stage ??
                                    //             beginning) ==
                                    //         refinement) &&
                                    //     (controller.patientDetailsModel
                                    //             ?.refinementStage ==
                                    //         ("${index}"))) {
                                    //   controller.refinementController.text =
                                    //       '${data}';
                                    //   controller
                                    //           .selectedRefinementDropDownIndex =
                                    //       (index > 0) ? index - 1 : -1;
                                    //   if (controller.patientDetailsModel !=
                                    //           null &&
                                    //       controller.patientDetailsModel!
                                    //               .refinementList !=
                                    //           null &&
                                    //       (controller.patientDetailsModel!
                                    //               .refinementList?.isNotEmpty ??
                                    //           false)) {
                                    //     controller
                                    //         .selectedRefinementData = (controller
                                    //                 .selectedRefinementDropDownIndex ==
                                    //             -1
                                    //         ? null
                                    //         : (controller
                                    //                     .selectedRefinementDropDownIndex <=
                                    //                 (controller
                                    //                         .patientDetailsModel!
                                    //                         .refinementList!
                                    //                         .length -
                                    //                     1))
                                    //             ? controller
                                    //                     .patientDetailsModel!
                                    //                     .refinementList![
                                    //                 controller
                                    //                     .selectedRefinementDropDownIndex]
                                    //             : null);
                                    //
                                    //     controller.link = controller
                                    //             .selectedRefinementData
                                    //             ?.refinePatient3dModalLink ??
                                    //         "";
                                    //     print(
                                    //         "--> ${controller.selectedRefinementData}");
                                    //   }
                                    // }

                                    if ((index ==
                                            (controller.refinementList.length -
                                                1)) &&
                                        ((controller.patientDetailsModel
                                                    ?.stage ??
                                                "") !=
                                            beginning)) {
                                      controller
                                          .selectedRefinementDropDownIndex = 0;
                                      controller.refinementController.text =
                                          '${data}';
                                      controller.selectedRefinementData =
                                          controller.patientDetailsModel
                                                  ?.containment ??
                                              null;
                                      controller.link = "";
                                      controller.isApprove = false;

                                      print(
                                          "---- ${controller.selectedRefinementData}");
                                    }
                                    // if ((controller
                                    //             .patientDetailsModel?.stage ??
                                    //         "") ==
                                    //     containment) {
                                    //   //controller.link = "";
                                    //   controller.refinementController.text =
                                    //       '${data}';
                                    //   controller.selectedRefinementData =
                                    //       controller.patientDetailsModel
                                    //               ?.containment ??
                                    //           null;
                                    //   print(
                                    //       "---- ${controller.selectedRefinementData}");
                                    // }
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
                                    bottom: 10,
                                  ),
                                );
                              },
                            ).paddingOnly(top: 5, bottom: 5),
                          ).paddingOnly(top: 15),
                        ),
                      ],
                    ),
                  ),
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
                        if (((controller.patientDetailsModel?.stage ?? "") ==
                                refinement) &&
                            (controller.patientDetailsModel?.containment ==
                                null)) {
                          int refinementStage = 0;
                          if (controller.patientDetailsModel?.refinementStage
                                  ?.isNotEmpty ??
                              false) {
                            refinementStage = int.parse(controller
                                .patientDetailsModel!.refinementStage!);
                          }
                          Get.toNamed(
                            Routes.uploadPhotographsScreen,
                            arguments: {
                              patientIdString:
                                  controller.patientDetailsModel?.patientId,
                              isRefinementString: true,
                              isRetentionString: false,
                              refinementIdString: refinementStage,
                            },
                          )?.then(
                            (value) {
                              controller.getPatientInformationDetails();
                            },
                          );
                        }

                        // if ((controller.patientDetailsModel?.stage ?? "") ==
                        //     refinement) {
                        //   bool isTapped = (controller.patientDetailsModel
                        //           ?.refinementList?.isEmpty ??
                        //       true);
                        //   for (int i = 0;
                        //       i <
                        //           (controller.patientDetailsModel
                        //                   ?.refinementList?.length ??
                        //               0);
                        //       i++) {
                        //     if ("${controller.patientDetailsModel?.refinementStage}" ==
                        //         "${controller.patientDetailsModel!.refinementList![i].refinementNumber}") {
                        //       isTapped = controller.patientDetailsModel!
                        //               .refinementList![i].isRefineShipped ==
                        //           0;
                        //     }
                        //   }
                        //
                        //   if (isTapped) {
                        //     int refinementStage = 0;
                        //     if (controller.patientDetailsModel?.refinementStage
                        //             ?.isNotEmpty ??
                        //         false) {
                        //       refinementStage = int.parse(controller
                        //           .patientDetailsModel!.refinementStage!);
                        //     }
                        //     Get.toNamed(
                        //       Routes.uploadPhotographsScreen,
                        //       arguments: {
                        //         patientIdString:
                        //             controller.patientDetailsModel?.patientId,
                        //         isRefinementString: true,
                        //         isRetentionString: false,
                        //         refinementIdString: refinementStage,
                        //       },
                        //     )?.then(
                        //       (value) {
                        //         controller.getPatientInformationDetails();
                        //       },
                        //     );
                        //   }
                        // }
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
                            // controller.patientDetailsModel!=null && (controller.patientDetailsModel?.refinementList?.isNotEmpty??false)
                            "${controller.finishingGutters}/${controller.patientDetailsModel?.toothCase?.totalRefinement ?? 0}"
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
                    ),
                  ),
                  10.space(),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      bool isTapped = false;

                      if ((controller.patientDetailsModel?.stage ?? "") !=
                          beginning) {
                        if ((controller.patientDetailsModel?.stage ?? "") ==
                            containment) {
                          if (controller
                                  .patientDetailsModel?.containment?.isDraft ==
                              1) {
                            isTapped = false;
                          } else {
                            isTapped = true;
                          }
                        } else {
                          if (((controller.patientDetailsModel?.stage ?? "") ==
                                  refinement) &&
                              controller.patientDetailsModel?.refinementList ==
                                  null) {
                            isTapped = true;
                          } else {
                            if (controller.patientDetailsModel?.containment ==
                                null) {
                              bool isAddRefinementDone = true;
                              for (int i = 0;
                                  i <
                                      controller.patientDetailsModel!
                                          .refinementList!.length;
                                  i++) {
                                RefinementList refinementData = controller
                                    .patientDetailsModel!.refinementList![i];

                                if (refinementData.isRefineShipped == 0) {
                                  isAddRefinementDone = false;
                                  break;
                                }
                              }
                              if (isAddRefinementDone) {
                                isTapped = true;
                              }
                            } else {
                              if (controller.patientDetailsModel?.containment
                                      ?.isDraft ==
                                  1) {
                                isTapped = true;
                              }
                            }
                          }
                        }
                      }

                      if (isTapped) {
                        Get.toNamed(
                          Routes.uploadPhotographsScreen,
                          arguments: {
                            patientIdString:
                                controller.patientDetailsModel?.patientId,
                            isRefinementString: false,
                            isRetentionString: true,
                            refinementIdString: controller.finishingGutters + 1,
                          },
                        )?.then(
                          (value) {
                            controller.getPatientInformationDetails();
                          },
                        );
                      }

                      // if ((controller.patientDetailsModel?.stage ?? "") ==
                      //     containment) {
                      //
                      // }
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
                          LocaleKeys.retentionGutters.translateText
                              .normalText(
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w600,
                                fontSize: !isTablet ? 16 : 20,
                              )
                              .paddingOnly(right: 5, left: 5, top: 15),
                          "${controller.patientDetailsModel?.containment?.isDraft == 0 ? 1 : 0}/1"
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
              if (controller.link.isNotEmpty)
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
                                      text: controller.isApprove
                                          ? LocaleKeys.approved.translateText
                                          : LocaleKeys
                                              .pendingApproval.translateText,
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
                            child: (controller.linkDate == null)
                                ? "-"
                                    .appCommonText(
                                      weight: FontWeight.w600,
                                      size: !isTablet ? 16 : 19,
                                      color: primaryBrown,
                                    )
                                    .paddingAll(12)
                                : "${controller.linkDate!.ddMMYYYYFormat()}"
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
                        controller.isShowLatestLink = false;
                        Get.toNamed(
                          Routes.treatmentPlanning,
                          arguments: {
                            link: controller.link,
                          },
                        );
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
                  controller.selectedRefinementDropDownIndex == -1
                      ? ((controller.patientDetailsModel?.patientPhoto?.gauche ?? "") == "" &&
                              (controller.patientDetailsModel?.patientPhoto?.face ?? "") ==
                                  "" &&
                              (controller.patientDetailsModel?.patientPhoto?.sourire ?? "") ==
                                  "" &&
                              (controller.patientDetailsModel?.patientPhoto
                                          ?.interMax ??
                                      "") ==
                                  "" &&
                              (controller.patientDetailsModel?.patientPhoto
                                          ?.interMandi ??
                                      "") ==
                                  "" &&
                              (controller.patientDetailsModel?.patientPhoto
                                          ?.interGauche ??
                                      "") ==
                                  "" &&
                              (controller.patientDetailsModel?.patientPhoto
                                          ?.interFace ??
                                      "") ==
                                  "" &&
                              (controller.patientDetailsModel?.patientPhoto
                                          ?.interDroite ??
                                      "") ==
                                  "")
                          ? SizedBox.shrink()
                          : AppDownloadTextButton(
                              downloadUrls: [
                                ApiUrl.patientGauche +
                                    "${controller.patientDetailsModel?.patientPhoto?.gauche ?? ""}",
                                ApiUrl.patientFace +
                                    "${controller.patientDetailsModel?.patientPhoto?.face ?? ""}",
                                ApiUrl.patientSourire +
                                    "${controller.patientDetailsModel?.patientPhoto?.sourire ?? ""}",
                                ApiUrl.patientIntraMax +
                                    "${controller.patientDetailsModel?.patientPhoto?.interMax ?? ""}",
                                ApiUrl.patientInterMandi +
                                    "${controller.patientDetailsModel?.patientPhoto?.interMandi ?? ""}",
                                ApiUrl.patientInterGauche +
                                    "${controller.patientDetailsModel?.patientPhoto?.interGauche ?? ""}",
                                ApiUrl.patientInterFace +
                                    "${controller.patientDetailsModel?.patientPhoto?.interFace ?? ""}",
                                ApiUrl.patientIntraDroite +
                                    "${controller.patientDetailsModel?.patientPhoto?.interDroite ?? ""}",
                              ],
                            )
                      : ((controller.selectedRefinementData?.profile ?? "") == "" &&
                              (controller.selectedRefinementData?.face ?? "") ==
                                  "" &&
                              (controller.selectedRefinementData?.smile ?? "") ==
                                  "" &&
                              (controller.selectedRefinementData?.intraMax ??
                                      "") ==
                                  "" &&
                              (controller
                                          .selectedRefinementData?.intraMand ??
                                      "") ==
                                  "" &&
                              (controller
                                          .selectedRefinementData?.interRight ??
                                      "") ==
                                  "" &&
                              (controller.selectedRefinementData?.interFace ??
                                      "") ==
                                  "" &&
                              (controller.selectedRefinementData?.interLeft ??
                                      "") ==
                                  "")
                          ? SizedBox.shrink()
                          : AppDownloadTextButton(
                              downloadUrls: [
                                ApiUrl.patientGauche +
                                    "${controller.selectedRefinementData?.profile ?? ""}",
                                ApiUrl.patientFace +
                                    "${controller.selectedRefinementData?.face ?? ""}",
                                ApiUrl.patientSourire +
                                    "${controller.selectedRefinementData?.smile ?? ""}",
                                ApiUrl.patientIntraMax +
                                    "${controller.selectedRefinementData?.intraMax ?? ""}",
                                ApiUrl.patientInterMandi +
                                    "${controller.selectedRefinementData?.intraMand ?? ""}",
                                ApiUrl.patientInterGauche +
                                    "${controller.selectedRefinementData?.interRight ?? ""}",
                                ApiUrl.patientInterFace +
                                    "${controller.selectedRefinementData?.interFace ?? ""}",
                                ApiUrl.patientIntraDroite +
                                    "${controller.selectedRefinementData?.interLeft ?? ""}",
                              ],
                            ),
                ],
              ),
              12.space(),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showImageDialog(
                          context: context,
                          imagePath: controller.getPatientAndRefinementPath(
                              ApiUrl.patientGauche +
                                  "${controller.patientDetailsModel?.patientPhoto?.gauche ?? ""}",
                              ApiUrl.patientGauche +
                                  "${controller.selectedRefinementData?.profile ?? ""}"),
                        );
                      },
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
                  ),
                  isTablet ? 60.space() : 10.space(),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showImageDialog(
                          context: context,
                          imagePath: controller.getPatientAndRefinementPath(
                              ApiUrl.patientFace +
                                  "${controller.patientDetailsModel?.patientPhoto?.face ?? ""}",
                              ApiUrl.patientFace +
                                  "${controller.selectedRefinementData?.face ?? ""}"),
                        );
                      },
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
                  ),
                  isTablet ? 60.space() : 10.space(),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showImageDialog(
                          context: context,
                          imagePath: /*ApiUrl.patientSourire +
                            "${controller.patientDetailsModel?.patientPhoto?.sourire ?? ""}"*/
                              controller.getPatientAndRefinementPath(
                                  ApiUrl.patientSourire +
                                      "${controller.patientDetailsModel?.patientPhoto?.sourire ?? ""}",
                                  ApiUrl.patientSourire +
                                      "${controller.selectedRefinementData?.smile ?? ""}"),
                        );
                      },
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
                  ),
                ],
              ),
              16.space(),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showImageDialog(
                          context: context,
                          imagePath: /*ApiUrl.patientSourire +
                            "${controller.patientDetailsModel?.patientPhoto?.sourire ?? ""}"*/
                              controller.getPatientAndRefinementPath(
                                  ApiUrl.patientIntraMax +
                                      "${controller.patientDetailsModel?.patientPhoto?.interMax ?? ""}",
                                  ApiUrl.patientIntraMax +
                                      "${controller.selectedRefinementData?.intraMax ?? ""}"),
                        );
                      },
                      child: photoWithTitle(
                        title: LocaleKeys.intraMax.translateText,
                        imagePath: /*ApiUrl.patientSourire +
                            "${controller.patientDetailsModel?.patientPhoto?.sourire ?? ""}"*/
                            controller.getPatientAndRefinementPath(
                                ApiUrl.patientIntraMax +
                                    "${controller.patientDetailsModel?.patientPhoto?.interMax ?? ""}",
                                ApiUrl.patientIntraMax +
                                    "${controller.selectedRefinementData?.intraMax ?? ""}"),
                        radiosHeight: isTablet ? 120 : null,
                      ),
                    ),
                  ),
                  isTablet ? 60.space() : 10.space(),
                  Expanded(child: SizedBox()),
                  isTablet ? 60.space() : 10.space(),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showImageDialog(
                          context: context,
                          imagePath: /*ApiUrl.patientInterMandi +
                            "${controller.patientDetailsModel?.patientPhoto?.interMandi ?? ""}"*/
                              controller.getPatientAndRefinementPath(
                                  ApiUrl.patientInterMandi +
                                      "${controller.patientDetailsModel?.patientPhoto?.interMandi ?? ""}",
                                  ApiUrl.patientInterMandi +
                                      "${controller.selectedRefinementData?.intraMand ?? ""}"),
                        );
                      },
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
                  ),
                ],
              ),
              16.space(),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showImageDialog(
                          context: context,
                          imagePath: /*ApiUrl.patientInterGauche +
                            "${controller.patientDetailsModel?.patientPhoto?.interGauche ?? ""}"*/
                              controller.getPatientAndRefinementPath(
                                  ApiUrl.patientInterGauche +
                                      "${controller.patientDetailsModel?.patientPhoto?.interGauche ?? ""}",
                                  ApiUrl.patientInterGauche +
                                      "${controller.selectedRefinementData?.interRight ?? ""}"),
                        );
                      },
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
                  ),
                  isTablet ? 60.space() : 10.space(),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showImageDialog(
                          context: context,
                          imagePath: /*ApiUrl.patientInterFace +
                            "${controller.patientDetailsModel?.patientPhoto?.interFace ?? ""}"*/
                              controller.getPatientAndRefinementPath(
                                  ApiUrl.patientInterFace +
                                      "${controller.patientDetailsModel?.patientPhoto?.interFace ?? ""}",
                                  ApiUrl.patientInterFace +
                                      "${controller.selectedRefinementData?.interFace ?? ""}"),
                        );
                      },
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
                  ),
                  isTablet ? 60.space() : 10.space(),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showImageDialog(
                          context: context,
                          imagePath: /*ApiUrl.patientIntraDroite +
                            "${controller.patientDetailsModel?.patientPhoto?.interDroite ?? ""}"*/
                              controller.getPatientAndRefinementPath(
                                  ApiUrl.patientIntraDroite +
                                      "${controller.patientDetailsModel?.patientPhoto?.interDroite ?? ""}",
                                  ApiUrl.patientIntraDroite +
                                      "${controller.selectedRefinementData?.interLeft ?? ""}"),
                        );
                      },
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
                  (controller.selectedRefinementDropDownIndex == -1)
                      ? ((controller.patientDetailsModel?.patientPhoto
                                          ?.paramiqueRadio ??
                                      "") ==
                                  "" &&
                              (controller.patientDetailsModel?.patientPhoto
                                          ?.cephalRadio ??
                                      "") ==
                                  "")
                          ? SizedBox.shrink()
                          : AppDownloadTextButton(downloadUrls: [
                              ApiUrl.patientPanoramique +
                                  "${controller.patientDetailsModel?.patientPhoto?.paramiqueRadio ?? ""}",
                              ApiUrl.patientCephalometrique +
                                  "${controller.patientDetailsModel?.patientPhoto?.cephalRadio ?? ""}",
                            ])
                      : ((controller.selectedRefinementData?.panRadio ?? "") ==
                                  "" &&
                              (controller.selectedRefinementData?.cephalRadio ??
                                      "") ==
                                  "")
                          ? SizedBox.shrink()
                          : AppDownloadTextButton(
                              downloadUrls: [
                                ApiUrl.patientPanoramique +
                                    "${controller.selectedRefinementData?.panRadio ?? ""}",
                                ApiUrl.patientCephalometrique +
                                    "${controller.selectedRefinementData?.cephalRadio ?? ""}",
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
                              ApiUrl.patientPanoramique +
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
                              ApiUrl.patientCephalometrique +
                                  "${controller.patientDetailsModel?.patientPhoto?.cephalRadio ?? ""}",
                              ApiUrl.patientCephalometrique +
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
                      : ((controller.patientDetailsModel?.patientPhoto
                                          ?.upperJawStlFile ??
                                      '') ==
                                  "" &&
                              (controller.patientDetailsModel?.patientPhoto
                                          ?.upperJawStlFile ??
                                      '') ==
                                  "")
                          ? stlFile()
                          : upperAndLowerJaw(controller)
                  : (controller.selectedRefinementData?.is3Shape == 1)
                      ? stlFile()
                      : ((controller.selectedRefinementData?.upperJawStlFile ??
                                      '') ==
                                  "" &&
                              (controller.selectedRefinementData
                                          ?.upperJawStlFile ??
                                      '') ==
                                  "")
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
                  : ((controller.selectedRefinementData?.dicomFileName ?? "")
                          .isNotEmpty)
                      ? dicomFile(
                          controller.selectedRefinementData?.dicomFileName ??
                              "")
                      : SizedBox.shrink(),
              20.space(),
              if (controller.selectedRefinementDropDownIndex != -1) ...[
                LocaleKeys.arcadeTraiter.translateText.appCommonText(
                  align: TextAlign.start,
                  size: !isTablet ? 24 : 27,
                  maxLine: 2,
                  overflow: TextOverflow.ellipsis,
                  weight: FontWeight.w500,
                  color: Colors.black,
                ),
                LocaleKeys.whereTheSimulationWillBeCarriedOut.translateText
                    .appCommonText(
                  align: TextAlign.start,
                  size: !isTablet ? 16 : 19,
                  maxLine: 2,
                  overflow: TextOverflow.ellipsis,
                  weight: FontWeight.w400,
                  color: hintStepColor,
                ),
                10.space(),
                Container(
                  height: !isTablet ? 55 : 70,
                  alignment: AlignmentDirectional.centerStart,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(!isTablet ? 25 : 40),
                    color: Colors.white,
                    border: Border.all(color: skyColor),
                  ),
                  child: ((controller.selectedRefinementData?.arcadeOption ==
                                  "Both" ||
                              controller.selectedRefinementData?.arcadeOption ==
                                  "Les deux")
                          ? LocaleKeys.lesDeux.translateText
                          : (controller.selectedRefinementData?.arcadeOption ==
                                      "Maxillary" ||
                                  controller.selectedRefinementData
                                          ?.arcadeOption ==
                                      "Maxillaire")
                              ? LocaleKeys.maxillaire.translateText
                              : (controller.selectedRefinementData
                                              ?.arcadeOption ==
                                          "Mandibular" ||
                                      controller.selectedRefinementData
                                              ?.arcadeOption ==
                                          "Mandibulaire")
                                  ? LocaleKeys.mandibulaire.translateText
                                  : "-")
                      .appCommonText(
                        size: !isTablet ? 16 : 19,
                        weight: FontWeight.w400,
                        color: Colors.black,
                      )
                      .paddingOnly(left: 15),
                ),
                10.space(),
                LocaleKeys.comments.translateText.appCommonText(
                  align: TextAlign.start,
                  size: !isTablet ? 24 : 27,
                  maxLine: 2,
                  overflow: TextOverflow.ellipsis,
                  weight: FontWeight.w500,
                  color: Colors.black,
                ),
                AppTextField(
                  maxLines: 3,
                  // textEditingController: controller.commentController,
                  readOnly: true,
                  onChanged: (String value) {},
                  validator: (String value) {},
                  textFieldPadding: EdgeInsets.zero,
                  keyboardType: TextInputType.text,
                  hintText:
                      "${controller.selectedRefinementData?.arcadeComment ?? "-"}",
                  hintTextStyle: TextStyle(
                    fontSize: !isTablet ? 15 : 18,
                    color: blackColor,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'maax-medium-medium',
                  ),
                  showPrefixIcon: false,
                ),
                30.space(),
              ],
              AppButton(
                text: LocaleKeys.downloadAll.translateText,
                radius: 100,
                btnHeight: !isTablet ? 55 : 70,
                fontColor: Colors.white,
                onTap: () {
                  List downloadUrls = controller
                              .selectedRefinementDropDownIndex ==
                          -1
                      ? [
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
                          ApiUrl.patientPanoramique +
                              "${controller.patientDetailsModel?.patientPhoto?.paramiqueRadio ?? ""}",
                          ApiUrl.patientCephalometrique +
                              "${controller.patientDetailsModel?.patientPhoto?.cephalRadio ?? ""}",
                          if (controller.patientDetailsModel?.patientPhoto
                                  ?.is3Shape ==
                              0)
                            ApiUrl.upperJawStlFile +
                                (controller.patientDetailsModel?.patientPhoto
                                        ?.upperJawStlFile ??
                                    ''),
                          if (controller.patientDetailsModel?.patientPhoto
                                  ?.is3Shape ==
                              0)
                            ApiUrl.lowerJawStlFile +
                                (controller.patientDetailsModel?.patientPhoto
                                        ?.lowerJawStlFile ??
                                    ''),
                          ApiUrl.patientCephalometrique +
                              "${controller.patientDetailsModel?.patientPhoto?.cephalRadio ?? ""}",
                          ApiUrl.patientPanoramique +
                              "${controller.patientDetailsModel?.patientPhoto?.paramiqueRadio ?? ""}",
                          if (controller.patientDetailsModel?.patientPhoto
                                  ?.dcomFileName?.isNotEmpty ??
                              false)
                            ApiUrl.dicomFile +
                                controller.patientDetailsModel!.patientPhoto!
                                    .dcomFileName!,
                        ]
                      : [
                          ApiUrl.patientGauche +
                              "${controller.selectedRefinementData?.profile ?? ""}",
                          ApiUrl.patientFace +
                              "${controller.selectedRefinementData?.face ?? ""}",
                          ApiUrl.patientSourire +
                              "${controller.selectedRefinementData?.smile ?? ""}",
                          ApiUrl.patientIntraMax +
                              "${controller.selectedRefinementData?.intraMax ?? ""}",
                          ApiUrl.patientInterMandi +
                              "${controller.selectedRefinementData?.intraMand ?? ""}",
                          ApiUrl.patientInterGauche +
                              "${controller.selectedRefinementData?.interRight ?? ""}",
                          ApiUrl.patientInterFace +
                              "${controller.selectedRefinementData?.interFace ?? ""}",
                          ApiUrl.patientIntraDroite +
                              "${controller.selectedRefinementData?.interLeft ?? ""}",
                          if (controller.selectedRefinementData?.is3Shape == 0)
                            ApiUrl.upperJawStlFile +
                                (controller.selectedRefinementData
                                        ?.upperJawStlFile ??
                                    ''),
                          if (controller.selectedRefinementData?.is3Shape == 0)
                            ApiUrl.lowerJawStlFile +
                                (controller.selectedRefinementData
                                        ?.lowerJawStlFile ??
                                    ''),
                          ApiUrl.patientCephalometrique +
                              "${controller.selectedRefinementData?.cephalRadio ?? ""}",
                          ApiUrl.patientPanoramique +
                              "${controller.selectedRefinementData?.panRadio ?? ""}",
                          ApiUrl.dicomFile +
                              (controller
                                      .selectedRefinementData?.dicomFileName ??
                                  ""),
                          if (controller.selectedRefinementData?.dicomFileName
                                  .isNotEmpty ??
                              false)
                            ApiUrl.dicomFile +
                                (controller
                                    .selectedRefinementData!.dicomFileName),
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
    log("---> $imagePath  <---");
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
                    "${controller.selectedRefinementDropDownIndex == -1 ? controller.patientDetailsModel?.patientPhoto?.upperJawStlFile : controller.selectedRefinementData?.upperJawStlFile}"
                        .normalText(
                  fontWeight: FontWeight.w500,
                  color: primaryBrown,
                  fontSize: !isTablet ? 16 : 19,
                ),
              ),
              AppDownloadButton(
                url: ApiUrl.upperJawStlFile +
                    (controller.selectedRefinementDropDownIndex == -1
                        ? controller
                            .patientDetailsModel?.patientPhoto?.upperJawStlFile
                        : controller.selectedRefinementData?.upperJawStlFile),
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
                    "${controller.selectedRefinementDropDownIndex == -1 ? controller.patientDetailsModel?.patientPhoto?.lowerJawStlFile : controller.selectedRefinementData?.lowerJawStlFile}"
                        .normalText(
                  fontWeight: FontWeight.w500,
                  color: primaryBrown,
                  fontSize: !isTablet ? 16 : 19,
                ),
              ),
              AppDownloadButton(
                url: ApiUrl.lowerJawStlFile +
                    (controller.selectedRefinementDropDownIndex == -1
                        ? controller
                            .patientDetailsModel?.patientPhoto?.lowerJawStlFile
                        : controller.selectedRefinementData?.lowerJawStlFile),
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
