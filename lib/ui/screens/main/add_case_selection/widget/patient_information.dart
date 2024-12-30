import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/add_case_selection/add_case_selection_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';
import 'package:lynerdoctor/ui/widgets/common_dialog.dart';

class PatientInformation extends StatelessWidget {
  const PatientInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCaseSelectionController>(
      builder: (AddCaseSelectionController ctrl) {
        return Form(
          key: ctrl.patientInformationFormKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    !isTablet ? 10.space() : 15.space(),
                    LocaleKeys.patientInformation.translateText.appCommonText(
                      align: TextAlign.start,
                      size: !isTablet ? 24 : 28,
                      weight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    !isTablet ? 5.space() : 10.space(),
                    AppTextField(
                      textEditingController: ctrl.firstNameController,
                      onChanged: (String value) {},
                      validator: (String value) {
                        if (value.isEmpty) {
                          return LocaleKeys.pleaseEnterFirstname.translateText;
                        }
                        ctrl.update();
                        return null;
                      },
                      textFieldPadding: EdgeInsets.zero,
                      keyboardType: TextInputType.text,
                      hintText: LocaleKeys.enterName.translateText,
                      labelText: LocaleKeys.firstName.translateText,
                      showPrefixIcon: false,
                    ),
                    15.space(),
                    AppTextField(
                      textEditingController: ctrl.lastNameController,
                      onChanged: (String value) {},
                      validator: (String value) {
                        if (value.isEmpty) {
                          return LocaleKeys.pleaseEnterLastName.translateText;
                        }
                        ctrl.update();
                        return null;
                      },
                      textFieldPadding: EdgeInsets.zero,
                      keyboardType: TextInputType.text,
                      // isError: ctrl.lastNameError,
                      hintText: LocaleKeys.enterName.translateText,
                      labelText: LocaleKeys.lastName.translateText,
                      showPrefixIcon: false,
                    ),
                    15.space(),
                    AppTextField(
                      textEditingController: ctrl.dateOfBirthController,
                      // onChanged: (value) {},
                      readOnly: true,
                      showCursor: false,
                      validator: (String value) {
                        if (value.isEmpty) {
                          ctrl.update();
                          return LocaleKeys
                              .pleaseSelectDateOfBirth.translateText;
                        }
                        ctrl.update();
                        return null;
                      },
                      onTap: () async {
                        ctrl.pickedDate = await datePickerDialog(
                          context: Get.context!,
                          isDateOfBirth: true,
                          currentTime: ctrl.pickedDate == null
                              ? ctrl.dateOfBirthController.text.isNotEmpty
                                  ? DateFormat(
                                      "dd/MM/yyyy",
                                      (preferences.getString(SharedPreference
                                                      .LANGUAGE_CODE) ??
                                                  '')
                                              .isNotEmpty
                                          ? preferences.getString(
                                              SharedPreference.LANGUAGE_CODE)
                                          : 'fr',
                                    ).parse(ctrl.dateOfBirthController.text)
                                  : null
                              : ctrl.pickedDate,
                        );
                        if (ctrl.pickedDate != null) {
                          ctrl.dateTextField = DateFormat(
                            'dd/MM/yyyy',
                            (preferences.getString(
                                            SharedPreference.LANGUAGE_CODE) ??
                                        '')
                                    .isNotEmpty
                                ? preferences
                                    .getString(SharedPreference.LANGUAGE_CODE)
                                : 'fr',
                          ).format(ctrl.pickedDate!);
                          ctrl.dateOfBirthController.text = ctrl.dateTextField!;
                          print(ctrl.dateOfBirthController.text);
                        }
                        ctrl.update();
                      },
                      textFieldPadding: EdgeInsets.zero,
                      keyboardType: TextInputType.text,
                      // isError: ctrl.emailError,
                      hintText: LocaleKeys.dateField.translateText,
                      labelText: LocaleKeys.dateOfBirth.translateText,
                      showPrefixIcon: false,
                    ),
                    15.space(),
                    AppTextField(
                      textEditingController: ctrl.patientRequestController,
                      onChanged: (String value) {},
                      validator: (String value) {
                        if (value.isEmpty) {
                          return LocaleKeys
                              .pleaseEnterPatientRequest.translateText;
                        }
                        ctrl.update();
                        return null;
                      },
                      textFieldPadding: EdgeInsets.zero,
                      keyboardType: TextInputType.text,
                      // isError: ctrl.lastNameError,
                      hintText:
                          LocaleKeys.enterPatientRequestText.translateText,
                      labelText: LocaleKeys.patientRequestText.translateText,
                      showPrefixIcon: false,
                    ),
                    15.space(),
                    AppTextField(
                      textEditingController: ctrl.treatmentGoalController,
                      onChanged: (String value) {},
                      validator: (String value) {
                        if (value.isEmpty) {
                          return LocaleKeys
                              .pleaseEnterTreatmentGoal.translateText;
                        }
                        ctrl.update();
                        return null;
                      },
                      textFieldPadding: EdgeInsets.zero,
                      keyboardType: TextInputType.text,
                      // isError: ctrl.lastNameError,
                      hintText: LocaleKeys.enterTreatmentGoal.translateText,
                      labelText: LocaleKeys.treatmentGoal.translateText,
                      showPrefixIcon: false,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: !isTablet ? 80 : 100,
                  width: Get.width,
                  decoration: BoxDecoration(color: appBgColor),
                  child: AppButton(
                    btnHeight: !isTablet ? 55 : 70,
                    text: LocaleKeys.continueText.translateText,
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (ctrl.patientInformationFormKey.currentState!
                          .validate()) {
                        FocusScope.of(Get.context!).unfocus();

                        if (ctrl.caseId == null) {
                          ctrl.addCaseInformation().then(
                            (void value) {
                              ctrl.changeData(step: 1, isStepOneComplete: true);
                            },
                          );
                        } else {
                          ctrl.editCaseInformation().then(
                            (void value) {
                              ctrl.changeData(step: 1, isStepOneComplete: true);
                            },
                          );
                        }
                      }
                    },
                    boxShadow: [],
                    radius: 40,
                    fontSize: !isTablet ? 20 : 25,
                    bgColor: primaryBrown,
                    fontColor: Colors.white,
                  ).paddingOnly(top: 10, bottom: 10),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
