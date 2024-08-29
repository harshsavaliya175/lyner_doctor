import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/model/patient_resposne_model.dart';
import 'package:lynerdoctor/ui/screens/main/patients/patients_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_patient_card.dart';
import 'package:lynerdoctor/ui/widgets/app_progress_view.dart';
import 'package:lynerdoctor/ui/widgets/doctor_patients_all_filter_bottom_sheet.dart';
import 'package:lynerdoctor/ui/widgets/patients_screen_filter_bottom_sheet.dart';

class PatientsScreen extends StatelessWidget {
  PatientsScreen({super.key});

  final PatientsController patientsController = Get.put(PatientsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        shadowColor: Colors.grey[300],
        elevation: 0.5,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  preferences.getString(SharedPreference.CLINIC_NAME) ?? '',
                  style: hintTextStyle(
                    size: !isTablet ? 20 : 23,
                    color: Colors.black,
                    weight: FontWeight.w700,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, size: 35),
              ],
            ).onClick(
              () {
                context.showAppBottomSheet(
                  contentWidget: DraggableScrollableSheet(
                    initialChildSize: 0.50,
                    minChildSize: 0.50,
                    maxChildSize: 0.95,
                    expand: false,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return DoctorPatientsAllFilterBottomSheet(
                        controller: scrollController,
                        onTap: () {
                          patientsController.getClinicListBySearchOrFilter();
                        },
                      );
                    },
                  ),
                );
              },
            ),
            GetBuilder<PatientsController>(
              builder: (PatientsController ctrl) {
                return Text(
                  ctrl.appbarSubTitle,
                  style: hintTextStyle(
                    size: !isTablet ? 14 : 17,
                    color: hintColor,
                    weight: FontWeight.w400,
                  ),
                );
              },
            ),
          ],
        ),
        titleSpacing: 20,
      ),
      body: GetBuilder<PatientsController>(
        builder: (PatientsController ctrl) {
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
                                patientsController
                                    .getClinicListBySearchOrFilter(
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
                              contentWidget: PatientsScreenFilterBottomSheet(
                                onTap: () {
                                  patientsController
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
                  "${ctrl.treatmentStatusFilterValue == 1 ? LocaleKeys.tasks.translateText : ctrl.treatmentStatusFilterValue == 2 ? LocaleKeys.patients.translateText : LocaleKeys.archived.translateText} (${ctrl.patientList.length})"
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
                                child: LocaleKeys.patientsNotFound.translateText
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
                            itemCount: ctrl.patientList.length,
                            padding: EdgeInsets.only(bottom: 150, top: 6),
                            itemBuilder: (BuildContext context, int index) {
                              PatientResponseData? patientData =
                                  ctrl.patientList[index];
                              return AppPatientCard(
                                isDraft: patientData?.isDraft ?? 0,
                                // isShowBottomWidget: patientData?.isDraft == 1,
                                isShowBottomWidget:
                                    ctrl.treatmentStatusFilterValue == 1,
                                isEditCard: false,
                                title1: LocaleKeys.statusCom,
                                title2: LocaleKeys.patientIdCom,
                                title3: LocaleKeys.productCom,
                                data1: getClinicItemStatus(patientData),
                                data2: patientData?.patientUniqueId ?? '',
                                data3: patientData?.caseName ?? '',
                                patientName:
                                    '${patientData?.firstName ?? ''} ${patientData?.lastName ?? ''}',
                                deleteOnTap: () {
                                  ctrl.deletePatient(
                                      patientData?.patientId.toString() ?? '');
                                },
                                editOrSubmitOnTap: () {
                                  if (patientData?.isDraft == 0) {
                                    Get.toNamed(Routes.patientsDetailsScreen,
                                        arguments: patientData?.patientId);
                                  } else {
                                    Get.toNamed(Routes.addPatientScreen,
                                        arguments: patientData?.patientId);
                                  }
                                },
                                patientImagePath:
                                    patientData?.patientProfile ?? '',
                              ).onClick(
                                () {
                                  if (patientData?.isDraft == 0 &&
                                      ctrl.treatmentStatusFilterValue != 1) {
                                    Get.toNamed(Routes.patientsDetailsScreen,
                                        arguments: patientData?.patientId);
                                  }
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) => 12.space(),
                          ),
                        ),
                ],
              ).paddingOnly(left: 20, right: 20),
              ctrl.isLoading
                  ? AppProgressView(
                      progressColor: Colors.black,
                    )
                  : Container()
            ],
          );
        },
      ),
    );
  }
}

String getClinicItemStatus(PatientResponseData? patientResponseData) {
  if (patientResponseData?.isDraft == 1) {
    return 'Brouillon';
  } else {
    switch (patientResponseData?.clinicItem) {
      case 'Lyner Working':
        return 'En cours de planification';
      case 'Delivered':
        return 'Expédié';
      case 'In-Production':
        return 'En production';
      case 'Review Modification':
        return 'Modification de la révision';
      case 'Lyner Review Modification':
        return "Modification de l'examen Lyner";
      case 'Approved By Doctor':
        return 'Approuvé par le Docteur';
      default:
        if ((patientResponseData?.clinicItem ?? '').contains('Review Plan')) {
          return (patientResponseData?.clinicItem ?? '')
              .replaceFirst('Review ', '');
        } else {
          return patientResponseData?.clinicItem ?? '';
        }
    }
  }
}
