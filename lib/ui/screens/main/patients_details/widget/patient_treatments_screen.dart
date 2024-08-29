import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/model/patient_treatment_model.dart';
import 'package:lynerdoctor/ui/screens/main/patients_details/patients_details_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';
import 'package:lynerdoctor/ui/widgets/app_patient_card.dart';

class PatientTreatmentsScreen extends StatelessWidget {
  PatientTreatmentsScreen({super.key});

  final PatientsDetailsController patientsDetailsController =
      Get.put(PatientsDetailsController());

  void showAddEditPatientTreatmentDialog(
      {bool isEdit = false, required BuildContext context}) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          actionsPadding: EdgeInsets.zero,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                18.space(),
                Align(
                  alignment: Alignment.center,
                  child: (isEdit
                          ? LocaleKeys.editPatientTreatments
                          : LocaleKeys.addPatientTreatments)
                      .translateText
                      .normalText(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                      ),
                ),
                12.space(),
                const Divider(height: 0, color: dividerColor, thickness: 1),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    12.space(),
                    LocaleKeys.nextVisit.translateText
                        .appCommonText(
                          weight: FontWeight.w400,
                          color: hintTextColor,
                          size: 14.sp,
                        )
                        .paddingOnly(bottom: 8.w),
                    CommonTextField(
                      hintText: LocaleKeys
                          .enterPatientTreatmentsNextVisit.translateText,
                      controller: patientsDetailsController.nextVisitController,
                      action: TextInputAction.next,
                    ),
                    16.space(),
                    LocaleKeys.treatmentNotes.translateText
                        .appCommonText(
                          weight: FontWeight.w400,
                          color: hintTextColor,
                          size: 14.sp,
                        )
                        .paddingOnly(bottom: 8.w),
                    CommonTextField(
                      maxLine: 3,
                      borderRadius: 20,
                      controller:
                          patientsDetailsController.treatmentNoteController,
                      hintText:
                          LocaleKeys.enterPatientTreatmentsNotes.translateText,
                      action: TextInputAction.done,
                    ),
                    20.space(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: AppButton(
                            text: LocaleKeys.cancel.translateText,
                            fontSize: 16.sp,
                            fontColor: pinkColor,
                            bgColor: deleteButtonColor,
                            radius: 100,
                            onTap: () {
                              Get.back();
                            },
                          ),
                        ),
                        20.space(),
                        Expanded(
                          child: AppButton(
                            text: (isEdit ? LocaleKeys.edit : LocaleKeys.add)
                                .translateText,
                            bgColor: primaryBrown,
                            fontSize: 16.sp,
                            fontColor: whiteColor,
                            radius: 100,
                            onTap: () async {
                              bool isAddOrEdit = await patientsDetailsController
                                  .addEditPatientTreatments(
                                      isEdit: isEdit, context: context);
                              if (isAddOrEdit) {
                                Navigator.of(context).pop();
                                patientsDetailsController
                                    .getPatientTreatmentsDetails();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    18.space(),
                  ],
                ).paddingSymmetric(horizontal: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GetBuilder<PatientsDetailsController>(
          builder: (PatientsDetailsController controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.space(),
            LocaleKeys.patientTreatments.translateText
                .normalText(fontWeight: FontWeight.w600),
            6.space(),
            controller.patientTreatmentModelList.isEmpty
                ? Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: "Treatment Not Found".normalText(
                        color: Colors.black,
                        fontSize: !isTablet ? 20 : 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.separated(
                      itemCount: controller.patientTreatmentModelList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 8, bottom: 100),
                      itemBuilder: (BuildContext context, int index) {
                        PatientTreatmentModel? patientTreatmentModel =
                            controller.patientTreatmentModelList[index];
                        return AppPatientCard(
                          isShowDeleteButtonOnBottom: true,
                          title1: LocaleKeys.dateCom,
                          title2: LocaleKeys.procedureCom,
                          title3: LocaleKeys.nextVisit,
                          data1: patientTreatmentModel?.treatmentDate
                                  ?.ddMMYYYYFormat() ??
                              '',
                          data2: patientTreatmentModel?.treatmentNotes ?? '',
                          data3: patientTreatmentModel?.nextVisit ?? '',
                          patientName: '',
                          deleteOnTap: () async {
                            controller.patientTreatmentId =
                                patientTreatmentModel?.patientTreatmentId ?? 0;
                            bool isDelete =
                                await controller.deletePatientTreatments();
                            if (isDelete) {
                              patientsDetailsController
                                  .getPatientTreatmentsDetails();
                            }
                          },
                          editOrSubmitOnTap: () {
                            controller.patientTreatmentId =
                                patientTreatmentModel?.patientTreatmentId ?? 0;
                            controller.nextVisitController.text =
                                patientTreatmentModel?.nextVisit ?? "";
                            controller.treatmentNoteController.text =
                                patientTreatmentModel?.treatmentNotes ?? "";
                            showAddEditPatientTreatmentDialog(
                                isEdit: true, context: context);
                          },
                          patientImagePath: '',
                          isShowTitle: false,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          12.space(),
                    ),
                  ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          patientsDetailsController.nextVisitController.clear();
          patientsDetailsController.treatmentNoteController.clear();
          showAddEditPatientTreatmentDialog(isEdit: false, context: context);
        },
        child: Icon(Icons.add, size: 40, color: whiteColor),
        heroTag: Object(),
        shape: CircleBorder(),
        backgroundColor: primaryBrown,
      ).paddingOnly(bottom: 30),
    );
  }
}
