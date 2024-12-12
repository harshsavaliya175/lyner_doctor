import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/add_case_selection/add_case_selection_controller.dart';
import 'package:lynerdoctor/ui/screens/main/add_case_selection/patient_information.dart';
import 'package:lynerdoctor/ui/screens/main/add_case_selection/patient_photography.dart';
import 'package:lynerdoctor/ui/widgets/app_progress_view.dart';

class AddCaseSelectionScreen extends StatelessWidget {
  const AddCaseSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: false,
        title: Text(
          LocaleKeys.caseSelection.translateText,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: Assets.fonts.maax,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: !isTablet ? 20 : 22,
          ),
        ),
        leading: Assets.icons.icBack
            .svg(
              height: 35,
              width: 35,
              fit: !isTablet ? BoxFit.scaleDown : BoxFit.fill,
            )
            .paddingOnly(
              left: 10,
              top: isTablet ? 22 : 2,
              bottom: isTablet ? 22 : 0,
              right: 10,
            )
            .onClick(
          () {
            Get.back();
          },
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[300],
        titleSpacing: 1,
        elevation: 0.5,
        scrolledUnderElevation: 0,
      ),
      body: GetBuilder<AddCaseSelectionController>(
        builder: (AddCaseSelectionController ctrl) {
          return Stack(
            children: [
              Container(
                color: appBgColor,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    10.space(),
                    Container(
                      width: Get.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // ctrl.goToStep(0);
                              ctrl.changeData(step: 0);
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: darkSkyColor,
                                      width: 1,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: !isTablet ? 20 : 25,
                                    height: !isTablet ? 20 : 25,
                                    decoration: BoxDecoration(
                                      color: primaryBrown,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: ctrl.isStepOneComplete
                                          ? Assets.icons.icSelect.svg(
                                              alignment: Alignment.center,
                                              width: 12,
                                            )
                                          : null,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Step 1',
                                  style: TextStyle(
                                    fontSize: !isTablet ? 12 : 16,
                                    fontFamily: Assets.fonts.maax,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: (!isTablet ? 120 : 150),
                            height: 2.0,
                            color: primaryBrown,
                          ).paddingOnly(top: 15),
                          GestureDetector(
                            onTap: () {
                              if (ctrl.patientInformationFormKey.currentState!
                                  .validate()) {
                                FocusScope.of(Get.context!).unfocus();
                                // ctrl.goToStep(1);
                                ctrl.changeData(
                                    step: 1, isStepOneComplete: true);
                              }
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: darkSkyColor,
                                      width: 1,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: !isTablet ? 20 : 25,
                                    height: !isTablet ? 20 : 25,
                                    decoration: BoxDecoration(
                                      color: primaryBrown,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Step 2',
                                  // Step number
                                  style: TextStyle(
                                    fontSize: !isTablet ? 12 : 16,
                                    fontFamily: Assets.fonts.maax,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    10.space(),
                    Expanded(
                      child: ctrl.currentStep == 0
                          ? PatientInformation()
                          : PatientPhotography(),
                    ),

                    // Expanded(
                    //   child: PageView(
                    //     physics: NeverScrollableScrollPhysics(),
                    //     controller: ctrl.pageController,
                    //     onPageChanged: (int index) {
                    //       ctrl.goToStep(index);
                    //     },
                    //     children: [
                    //       PatientInformation(),
                    //       PatientPhotography(),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              ctrl.isLoading
                  ? AppProgressView(progressColor: Colors.black)
                  : Container()
            ],
          );
        },
      ),
    );
  }
}
