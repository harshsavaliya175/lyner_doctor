import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/model/case_response_model.dart';
import 'package:lynerdoctor/ui/screens/main/case_selection/case_selection_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_bar.dart';
import 'package:lynerdoctor/ui/widgets/app_case_selection_card.dart';
import 'package:lynerdoctor/ui/widgets/app_progress_view.dart';
import 'package:lynerdoctor/ui/widgets/case_filter_bottom_sheet.dart';

class CaseSelectionScreen extends StatelessWidget {
  CaseSelectionScreen({super.key});

  final CaseSelectionController caseSelectionController =
      Get.put(CaseSelectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: appbarWithIcons(
        centerTitle: false,
        title: Text(
          LocaleKeys.caseSelection.translateText,
          style: TextStyle(
            fontFamily: Assets.fonts.maax,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: !isTablet ? 20 : 25,
          ),
        ),
        backgroundColor: Colors.white,
        leadingWidth: 5,
        leading: SizedBox(),
        elevation: 0.5,
        // rightIcon: Assets.icons.icLynerAddPatient
        //     .svg(
        //   height: !isTablet ? 28.h : 35.h,
        // )
        //     .onClick(
        //   () {
        //     Get.toNamed(Routes.addCaseSelection);
        //   },
        // ).paddingOnly(right: 15),
      ),
      body: GetBuilder<CaseSelectionController>(
        builder: (CaseSelectionController ctrl) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  24.space(),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          prefixIcon: Assets.icons.icSearch,
                          hintText: LocaleKeys.search.translateText,
                          controller: ctrl.searchController,
                          action: TextInputAction.done,
                          onChange: (String value) {
                            ctrl.caseList.clear();
                            Future.delayed(
                              Duration(seconds: 2),
                              () {
                                caseSelectionController
                                    .getCaseSelectionListByStatus(
                                  isFromSearch: true,
                                );
                              },
                            );
                          },
                        ),
                      ),
                      12.space(),
                      SizedBox(
                        width: 60.w,
                        height: 60.w,
                        child: FloatingActionButton(
                          elevation: 0,
                          onPressed: () {
                            context.showAppBottomSheet(
                              contentWidget: CaseFilterBottomSheet(
                                onTap: () {
                                  caseSelectionController
                                      .getCaseSelectionListByStatus();
                                },
                              ),
                            );
                          },
                          child: Assets.icons.icFilter.svg(
                            height: 28,
                            width: 28,
                            fit: BoxFit.none,
                            colorFilter: ColorFilter.mode(
                              whiteColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          heroTag: Object(),
                          shape: CircleBorder(),
                          backgroundColor: primaryBrown,
                        ),
                      )
                    ],
                  ),
                  24.space(),
                  "${ctrl.caseSelectionFilterValue == 1 ? LocaleKeys.analysisRequested.translateText : ctrl.caseSelectionFilterValue == 2 ? LocaleKeys.ongoing.translateText : ctrl.caseSelectionFilterValue == 3 ? LocaleKeys.eligible.translateText : ctrl.caseSelectionFilterValue == 4 ? LocaleKeys.nonEligible.translateText : LocaleKeys.pendingLynerConversion.translateText} (${ctrl.caseList.length})"
                      .appCommonText(
                    weight: FontWeight.w500,
                    size: !isTablet ? 20 : 22,
                    color: Colors.black,
                  ),
                  6.space(),
                  ctrl.caseList.isEmpty
                      ? Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: LocaleKeys.caseNotFound.translateText
                                    .normalText(
                                  color: Colors.black,
                                  fontSize: !isTablet ? 20 : 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              75.h.space(),
                            ],
                          ),
                        )
                      : Expanded(
                          child: ListView.separated(
                            itemCount: ctrl.caseList.length,
                            padding: EdgeInsets.only(bottom: 150, top: 6),
                            itemBuilder: (BuildContext context, int index) {
                              CaseSelectionData? caseData =
                                  ctrl.caseList[index];
                              return AppCaseSelectionCard(
                                caseImagePath: caseData?.profile ?? "",
                                isUnread: 0,
                                isDraft: (caseData?.isDraft ?? false) ? 1 : 0,
                                isShowBottomWidget:
                                    ctrl.caseStatus == "Analysis Requested" &&
                                            (caseData?.isDraft ?? false) ||
                                        ctrl.caseStatus == "Eligible",
                                isEditCard: false,
                                title1: "Date of birth: ",
                                title2: "Patient request: ",
                                title3: "Treatment objectives: ",
                                data1: (caseData?.dateOfBirth?.isBlank ?? true)
                                    ? "-"
                                    : "${caseData!.dateOfBirth!.ddMMYYYYFormat()}",
                                data2: caseData?.patientRequest ?? "",
                                data3: caseData?.treatmentObjectives ?? "",
                                patientName:
                                    '${caseData?.firstName ?? ''} ${caseData?.lastName ?? ''}',
                                deleteOnTap: () {},
                                editOrSubmitOnTap: () {
                                  if (caseData?.isDraft == 0) {
                                    Get.toNamed(Routes.patientsDetailsScreen,
                                        arguments: [])?.then(
                                      (value) {
                                        // ctrl.getClinicListBySearchOrFilter();
                                        // ctrl.update();
                                      },
                                    );
                                  } else {
                                    Get.toNamed(Routes.addCaseSelection,
                                        arguments: {
                                          caseIdString: caseData?.id,
                                        });
                                  }
                                },
                              ).onClick(
                                () {},
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) => 12.space(),
                          ),
                        ),
                ],
              ).paddingOnly(left: 20, right: 20),
              ctrl.isLoading ? AppProgressView() : Container()
            ],
          );
        },
      ),
    );
  }
}
