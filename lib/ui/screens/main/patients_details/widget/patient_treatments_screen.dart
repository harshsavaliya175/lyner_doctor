import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';
import 'package:lynerdoctor/ui/widgets/app_patient_card.dart';

class PatientTreatmentsScreen extends StatelessWidget {
  const PatientTreatmentsScreen({super.key});

  void showAddPatientTreatmentDialog() {
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
                  child:
                      LocaleKeys.addPatientTreatments.translateText.normalText(
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
                      maxLine: 5,
                      hintText:
                          LocaleKeys.enterPatientTreatmentsNotes.translateText,
                      action: TextInputAction.done,
                      borderRadius: 20,
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
                            text: LocaleKeys.add.translateText,
                            bgColor: primaryBrown,
                            fontSize: 16.sp,
                            fontColor: whiteColor,
                            radius: 100,
                            onTap: () {},
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.space(),
          LocaleKeys.patientTreatments.translateText
              .normalText(fontWeight: FontWeight.w600),
          6.space(),
          Expanded(
            child: ListView.separated(
              itemCount: 3,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 8, bottom: 100),
              itemBuilder: (BuildContext context, int index) {
                return AppPatientCard(
                  title1: LocaleKeys.dateCom,
                  title2: LocaleKeys.procedureCom,
                  title3: LocaleKeys.nextVisit,
                  data1: "19/07/2024",
                  data2: "Autres Recommandations",
                  data3: "Lorem ipsum dolor sit amet,",
                  patientName: '',
                  deleteOnTap: () {},
                  editOrSubmitOnTap: () {},
                  patientImagePath: '',
                  isShowTitle: false,
                );
              },
              separatorBuilder: (BuildContext context, int index) => 12.space(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddPatientTreatmentDialog();
        },
        child: Icon(Icons.add, size: 40, color: whiteColor),
        heroTag: Object(),
        shape: CircleBorder(),
        backgroundColor: primaryBrown,
      ).paddingOnly(bottom: 30),
    );
  }
}
