import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/patients_details/patients_details_controller.dart';
import 'package:lynerdoctor/ui/screens/main/patients_details/widget/comment_screen.dart';
import 'package:lynerdoctor/ui/screens/main/patients_details/widget/information_screen.dart';
import 'package:lynerdoctor/ui/screens/main/patients_details/widget/patient_treatments_screen.dart';
import 'package:lynerdoctor/ui/screens/main/patients_details/widget/prescription_screen.dart';
import 'package:lynerdoctor/ui/widgets/app_bar.dart';
import 'package:lynerdoctor/ui/widgets/app_progress_view.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PatientsDetailsScreen extends StatefulWidget {
  PatientsDetailsScreen({super.key});

  @override
  State<PatientsDetailsScreen> createState() => _PatientsDetailsScreenState();
}

class _PatientsDetailsScreenState extends State<PatientsDetailsScreen> {
  final PatientsDetailsController ctrl = Get.put(PatientsDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: appbarWithIcons(
        centerTitle: false,
        title: Text(
          LocaleKeys.view3DSimulation.translateText,
          style: TextStyle(
            fontFamily: Assets.fonts.maax,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: 20,
          ),
        ),




        backgroundColor: Colors.white,
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
                right: 10)
            .onClick(() {
          Get.back();
        }),
        elevation: 0.5,
        rightIcon: Obx(() => ctrl.isShowLink.value
            ? Assets.icons.icTeethWithScreen
                .svg(width: !isTablet ? 55 : 45, height: !isTablet ? 55 : 45)
                .paddingOnly(right: 15)
                .onClick(
                () {
                  Get.toNamed(Routes.treatmentPlanning);
                },
              )
            : const SizedBox()),
      ),
      body: GetBuilder<PatientsDetailsController>(
        builder: (PatientsDetailsController controller) {
          return Stack(
            children: [
              Column(
                children: [
                  24.space(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: isTablet ? 70 : 50,
                          alignment: Alignment.center,
                          child: Assets.icons.icPersonWithComment.svg(
                            height: isTablet ? 30 : 24,
                            width: isTablet ? 30 : 24,
                            colorFilter: ColorFilter.mode(
                              controller.selectedScreen == 0
                                  ? Colors.white
                                  : coolFourColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: controller.selectedScreen == 0
                                ? primaryBrown
                                : Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            border: controller.selectedScreen == 0
                                ? null
                                : Border.all(color: skyColor, width: 1),
                          ),
                        ).onClick(() {
                          controller.getPatientCommentsDetails();
                          controller.changeData(selectedIndex: 0);
                        }),
                      ),
                      11.space(),
                      Expanded(
                        child: Container(
                          height: isTablet ? 70 : 50,
                          alignment: Alignment.center,
                          child: Assets.icons.icPerson.svg(
                            height: isTablet ? 30 : 24,
                            width: isTablet ? 30 : 24,
                            colorFilter: ColorFilter.mode(
                              controller.selectedScreen == 1
                                  ? Colors.white
                                  : coolFourColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: controller.selectedScreen == 1
                                ? primaryBrown
                                : Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            border: controller.selectedScreen == 1
                                ? null
                                : Border.all(color: skyColor, width: 1),
                          ),
                        ).onClick(() {
                          controller.getPatientInformationDetails();
                          controller.changeData(selectedIndex: 1);
                        }),
                      ),
                      11.space(),
                      Expanded(
                        child: Container(
                          height: isTablet ? 70 : 50,
                          alignment: Alignment.center,
                          child: Assets.icons.icFile.svg(
                            height: isTablet ? 30 : 24,
                            width: isTablet ? 30 : 24,
                            colorFilter: ColorFilter.mode(
                              controller.selectedScreen == 2
                                  ? Colors.white
                                  : coolFourColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: controller.selectedScreen == 2
                                ? primaryBrown
                                : Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            border: controller.selectedScreen == 2
                                ? null
                                : Border.all(color: skyColor, width: 1),
                          ),
                        ).onClick(() {
                          controller.getPatientPrescriptionDetails();
                          controller.changeData(selectedIndex: 2);
                        }),
                      ),
                      11.space(),
                      Expanded(
                        child: Container(
                          height: isTablet ? 70 : 50,
                          alignment: Alignment.center,
                          child: Assets.icons.icPatientTreatments.svg(
                            height: isTablet ? 30 : 24,
                            width: isTablet ? 30 : 24,
                            colorFilter: ColorFilter.mode(
                              controller.selectedScreen == 3
                                  ? Colors.white
                                  : coolFourColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: controller.selectedScreen == 3
                                ? primaryBrown
                                : Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            border: controller.selectedScreen == 3
                                ? null
                                : Border.all(color: skyColor, width: 1),
                          ),
                        ).onClick(() {
                          controller.getPatientTreatmentsDetails();
                          controller.changeData(selectedIndex: 3);
                        }),
                      ),
                    ],
                  ),
                  10.space(),
                  Expanded(
                    child: controller.selectedScreen == 0
                        ? CommentScreen()
                        : controller.selectedScreen == 1
                            ? InformationScreen()
                            : controller.selectedScreen == 2
                                ? PrescriptionScreen()
                                : PatientTreatmentsScreen(),
                  ),
                ],
              ).paddingSymmetric(horizontal: 20),
              controller.isLoading
                  ? AppProgressView(progressColor: Colors.black)
                  : Container(),
              Visibility(
                visible: controller.isCommentFileLoading,
                child: Container(
                  width: double.infinity,
                  height: Get.height / 0,
                  color: Colors.white.withOpacity(0.4),
                  child: CircularPercentIndicator(
                    radius: 40,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: primaryBrown,
                    backgroundColor: Colors.white,
                    lineWidth: 12,
                    percent: controller.uploadProgress,
                    center: Text(
                      '${(controller.uploadProgress * 100).toStringAsFixed(0)}%',
                      style: TextStyle(
                        color: primaryBrown,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
