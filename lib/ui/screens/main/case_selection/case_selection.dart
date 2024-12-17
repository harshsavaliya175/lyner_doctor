import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/case_selection/case_selection_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_bar.dart';
import 'package:lynerdoctor/ui/widgets/app_progress_view.dart';
import 'package:lynerdoctor/ui/widgets/patients_screen_filter_bottom_sheet.dart';

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
                            ctrl.patientList.clear();
                            Future.delayed(
                              Duration(seconds: 2),
                              () {
                                //     caseSelectionController
                                //     .getClinicListBySearchOrFilter(
                                //   isFromSearch: true,
                                // );
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
                              contentWidget: PatientsScreenFilterBottomSheet(
                                onTap: () {
                                  caseSelectionController
                                      .getClinicListBySearchOrFilter();
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
                  "${ctrl.caseSelectionFilterValue == 1 ? LocaleKeys.tasks.translateText : ctrl.caseSelectionFilterValue == 2 ? LocaleKeys.patients.translateText : LocaleKeys.archived.translateText} (${ctrl.patientList.length})"
                      .appCommonText(
                    weight: FontWeight.w500,
                    size: !isTablet ? 20 : 22,
                    color: Colors.black,
                  ),
                  6.space(),
                  ctrl.patientList.isEmpty
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
                      : Container(),
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
