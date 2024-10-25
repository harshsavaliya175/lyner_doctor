import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/home_image.dart';
import 'package:lynerdoctor/core/utils/image_picker.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';
import 'package:lynerdoctor/core/utils/step_indicator.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/model/clinic_billing_model.dart';
import 'package:lynerdoctor/model/clinic_location_model.dart';
import 'package:lynerdoctor/model/doctor_model.dart';
import 'package:lynerdoctor/model/productListModel.dart';
import 'package:lynerdoctor/model/selection_item.dart';
import 'package:lynerdoctor/ui/screens/main/add_patient/add_patient_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';
import 'package:lynerdoctor/ui/widgets/app_progress_view.dart';
import 'package:lynerdoctor/ui/widgets/common_dialog.dart';
import 'package:lynerdoctor/ui/widgets/custom_radio_button.dart';

class AddPatientScreen extends StatelessWidget {
  AddPatientScreen({super.key});

  final AddPatientController controller = Get.put(AddPatientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: false,
        title: Text(
          LocaleKeys.addNewPatient.translateText,
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
      body: GetBuilder<AddPatientController>(
        builder: (AddPatientController ctrl) {
          return Stack(
            children: [
              Container(
                color: appBgColor,
                child: Column(
                  children: [
                    10.space(),
                    CommonStepIndicator(
                      totalSteps: 4,
                      stepErrors: ctrl.stepErrors,
                      currentStep: ctrl.currentStep,
                      onStepTapped: (int index) async {
                        if (index < ctrl.currentStep) {
                          if (ctrl.patientInformationFormKey.currentState !=
                              null) {
                            if (!ctrl.patientInformationFormKey.currentState!
                                .validate()) {
                              ctrl.stepErrors[1] = true;
                            }
                          }
                          if (ctrl.firstNameController.text.isNotEmpty ||
                              ctrl.lastNameController.text.isNotEmpty) {
                            if (!ctrl.validateUploadPhotoFiles()) {
                              ctrl.stepErrors[2] = true;
                            } else {
                              ctrl.stepErrors[2] = false;
                            }
                            if (!ctrl.validateArcadeFields()) {
                              ctrl.stepErrors[3] = true;
                            } else {
                              ctrl.stepErrors[3] = false;
                            }
                          }
                          ctrl.goToStep(index);
                          ctrl.checkStepErrors();
                        } else {
                          switch (index) {
                            case 1:
                              if (ctrl.isSelectedProductPlan) {
                                ctrl.stepErrors[0] = false;
                                ctrl.goToStep(index);
                              } else {
                                ctrl.stepErrors[0] = true;
                                showAppSnackBar(LocaleKeys
                                    .pleaseSelectAnyProductPlanToGoNextStep
                                    .translateText);
                              }
                              break;
                            case 2:
                              if (ctrl.firstNameController.text.isEmpty ||
                                  ctrl.lastNameController.text.isEmpty) {
                                if (ctrl.currentStep == 1) {
                                  showAppSnackBar(LocaleKeys
                                      .pleaseEnterFirstnameAndLastname
                                      .translateText);
                                }
                                return;
                              } else {
                                if (ctrl.patientData == null) {
                                  await ctrl.addNewPatient();
                                }
                              }
                              if (ctrl.patientInformationFormKey.currentState !=
                                  null) {
                                if (!ctrl
                                    .patientInformationFormKey.currentState!
                                    .validate()) {
                                  ctrl.stepErrors[1] = true;
                                } else {
                                  ctrl.stepErrors[1] = false;
                                }
                              }
                              if (!ctrl.validateUploadPhotoFiles()) {
                                ctrl.stepErrors[2] = true;
                              } else {
                                if (!ctrl.validateArcadeFields()) {
                                  ctrl.stepErrors[3] = true;
                                } else {
                                  ctrl.stepErrors[3] = false;
                                }
                                ctrl.stepErrors[2] = false;
                              }

                              ctrl.goToStep(index);
                              break;
                            case 3:
                              if (ctrl.firstNameController.text.isEmpty ||
                                  ctrl.lastNameController.text.isEmpty) {
                                if (ctrl.currentStep == 1) {
                                  showAppSnackBar(LocaleKeys
                                      .pleaseEnterFirstnameAndLastname
                                      .translateText);
                                }
                                return;
                              } else {
                                if (ctrl.patientData == null) {
                                  await ctrl.addNewPatient();
                                }
                              }
                              if (ctrl.patientInformationFormKey.currentState !=
                                  null) {
                                if (!ctrl
                                    .patientInformationFormKey.currentState!
                                    .validate()) {
                                  ctrl.stepErrors[1] = true;
                                } else {
                                  ctrl.stepErrors[1] = false;
                                }
                              }
                              if (!ctrl.validateUploadPhotoFiles()) {
                                ctrl.stepErrors[2] = true;
                              } else {
                                ctrl.stepErrors[2] = false;
                              }
                              if (!ctrl.validateArcadeFields()) {
                                ctrl.stepErrors[3] = true;
                              } else {
                                ctrl.stepErrors[3] = false;
                              }
                              ctrl.goToStep(index);
                              break;
                            default:
                              ctrl.goToStep(index);
                          }
                          ctrl.checkStepErrors();
                        }
                      },
                    ),
                    10.space(),
                    Expanded(
                      child: PageView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: ctrl.pageController,
                        onPageChanged: (int index) {
                          ctrl.goToStep(index);
                          // if (ctrl.currentStep == 2) {
                          //   SystemChrome.setPreferredOrientations([
                          //     DeviceOrientation.portraitUp,
                          //   ]);
                          // } else {
                          //   SystemChrome.setPreferredOrientations([
                          //     DeviceOrientation.portraitUp,
                          //     DeviceOrientation.portraitDown,
                          //     DeviceOrientation.landscapeLeft,
                          //     DeviceOrientation.landscapeRight,
                          //   ]);
                          // }
                        },
                        children: [
                          chooseTheProduct(ctrl),
                          patientInformation(ctrl),
                          uploadPhotographs(ctrl, false),
                          prescriptionScreen(ctrl),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GetBuilder<AddPatientController>(
                builder: (AddPatientController controller) {
                  return controller.isLoading
                      ? AppProgressView(progressColor: Colors.black)
                      : Container();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget chooseTheProduct(AddPatientController ctrl) {
  return Stack(
    children: [
      ListView(
        children: [
          5.space(),
          LocaleKeys.chooseTheProduct.translateText.appCommonText(
            align: TextAlign.start,
            size: !isTablet ? 24 : 27,
            weight: FontWeight.w500,
            color: Colors.black,
          ),
          5.space(),
          ListView.builder(
            itemCount: ctrl.products.length,
            padding: const EdgeInsets.only(bottom: 10),
            physics: const PageScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final ProductListData product = ctrl.products[index];
              final bool isSelectedProductPlan =
                  ctrl.selectedProduct?.toothCaseId == product.toothCaseId;
              return GestureDetector(
                onTap: () {
                  ctrl.selectProduct(product);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(13)),
                      border: Border.all(
                        color: skyColor,
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: !isTablet ? 55 : 70,
                        decoration: BoxDecoration(
                          color: lightBrown,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(13),
                              topLeft: Radius.circular(13)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            product.caseName.appCommonText(
                                weight: FontWeight.w500,
                                size: !isTablet ? 20 : 24),
                            Container(
                              alignment: Alignment.center,
                              width: !isTablet ? 22.0 : 24.0,
                              height: !isTablet ? 22.0 : 24.0,
                              decoration: BoxDecoration(
                                color: isSelectedProductPlan
                                    ? primaryBrown
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: primaryBrown, width: 1),
                              ),
                              child: Center(
                                child: isSelectedProductPlan
                                    ? Assets.icons.icSelect.svg(
                                        alignment: Alignment.center,
                                        width: !isTablet ? 12 : 15)
                                    : null,
                              ),
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 15),
                      ),
                      11.space(),
                      product.caseSteps
                          .appCommonText(
                              weight: FontWeight.w500,
                              size: !isTablet ? 16 : 20,
                              align: TextAlign.start)
                          .paddingSymmetric(horizontal: 15),
                      10.space(),
                      product.caseDesc
                          .appCommonText(
                              weight: FontWeight.w300,
                              size: !isTablet ? 16 : 20,
                              color: hintColor,
                              maxLine: 2,
                              overflow: TextOverflow.ellipsis,
                              align: TextAlign.start)
                          .paddingSymmetric(horizontal: 15),
                      12.space(),
                      product.casePrice
                          .appCommonText(
                              weight: FontWeight.w500,
                              size: !isTablet ? 16 : 20)
                          .paddingSymmetric(horizontal: 15),
                      13.space(),
                      Container(
                        height: !isTablet ? 55 : 70,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color:
                              isSelectedProductPlan ? primaryBrown : skyColor,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(13),
                              bottomLeft: Radius.circular(13)),
                        ),
                        child: Center(
                          child: (isSelectedProductPlan
                                  ? LocaleKeys.selected.translateText
                                  : LocaleKeys.notSelected.translateText)
                              .appCommonText(
                                  weight: FontWeight.w500,
                                  size: !isTablet ? 20 : 22,
                                  align: TextAlign.center,
                                  color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ).paddingOnly(top: 10, bottom: 10),
              );
            },
          ),
          90.space(),
        ],
      ).paddingSymmetric(horizontal: 15),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: !isTablet ? 80 : 100,
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: AppButton(
            btnHeight: !isTablet ? 55 : 70,
            text: LocaleKeys.next.translateText,
            onTap: () {
              if (ctrl.isSelectedProductPlan) {
                ctrl.goToStep(1);
              } else {
                showAppSnackBar(LocaleKeys
                    .pleaseSelectAnyProductPlanToContinue.translateText);
              }
            },
            boxShadow: [],
            radius: !isTablet ? 25 : 40,
            fontSize: !isTablet ? 20 : 23,
            bgColor: primaryBrown,
            fontColor: Colors.white,
          ).paddingOnly(top: 10, bottom: 10).paddingSymmetric(horizontal: 15),
        ),
      ),
    ],
  );
}

Widget patientInformation(AddPatientController ctrl) {
  return Stack(
    children: [
      Form(
        key: ctrl.patientInformationFormKey,
        child: ListView(
          children: [
            !isTablet ? 5.space() : 10.space(),
            LocaleKeys.patientInformation.translateText.appCommonText(
              align: TextAlign.start,
              size: !isTablet ? 24 : 28,
              weight: FontWeight.w500,
              color: Colors.black,
            ),
            !isTablet ? 10.space() : 15.space(),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    textEditingController: ctrl.firstNameController,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value.isEmpty) {
                        ctrl.firstNameError = true;
                        ctrl.update();
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
                ),
                10.space(),
                Expanded(
                  child: AppTextField(
                    textEditingController: ctrl.lastNameController,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value.isEmpty) {
                        ctrl.lastNameError = true;
                        ctrl.update();
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
                ),
              ],
            ),
            15.space(),
            AppTextField(
              textEditingController: ctrl.emailController,
              onChanged: (String value) {},
              validator: (String value) {},
              textFieldPadding: EdgeInsets.zero,
              keyboardType: TextInputType.text,
              // isError: ctrl.emailError,
              hintText: LocaleKeys.enterEmailAddress.translateText,
              labelText: LocaleKeys.emailAddress.translateText,
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
                  ctrl.emailError = true;
                  ctrl.update();
                  return LocaleKeys.pleaseSelectDateOfBirth.translateText;
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
                              (preferences.getString(
                                              SharedPreference.LANGUAGE_CODE) ??
                                          '')
                                      .isNotEmpty
                                  ? preferences
                                      .getString(SharedPreference.LANGUAGE_CODE)
                                  : 'fr',
                            ).parse(ctrl.dateOfBirthController.text)
                          : null
                      : ctrl.pickedDate,
                );
                if (ctrl.pickedDate != null) {
                  ctrl.dateTextField = DateFormat(
                    'dd/MM/yyyy',
                    (preferences.getString(SharedPreference.LANGUAGE_CODE) ??
                                '')
                            .isNotEmpty
                        ? preferences.getString(SharedPreference.LANGUAGE_CODE)
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
            // "Date of Birth".appCommonText(color: blackColor),
            15.space(),
            preferences.getString(SharedPreference.LOGIN_TYPE) ==
                    SharedPreference.LOGIN_TYPE_CLINIC
                ? AppTextField(
                    textEditingController: ctrl.doctorController,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value.isEmpty) {
                        ctrl.emailError = true;
                        ctrl.update();
                        return LocaleKeys.pleaseSelectDoctor.translateText;
                      }
                      ctrl.update();
                      return null;
                    },
                    readOnly: true,
                    showCursor: false,
                    onTap: () {
                      ctrl.showDoctorDropDown = !ctrl.showDoctorDropDown;
                      ctrl.update();
                    },
                    textFieldPadding: EdgeInsets.zero,
                    keyboardType: TextInputType.text,
                    // isError: ctrl.emailError,
                    hintText: LocaleKeys.select.translateText,
                    labelText: LocaleKeys.doctor.translateText,
                    showPrefixWidget: Assets.icons.icDown
                        .svg(
                          height: 10,
                          width: 10,
                        )
                        .paddingOnly(left: 15, right: 15),
                    showPrefixIcon: true,
                  )
                : Container(),
            // 15.space(),
            Visibility(
              visible: ctrl.showDoctorDropDown,
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
                  separatorBuilder: (BuildContext context, int index) =>
                      DottedBorder(
                    borderType: BorderType.RRect,
                    color: primaryBrown,
                    padding: EdgeInsets.zero,
                    radius: const Radius.circular(35),
                    dashPattern: const [5, 5, 5, 5],
                    child: Container(),
                  ),
                  itemBuilder: (BuildContext builder, int index) {
                    DoctorData? data = ctrl.doctorDataList[
                        index]; // Display filtered data when search is not empty
                    return InkWell(
                      onTap: () {
                        print("onTap : $index");
                        ctrl.showDoctorDropDown = !ctrl.showDoctorDropDown;
                        ctrl.doctorController.text =
                            '${data?.firstName} ${data?.lastName}';
                        ctrl.selectedDoctorData = data;
                        print(ctrl.selectedDoctorData);
                        ctrl.update();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: '${data?.firstName} ${data?.lastName}'
                                .appCommonText(
                              color: Colors.black,
                              maxLine: 1,
                              align: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              weight: FontWeight.w400,
                              size: !isTablet ? 15 : 18,
                            ),
                          ),
                          if (ctrl.doctorController.text.contains(
                              '${data?.firstName} ${data?.lastName}')) ...[
                            Assets.icons.icSelectArrow.svg(
                              colorFilter: ColorFilter.mode(
                                primaryBrown,
                                BlendMode.srcIn,
                              ),
                            ),
                          ] else ...[
                            const SizedBox.shrink(),
                          ]
                        ],
                      ).paddingOnly(left: 20, right: 20, top: 10, bottom: 10),
                    );
                  },
                  itemCount: ctrl.doctorDataList.length,
                ).paddingOnly(top: 5, bottom: 5),
              ).paddingOnly(top: 15),
            ),
            15.space(),
            AppTextField(
              textEditingController: ctrl.billingAddressController,
              onChanged: (value) {},
              validator: (value) {
                if (value.isEmpty) {
                  ctrl.emailError = true;
                  ctrl.update();
                  return LocaleKeys.pleaseSelectBillingAddress.translateText;
                }
                ctrl.update();
                return null;
              },
              readOnly: true,
              showCursor: false,
              onTap: () {
                ctrl.showBillingDropDown = !ctrl.showBillingDropDown;
                ctrl.update();
              },
              textFieldPadding: EdgeInsets.zero,
              keyboardType: TextInputType.text,
              // isError: ctrl.emailError,
              hintText: LocaleKeys.select.translateText,
              labelText: LocaleKeys.billingAddress.translateText,
              showPrefixWidget: Assets.icons.icDown
                  .svg(
                    height: 10,
                    width: 10,
                  )
                  .paddingOnly(left: 15, right: 15),
              showPrefixIcon: true,
            ),
            Visibility(
              visible: ctrl.showBillingDropDown,
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
                  separatorBuilder: (BuildContext context, int index) =>
                      DottedBorder(
                    borderType: BorderType.RRect,
                    color: primaryBrown,
                    padding: EdgeInsets.zero,
                    radius: const Radius.circular(35),
                    dashPattern: const [5, 5, 5, 5],
                    child: Container(),
                  ),
                  itemBuilder: (BuildContext builder, int index) {
                    ClinicBillingData? data = ctrl.clinicBillingList[
                        index]; // Display filtered data when search is not empty
                    return InkWell(
                      onTap: () {
                        print("onTap : $index");
                        ctrl.showBillingDropDown = !ctrl.showBillingDropDown;
                        ctrl.billingAddressController.text =
                            '${data?.billingName}';
                        ctrl.selectedClinicBillingData = data;
                        print(ctrl.selectedClinicBillingData);
                        ctrl.update();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: '${data?.billingName}'.appCommonText(
                              color: Colors.black,
                              maxLine: 1,
                              align: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              weight: FontWeight.w400,
                              size: !isTablet ? 15 : 18,
                            ),
                          ),
                          if (ctrl.billingAddressController.text
                              .contains('${data?.billingName}')) ...[
                            Assets.icons.icSelectArrow.svg(
                                colorFilter: ColorFilter.mode(
                              primaryBrown,
                              BlendMode.srcIn,
                            )),
                          ] else ...[
                            const SizedBox.shrink(),
                          ]
                        ],
                      ).paddingOnly(left: 20, right: 20, top: 10, bottom: 10),
                    );
                  },
                  itemCount: ctrl.clinicBillingList.length,
                ).paddingOnly(top: 5, bottom: 5),
              ).paddingOnly(top: 15),
            ),
            15.space(),
            AppTextField(
              textEditingController: ctrl.deliveryAddressController,
              onChanged: (String value) {},
              validator: (String value) {
                if (value.isEmpty) {
                  ctrl.emailError = true;
                  ctrl.update();
                  return LocaleKeys.pleaseSelectDeliveryAddress.translateText;
                }
                ctrl.update();
                return null;
              },
              onTap: () {
                ctrl.showDeliveryDropDown = !ctrl.showDeliveryDropDown;
                ctrl.update();
              },
              readOnly: true,
              showCursor: false,
              textFieldPadding: EdgeInsets.zero,
              keyboardType: TextInputType.text,
              // isError: ctrl.emailError,
              hintText: LocaleKeys.select.translateText,
              labelText: LocaleKeys.deliveryAddress.translateText,
              showPrefixWidget: Assets.icons.icDown
                  .svg(
                    height: 10,
                    width: 10,
                  )
                  .paddingOnly(left: 15, right: 15),
              showPrefixIcon: true,
            ),
            Visibility(
              visible: ctrl.showDeliveryDropDown,
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
                  separatorBuilder: (BuildContext context, int index) =>
                      DottedBorder(
                    borderType: BorderType.RRect,
                    color: primaryBrown,
                    padding: EdgeInsets.zero,
                    radius: const Radius.circular(35),
                    dashPattern: const [5, 5, 5, 5],
                    child: Container(),
                  ),
                  itemBuilder: (BuildContext builder, int index) {
                    ClinicLocation? data = ctrl.clinicDeliveryLocationList[
                        index]; // Display filtered data when search is not empty
                    return InkWell(
                      onTap: () {
                        print("onTap : $index");
                        ctrl.showDeliveryDropDown = !ctrl.showDeliveryDropDown;
                        ctrl.deliveryAddressController.text =
                            '${data?.address}';
                        ctrl.selectedClinicDeliveryData = data;
                        print(ctrl.selectedClinicDeliveryData);
                        ctrl.update();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: '${data?.address}'.appCommonText(
                              color: Colors.black,
                              maxLine: 1,
                              align: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              weight: FontWeight.w400,
                              size: !isTablet ? 15 : 18,
                            ),
                          ),
                          if (ctrl.deliveryAddressController.text
                              .contains('${data?.address}')) ...[
                            Assets.icons.icSelectArrow.svg(
                                colorFilter: ColorFilter.mode(
                              primaryBrown,
                              BlendMode.srcIn,
                            )),
                          ] else ...[
                            const SizedBox.shrink(),
                          ]
                        ],
                      ).paddingOnly(left: 20, right: 20, top: 10, bottom: 10),
                    );
                  },
                  itemCount: ctrl.clinicDeliveryLocationList.length,
                ).paddingOnly(top: 5, bottom: 5),
              ).paddingOnly(top: 15),
            ),
            200.space(),
          ],
        ).paddingSymmetric(horizontal: 15),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: !isTablet ? 80 : 100,
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: AppButton(
            btnHeight: !isTablet ? 55 : 70,
            text: LocaleKeys.next.translateText,
            onTap: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              if (ctrl.patientInformationFormKey.currentState!.validate()) {
                FocusScope.of(Get.context!).unfocus();
                // Get.offAllNamed(Routes.home);
                if (ctrl.patientData == null) {
                  await ctrl.addNewPatient();
                }
                await ctrl.goToStep(2);
              }
            },
            boxShadow: [],
            radius: 40,
            fontSize: !isTablet ? 20 : 25,
            bgColor: primaryBrown,
            fontColor: Colors.white,
          ).paddingOnly(top: 10, bottom: 10).paddingSymmetric(horizontal: 15),
        ),
      ),
    ],
  );
}

Widget uploadPhotographs(AddPatientController ctrl, bool refineScreen) {
  return Stack(
    children: [
      ListView(
        children: [
          5.space(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LocaleKeys.uploadPhotographs.translateText.appCommonText(
                      align: TextAlign.start,
                      size: !isTablet ? 24 : 27,
                      maxLine: 2,
                      overflow: TextOverflow.ellipsis,
                      weight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    (LocaleKeys.jpgAndHeifFormat.translateText).appCommonText(
                      align: TextAlign.start,
                      size: !isTablet ? 16 : 19,
                      maxLine: 2,
                      overflow: TextOverflow.ellipsis,
                      weight: FontWeight.w400,
                      color: hintStepColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          !isTablet ? 10.space() : 15.space(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              photoCardWidget(
                image: Assets.images.imgProfile.path,
                title: LocaleKeys.profile.translateText,
                urlImage: refineScreen
                    ? ctrl.refinementData?.profile ?? ''
                    : ctrl.patientData?.patientPhoto?.gauche ?? '',
                urlPath: "patient_gauche",
                fileImage: ctrl.profileImageFile ?? File(''),
                onTap: () {
                  imageUploadUtils.faceDetectingOpenImageChooser(
                    context: Get.context!,
                    imageCount: 0,
                    title: LocaleKeys.profile.translateText,
                    onImageChose: (File? file) async {
                      // ctrl.cuisinePhoto?[0] =(file!);
                      ctrl.profileImageFile = file!;
                      if (refineScreen) {
                        ctrl.editPatientRefinementDetails(
                            paramName: 'patient_gauche', file: file);
                      } else {
                        ctrl.uploadPatientSingleImage(
                            paramName: 'patient_gauche', file: file);
                      }
                      ctrl.update();
                    },
                  );
                },
              ),
              10.space(),
              photoCardWidget(
                image: Assets.images.imgFace.path,
                title: LocaleKeys.face.translateText,
                urlImage: refineScreen == true
                    ? ctrl.refinementData?.face ?? ''
                    : ctrl.patientData?.patientPhoto?.face ?? '',
                urlPath: "patient_face",
                fileImage: ctrl.faceImageFile ?? File(''),
                onTap: () {
                  imageUploadUtils.faceDetectingOpenImageChooser(
                    context: Get.context!,
                    imageCount: 1,
                    title: LocaleKeys.face.translateText,
                    onImageChose: (File? file) async {
                      // ctrl.cuisinePhoto?[0] =(file!);
                      ctrl.faceImageFile = file!;
                      if (refineScreen) {
                        ctrl.editPatientRefinementDetails(
                            paramName: 'patient_face', file: file);
                      } else {
                        ctrl.uploadPatientSingleImage(
                            paramName: 'patient_face', file: file);
                      }
                      ctrl.update();
                    },
                  );
                },
              ),
              10.space(),
              photoCardWidget(
                image: Assets.images.imgSmile.path,
                title: LocaleKeys.smile.translateText,
                urlImage: refineScreen == true
                    ? ctrl.refinementData?.smile ?? ''
                    : ctrl.patientData?.patientPhoto?.sourire ?? '',
                urlPath: "patient_sourire",
                fileImage: ctrl.smileImageFile ?? File(''),
                onTap: () {
                  imageUploadUtils.faceDetectingOpenImageChooser(
                    context: Get.context!,
                    imageCount: 2,
                    title: LocaleKeys.smile.translateText,
                    onImageChose: (File? file) async {
                      // ctrl.cuisinePhoto?[0] =(file!);
                      ctrl.smileImageFile = file!;
                      if (refineScreen) {
                        ctrl.editPatientRefinementDetails(
                            paramName: 'patient_sourire', file: file);
                      } else {
                        ctrl.uploadPatientSingleImage(
                            paramName: 'patient_sourire', file: file);
                      }
                      ctrl.update();
                    },
                  );
                },
              ),
            ],
          ),
          5.space(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              photoCardWidget(
                image: Assets.images.imgIntraMax.path,
                title: LocaleKeys.intraMax.translateText,
                urlImage: refineScreen == true
                    ? ctrl.refinementData?.intraMax ?? ''
                    : ctrl.patientData?.patientPhoto?.interMax ?? '',
                urlPath: "patient_intra_max",
                fileImage: ctrl.intraMaxImageFile ?? File(''),
                onTap: () {
                  imageUploadUtils.faceDetectingOpenImageChooser(
                    context: Get.context!,
                    imageCount: 3,
                    title: LocaleKeys.intraMax.translateText,
                    onImageChose: (File? file) async {
                      // ctrl.cuisinePhoto?[0] =(file!);
                      ctrl.intraMaxImageFile = file!;
                      if (refineScreen) {
                        ctrl.editPatientRefinementDetails(
                            paramName: 'patient_intra_max', file: file);
                      } else {
                        ctrl.uploadPatientSingleImage(
                            paramName: 'patient_intra_max', file: file);
                      }
                      ctrl.update();
                    },
                  );
                  // imageUploadUtils.openImageChooser(
                  //   context: Get.context!,
                  //   onImageChose: (File? file) async {
                  //     // ctrl.cuisinePhoto?[0] =(file!);
                  //     ctrl.intraMaxImageFile = file!;
                  //     ctrl.uploadPatientSingleImage(
                  //         paramName: 'patient_intra_max', file: file);
                  //     ctrl.update();
                  //   },
                  // );
                },
              ),
              10.space(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        HomeImage.assetImage(
                          path: Assets.images.imgBlackCard.path,
                          height: !isTablet ? 123 : 200,
                          shape: BoxShape.rectangle,
                          width: !isTablet ? 123 : 200,
                        ),
                        Icon(
                          Icons.camera_alt,
                          color: primaryBrown,
                          size: !isTablet ? 30 : 50,
                        ),
                      ],
                    ),
                  ],
                ).onClick(
                  () {
                    Get.toNamed(Routes.faceDetectorView)?.then(
                      (dynamic result) {
                        if (result != null && result is List<File>) {
                          ctrl.smileImg = result;
                          ctrl.profileImageFile = ctrl.smileImg[0];
                          ctrl.faceImageFile = ctrl.smileImg[1];
                          ctrl.smileImageFile = ctrl.smileImg[2];
                          ctrl.intraMaxImageFile = ctrl.smileImg[3];
                          ctrl.intraMandImageFile = ctrl.smileImg[4];
                          ctrl.intraRightImageFile = ctrl.smileImg[5];
                          ctrl.intraFaceImageFile = ctrl.smileImg[6];
                          ctrl.intraLeftImageFile = ctrl.smileImg[7];
                          ctrl.uploadPatientMultipleImage(files: ctrl.smileImg);
                          ctrl.update();
                        }
                      },
                    );
                  },
                ),
              ),
              10.space(),
              photoCardWidget(
                image: Assets.images.imgIntraMand.path,
                title: LocaleKeys.intraMand.translateText,
                urlImage: refineScreen == true
                    ? ctrl.refinementData?.intraMand ?? ''
                    : ctrl.patientData?.patientPhoto?.interMandi ?? '',
                urlPath: "patient_intra_gauche",
                fileImage: ctrl.intraMandImageFile ?? File(''),
                onTap: () {
                  imageUploadUtils.faceDetectingOpenImageChooser(
                    context: Get.context!,
                    imageCount: 4,
                    title: LocaleKeys.intraMand.translateText,
                    onImageChose: (File? file) async {
                      // ctrl.cuisinePhoto?[0] =(file!);
                      ctrl.intraMandImageFile = file!;
                      if (refineScreen) {
                        ctrl.editPatientRefinementDetails(
                            paramName: 'patient_intra_gauche', file: file);
                      } else {
                        ctrl.uploadPatientSingleImage(
                            paramName: 'patient_intra_gauche', file: file);
                      }
                      ctrl.update();
                    },
                  );

                  // imageUploadUtils.openImageChooser(
                  //   context: Get.context!,
                  //   onImageChose: (File? file) async {
                  //     // ctrl.cuisinePhoto?[0] =(file!);
                  //     ctrl.intraMandImageFile = file!;
                  //     ctrl.uploadPatientSingleImage(
                  //         paramName: 'patient_intra_gauche', file: file);
                  //     ctrl.update();
                  //   },
                  // );
                },
              ),
            ],
          ),
          10.space(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              photoCardWidget(
                image: Assets.images.imgInterRight.path,
                urlPath: "patient_intra_droite",
                urlImage: refineScreen == true
                    ? ctrl.refinementData?.interRight ?? ''
                    : ctrl.patientData?.patientPhoto?.interDroite ?? '',
                fileImage: ctrl.intraRightImageFile ?? File(''),
                title: LocaleKeys.intraRight.translateText,
                onTap: () {
                  imageUploadUtils.faceDetectingOpenImageChooser(
                    context: Get.context!,
                    imageCount: 5,
                    title: LocaleKeys.intraRight.translateText,
                    onImageChose: (File? file) async {
                      // ctrl.cuisinePhoto?[0] =(file!);
                      ctrl.intraRightImageFile = file!;
                      if (refineScreen) {
                        ctrl.editPatientRefinementDetails(
                            paramName: 'patient_intra_droite', file: file);
                      } else {
                        ctrl.uploadPatientSingleImage(
                            paramName: 'patient_intra_droite', file: file);
                      }
                      ctrl.update();
                    },
                  );
                },
              ),
              10.space(),
              photoCardWidget(
                urlImage: refineScreen == true
                    ? ctrl.refinementData?.interFace ?? ''
                    : ctrl.patientData?.patientPhoto?.interFace ?? '',
                fileImage: ctrl.intraFaceImageFile ?? File(''),
                urlPath: "patient_inter_face",
                image: Assets.images.imgInterFace.path,
                title: LocaleKeys.intraFace.translateText,
                onTap: () {
                  imageUploadUtils.faceDetectingOpenImageChooser(
                    context: Get.context!,
                    imageCount: 6,
                    title: LocaleKeys.intraFace.translateText,
                    onImageChose: (File? file) async {
                      // ctrl.cuisinePhoto?[0] =(file!);
                      ctrl.intraFaceImageFile = file!;
                      if (refineScreen) {
                        ctrl.editPatientRefinementDetails(
                            paramName: 'patient_inter_face', file: file);
                      } else {
                        ctrl.uploadPatientSingleImage(
                            paramName: 'patient_inter_face', file: file);
                      }
                      ctrl.update();
                    },
                  );
                },
              ),
              10.space(),
              photoCardWidget(
                urlImage: refineScreen == true
                    ? ctrl.refinementData?.interLeft ?? ''
                    : ctrl.patientData?.patientPhoto?.interGauche ?? '',
                fileImage: ctrl.intraLeftImageFile ?? File(''),
                urlPath: "patient_inter_gauche",
                image: Assets.images.imgInterLeft.path,
                title: LocaleKeys.intraLeft.translateText,
                onTap: () {
                  imageUploadUtils.faceDetectingOpenImageChooser(
                    context: Get.context!,
                    imageCount: 7,
                    title: LocaleKeys.intraLeft.translateText,
                    onImageChose: (File file) async {
                      // ctrl.cuisinePhoto?[0] =(file!);
                      ctrl.intraLeftImageFile = file;
                      if (refineScreen) {
                        ctrl.editPatientRefinementDetails(
                            paramName: 'patient_inter_gauche', file: file);
                      } else {
                        ctrl.uploadPatientSingleImage(
                            paramName: 'patient_inter_gauche', file: file);
                      }
                      ctrl.update();
                    },
                  );
                },
              ),
            ],
          ),
          5.space(),
          LocaleKeys.radios.translateText.appCommonText(
            align: TextAlign.start,
            size: !isTablet ? 24 : 27,
            maxLine: 2,
            overflow: TextOverflow.ellipsis,
            weight: FontWeight.w500,
            color: Colors.black,
          ),
          LocaleKeys.jpgAndHeifFormat.translateText.appCommonText(
            align: TextAlign.start,
            size: !isTablet ? 16 : 19,
            maxLine: 2,
            overflow: TextOverflow.ellipsis,
            weight: FontWeight.w400,
            color: hintStepColor,
          ),
          15.space(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    imageUploadUtils.openImageChooser(
                      context: Get.context!,
                      onImageChose: (File? file) async {
                        // ctrl.cuisinePhoto?[0] =(file!);
                        ctrl.radiosFirstImageFile = file!;
                        if (refineScreen) {
                          ctrl.editPatientRefinementDetails(
                              paramName: 'patient_panoramique', file: file);
                        } else {
                          ctrl.uploadPatientSingleImage(
                              paramName: 'patient_panoramique', file: file);
                        }
                        //ctrl.uploadPatientSingleImage(paramName: 'patient_panoramique', file: file);
                        ctrl.update();
                      },
                    );
                  },
                  child: (ctrl.radiosFirstImageFile != null &&
                          ctrl.radiosFirstImageFile?.path != "")
                      ? HomeImage.fileImage(
                          path: ctrl.radiosFirstImageFile!.path,
                          height: !isTablet ? 121 : 215,
                          width: !isTablet ? 200 : 230,
                          shape: BoxShape.rectangle,
                          fit: BoxFit.cover,
                          radius: BorderRadius.circular(10),
                        )
                      : (refineScreen
                              ? (ctrl.refinementData?.panRadio == "" ||
                                  ctrl.refinementData?.panRadio == null)
                              : (ctrl.patientData?.patientPhoto
                                          ?.paramiqueRadio ==
                                      "" ||
                                  ctrl.patientData?.patientPhoto
                                          ?.paramiqueRadio ==
                                      null))
                          ? HomeImage.assetImage(
                              path: Assets.images.imgTab.path,
                              height: !isTablet ? 135 : 230,
                              width: !isTablet ? 200 : 230,
                              shape: BoxShape.rectangle,
                              // fit: BoxFit.cover,
                            )
                          : HomeImage.networkImage(
                              path: refineScreen == true
                                  ? "${ApiUrl.baseImagePatientPath}patient_panoramique/${ctrl.refinementData?.panRadio}" ??
                                      ''
                                  : "${ApiUrl.baseImagePatientPath}patient_panoramique/${ctrl.patientData?.patientPhoto?.paramiqueRadio}" ??
                                      '',
                              height: !isTablet ? 121 : 215,
                              width: !isTablet ? 200 : 230,
                              shape: BoxShape.rectangle,
                              fit: BoxFit.cover,
                              radius: BorderRadius.circular(12),
                            ),
                ),
              ),
              15.space(),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    imageUploadUtils.openImageChooser(
                      context: Get.context!,
                      onImageChose: (File? file) async {
                        // ctrl.cuisinePhoto?[0] =(file!);
                        ctrl.radiosSecondImageFile = file!;
                        if (refineScreen) {
                          ctrl.editPatientRefinementDetails(
                              paramName: 'patient_cephalometrique', file: file);
                        } else {
                          ctrl.uploadPatientSingleImage(
                              paramName: 'patient_cephalometrique', file: file);
                        }
                        ctrl.update();
                      },
                    );
                  },
                  child: (ctrl.radiosSecondImageFile != null &&
                          ctrl.radiosSecondImageFile?.path != "")
                      ? HomeImage.fileImage(
                          path: ctrl.radiosSecondImageFile!.path,
                          height: !isTablet ? 121 : 215,
                          width: !isTablet ? 200 : 230,
                          shape: BoxShape.rectangle,
                          fit: BoxFit.cover,
                          radius: BorderRadius.circular(10),
                        )
                      : (refineScreen
                              ? (ctrl.refinementData?.cephalRadio == "" ||
                                  ctrl.refinementData?.cephalRadio == null)
                              : (ctrl.patientData?.patientPhoto?.cephalRadio ==
                                      "" ||
                                  ctrl.patientData?.patientPhoto?.cephalRadio ==
                                      null))
                          ? HomeImage.assetImage(
                              path: Assets.images.imgTab.path,
                              height: !isTablet ? 135 : 230,
                              width: !isTablet ? 200 : 230,
                              shape: BoxShape.rectangle,
                              // fit: BoxFit.cover,
                            )
                          : HomeImage.networkImage(
                              path: refineScreen == true
                                  ? "${ApiUrl.baseImagePatientPath}patient_cephalometrique/${ctrl.refinementData?.cephalRadio}"
                                  : "${ApiUrl.baseImagePatientPath}patient_cephalometrique/${ctrl.patientData?.patientPhoto?.cephalRadio}",
                              height: !isTablet ? 121 : 215,
                              width: !isTablet ? 200 : 230,
                              shape: BoxShape.rectangle,
                              fit: BoxFit.cover,
                              radius: BorderRadius.circular(15),
                            ),
                ),
              ),
            ],
          ),
          10.space(),
          LocaleKeys.stlFiles.translateText.appCommonText(
            align: TextAlign.start,
            size: !isTablet ? 24 : 27,
            maxLine: 2,
            overflow: TextOverflow.ellipsis,
            weight: FontWeight.w500,
            color: Colors.black,
          ),
          10.space(),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: !isTablet ? 50 : 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: ctrl.isUploadStl ? primaryBrown : Colors.white,
                      border: Border.all(
                          color: ctrl.isUploadStl ? Colors.white : skyColor,
                          width: 1),
                      borderRadius: BorderRadius.circular(!isTablet ? 25 : 40)),
                  child: Padding(
                    padding: !isTablet
                        ? EdgeInsets.symmetric(horizontal: 10)
                        : EdgeInsets.zero,
                    child: LocaleKeys.uploadStl.translateText.appCommonText(
                      align: TextAlign.center,
                      color: ctrl.isUploadStl ? Colors.white : darkSkyColor,
                      size: !isTablet ? 16 : 20,
                    ),
                  ),
                ).onClick(
                  () {
                    ctrl.isUploadStl = true;
                    ctrl.update();
                  },
                ),
              ),
              25.space(),
              Expanded(
                child: Container(
                  height: !isTablet ? 50 : 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: !ctrl.isUploadStl ? primaryBrown : Colors.white,
                      borderRadius: BorderRadius.circular(!isTablet ? 25 : 40),
                      border: Border.all(
                          color: !ctrl.isUploadStl ? Colors.white : skyColor,
                          width: 1)),
                  child: LocaleKeys.postedBy3shape.translateText.appCommonText(
                      align: TextAlign.center,
                      color: !ctrl.isUploadStl ? Colors.white : darkSkyColor,
                      size: !isTablet ? 16 : 20,
                      weight: FontWeight.w500),
                ).onClick(
                  () {
                    ctrl.isUploadStl = false;
                    ctrl.update();
                  },
                ),
              ),
            ],
          ),
          Visibility(
            visible: ctrl.isUploadStl,
            child: Column(
              children: [
                10.space(),
                Row(
                  children: [
                    LocaleKeys.upperJawStlFile.translateText.appCommonText(
                        size: !isTablet ? 14 : 18,
                        weight: FontWeight.w400,
                        align: TextAlign.start),
                    3.space(),
                    "*"
                        .appCommonText(
                            size: !isTablet ? 14 : 16,
                            weight: FontWeight.w400,
                            color: Colors.red,
                            align: TextAlign.start)
                        .paddingOnly(bottom: 5)
                  ],
                ),
                AppTextField(
                  textEditingController: ctrl.upperJawImageFileTextCtrl,
                  onChanged: (String value) {},
                  validator: (String value) {},
                  textFieldPadding: EdgeInsets.zero,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  readOnly: true,
                  showCursor: false,
                  onTap: () {
                    imageUploadUtils.pickStlFileFormStorage(
                        context: Get.context!,
                        onFileChose: (File? file) async {
                          // ctrl.cuisinePhoto?[0] =(file!);
                          ctrl.upperJawImageFile = file!;
                          ctrl.upperJawImageFileTextCtrl.text =
                              ctrl.upperJawImageFile != null
                                  ? ctrl.upperJawImageFile!.path.split('/').last
                                  : '';
                          ctrl.uploadPatientSingleImage(
                              paramName: 'upper_jaw_stl_file', file: file);
                          ctrl.update();
                        });
                  },
                  // isError: ctrl.lastNameError,
                  prefixIcon: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    alignment: Alignment.center,
                    width: !isTablet ? 100 : 135,
                    decoration: BoxDecoration(
                        color: primaryBrown,
                        borderRadius: BorderRadius.circular(25)),
                    child: LocaleKeys.chooseFile.translateText.appCommonText(
                        size: !isTablet ? 14 : 18,
                        color: Colors.white,
                        align: TextAlign.center),
                  )
                      .paddingSymmetric(vertical: 7)
                      .paddingOnly(left: 10, right: 6),
                  hintText: LocaleKeys.noFileChosen.translateText,
                  // labelText: "Upper Jaw STL File*",
                  showPrefixIcon: false,
                ),
                10.space(),
                Row(
                  children: [
                    LocaleKeys.lowerJawStlFile.translateText.appCommonText(
                        size: !isTablet ? 14 : 18,
                        weight: FontWeight.w400,
                        align: TextAlign.start),
                    3.space(),
                    "*"
                        .appCommonText(
                            size: !isTablet ? 14 : 16,
                            weight: FontWeight.w400,
                            color: Colors.red,
                            align: TextAlign.start)
                        .paddingOnly(bottom: 5)
                  ],
                ),
                AppTextField(
                  textEditingController: ctrl.lowerJawImageFileTextCtrl,
                  onChanged: (value) {},
                  validator: (value) {},
                  textFieldPadding: EdgeInsets.zero,
                  keyboardType: TextInputType.text,
                  readOnly: true,
                  maxLines: 1,
                  showCursor: false,
                  onTap: () {
                    imageUploadUtils.pickStlFileFormStorage(
                        context: Get.context!,
                        onFileChose: (File? file) async {
                          // ctrl.cuisinePhoto?[0] =(file!);
                          ctrl.lowerJawImageFile = file!;
                          ctrl.lowerJawImageFileTextCtrl.text =
                              ctrl.lowerJawImageFile != null
                                  ? ctrl.lowerJawImageFile!.path.split('/').last
                                  : '';
                          ctrl.uploadPatientSingleImage(
                              paramName: 'lower_jaw_stl_file', file: file);
                          ctrl.update();
                        });
                  },
                  prefixIcon: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    alignment: Alignment.center,
                    width: !isTablet ? 100 : 135,
                    decoration: BoxDecoration(
                        color: primaryBrown,
                        borderRadius: BorderRadius.circular(25)),
                    child: LocaleKeys.chooseFile.translateText.appCommonText(
                        size: !isTablet ? 14 : 18,
                        color: Colors.white,
                        align: TextAlign.center),
                  )
                      .paddingSymmetric(vertical: 7)
                      .paddingOnly(left: 10, right: 6),
                  hintText: LocaleKeys.noFileChosen.translateText,
                  // labelText: "Upper Jaw STL File*",
                  showPrefixIcon: false,
                ),
              ],
            ),
          ),
          10.space(),
          LocaleKeys.cbctDICOM.translateText.appCommonText(
            align: TextAlign.start,
            size: !isTablet ? 24 : 27,
            maxLine: 2,
            overflow: TextOverflow.ellipsis,
            weight: FontWeight.w500,
            color: Colors.black,
          ),
          10.space(),
          Stack(
            children: [
              DottedBorder(
                borderType: BorderType.RRect,
                color: primaryBrown,
                padding: EdgeInsets.zero,
                radius: Radius.circular(35),
                dashPattern: [5, 5, 5, 5],
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(!isTablet ? 35 : 40),
                      color: primaryBrown.withOpacity(0.08)),
                  height: !isTablet ? 55 : 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.icons.icDocument.svg(height: !isTablet ? 23 : 30),
                      10.space(),
                      ctrl.dicomFileName.appCommonText(
                          size: !isTablet ? 16 : 20,
                          weight: FontWeight.w400,
                          color: primaryBrown),
                    ],
                  ),
                ),
              ).onClick(
                () {
                  imageUploadUtils.pickFileFormStorage(
                    context: Get.context!,
                    onFileChose: (File file) {
                      // Handle the chosen file
                      ctrl.dicomFile = file;
                      if (ctrl.dicomFile != null) {
                        ctrl.dicomFileName =
                            ctrl.getFileName(ctrl.dicomFile?.path, 15);
                      }
                      ctrl.update();
                      ctrl.uploadDicomFile(file, ctrl.patientData?.patientId);
                      print('Chosen file path: ${file.path}');
                    },
                  );
                },
              ),
              Visibility(
                visible: ctrl.isDcomFileLoading,
                child: Container(
                  width: double.infinity,
                  height: !isTablet ? 55 : 70,
                  decoration: BoxDecoration(
                      color: lightBrown.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(!isTablet ? 25 : 40)),
                  child: Center(
                    child: Text(
                      '${(ctrl.uploadProgress * 100).toStringAsFixed(0)}%',
                      style: TextStyle(
                        color: primaryBrown,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ).paddingSymmetric(horizontal: 3),
              )
            ],
          ),
          10.space(),
          Visibility(
            visible: ctrl.isDcomFileLoading,
            child: LinearProgressIndicator(
              value: ctrl.uploadProgress,
              backgroundColor: Colors.white.withOpacity(0.5),
              color: primaryBrown,
            ).paddingSymmetric(horizontal: 10),
          ),
          if (refineScreen) ...{
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
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(!isTablet ? 25 : 40),
                  color: Colors.white,
                  border: Border.all(color: skyColor)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LocaleKeys.lesDeux.translateText
                      .appCommonText(
                        size: !isTablet ? 16 : 19,
                        weight: FontWeight.w400,
                        color: Colors.black,
                      )
                      .paddingOnly(left: 15),
                  CustomRadioButton(
                    value: 1,
                    groupValue: ctrl.isArcadeTraiter,
                  ).paddingOnly(right: 13)
                ],
              ),
            ).onClick(() {
              ctrl.changeArcadeValue(1);
            }),
            10.space(),
            Container(
              height: !isTablet ? 55 : 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(!isTablet ? 25 : 40),
                  color: Colors.white,
                  border: Border.all(color: skyColor)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LocaleKeys.maxillaire.translateText
                      .appCommonText(
                        size: !isTablet ? 16 : 19,
                        weight: FontWeight.w400,
                        color: Colors.black,
                      )
                      .paddingOnly(left: 15),
                  CustomRadioButton(
                    value: 2,
                    groupValue: ctrl.isArcadeTraiter,
                  ).paddingOnly(right: 13)
                ],
              ),
            ).onClick(() {
              ctrl.changeArcadeValue(2);
            }),
            10.space(),
            Container(
              height: !isTablet ? 55 : 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(!isTablet ? 25 : 40),
                  color: Colors.white,
                  border: Border.all(color: skyColor)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LocaleKeys.mandibulaire.translateText
                      .appCommonText(
                        size: !isTablet ? 16 : 19,
                        weight: FontWeight.w400,
                        color: Colors.black,
                      )
                      .paddingOnly(left: 15),
                  CustomRadioButton(
                    value: 3,
                    groupValue: ctrl.isArcadeTraiter,
                  ).paddingOnly(right: 13)
                ],
              ),
            ).onClick(() {
              ctrl.changeArcadeValue(3);
            }),
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
              textEditingController: ctrl.commentController,
              onChanged: (value) {},
              validator: (value) {
                if (value.isEmpty) {
                  ctrl.lastNameError = true;
                  ctrl.update();
                  return LocaleKeys.pleaseEnterComment.translateText;
                }
                ctrl.update();
                return null;
              },
              textFieldPadding: EdgeInsets.zero,
              keyboardType: TextInputType.text,
              // isError: ctrl.lastNameError,
              hintText: LocaleKeys.addComment.translateText,
              showPrefixIcon: false,
            ),
            30.space(),
            AppButton(
              btnHeight: !isTablet ? 55 : 70,
              text: LocaleKeys.submit.translateText,
              onTap: () {
                if (ctrl.validateUploadPhotoFiles()) {
                  ctrl.editPatientRefinementDetails();
                } else {
                  showAppSnackBar(
                      LocaleKeys.pleaseSelectAllRequiredPhotos.translateText);
                }
              },
              boxShadow: [],
              radius: !isTablet ? 25 : 40,
              fontSize: !isTablet ? 18 : 22,
              bgColor: primaryBrown,
              fontColor: Colors.white,
            )
          },
          100.space(),
        ],
      ).paddingSymmetric(horizontal: 15),
      if (!refineScreen) ...{
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: !isTablet ? 80 : 100,
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: AppBorderButton(
                    btnHeight: !isTablet ? 55 : 70,
                    text: LocaleKeys.finishLatter.translateText,
                    onTap: () {
                      ctrl.addUpdatePatientDetails(
                          isFromFinishStep: true,
                          draftViewPage: "upload_photo_page");
                    },
                    // boxShadow: [],
                    radius: !isTablet ? 25 : 40,
                    fontSize: !isTablet ? 18 : 22,
                    borderColor: primaryBrown,
                    // bgColor: primaryBrown,
                    fontColor: primaryBrown,
                  ).paddingOnly(top: 10, right: 5, left: 15),
                ),
                Expanded(
                  child: AppButton(
                    btnHeight: !isTablet ? 55 : 70,
                    text: LocaleKeys.next.translateText,
                    onTap: () {
                      if (ctrl.validateUploadPhotoFiles()) {
                        ctrl.goToStep(3);
                      } else {
                        showAppSnackBar(LocaleKeys
                            .pleaseSelectAllRequiredPhotos.translateText);
                      }
                    },
                    boxShadow: [],
                    radius: !isTablet ? 25 : 40,
                    fontSize: !isTablet ? 18 : 22,
                    bgColor: primaryBrown,
                    fontColor: Colors.white,
                  ).paddingOnly(top: 10, right: 15, left: 5),
                ),
              ],
            ).paddingOnly(bottom: 10),
          ),
        ),
      }
    ],
  );
}

Widget photoCardWidget({
  required String title,
  required String image,
  required String urlImage,
  required String urlPath,
  required File? fileImage,
  required GestureTapCallback onTap,
}) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        (fileImage != null && fileImage.path != "")
            ? HomeImage.fileImage(
                path: fileImage.path,
                size: !isTablet ? 123 : 200,
                shape: BoxShape.rectangle,
                fit: BoxFit.cover,
                radius: BorderRadius.circular(15),
              ).onClick(onTap)
            : (urlImage.isEmpty || urlImage == "")
                ? HomeImage.assetImage(
                    path: image,
                    height: !isTablet ? 123 : 200,
                    shape: BoxShape.rectangle,
                    width: !isTablet ? 123 : 200,
                  ).onClick(onTap)
                : HomeImage.networkImage(
                    path: "${ApiUrl.baseImagePatientPath}$urlPath/$urlImage",
                    height: !isTablet ? 123 : 200,
                    shape: BoxShape.rectangle,
                    fit: BoxFit.cover,
                    radius: BorderRadius.circular(15),
                    width: !isTablet ? 123 : 200,
                  ).onClick(onTap),
        5.space(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            title.appCommonText(
                size: !isTablet ? 16 : 20,
                weight: FontWeight.w300,
                color: hintStepColor),
            " *"
                .appCommonText(
                    size: 16, weight: FontWeight.w500, color: Colors.red)
                .paddingOnly(bottom: 5),
          ],
        )
      ],
    ),
  );
}

Widget prescriptionScreen(AddPatientController ctrl) {
  return Stack(
    children: [
      ListView(
        children: [
          5.space(),
          LocaleKeys.arcadeTraiter.translateText
              .appCommonText(
                align: TextAlign.start,
                size: !isTablet ? 24 : 27,
                maxLine: 2,
                overflow: TextOverflow.ellipsis,
                weight: FontWeight.w500,
                color: Colors.black,
              )
              .paddingSymmetric(horizontal: 15),
          LocaleKeys.whereTheSimulationWillBeCarriedOut.translateText
              .appCommonText(
                align: TextAlign.start,
                size: !isTablet ? 16 : 19,
                maxLine: 2,
                overflow: TextOverflow.ellipsis,
                weight: FontWeight.w400,
                color: hintStepColor,
              )
              .paddingSymmetric(horizontal: 15),
          10.space(),
          Container(
            height: !isTablet ? 55 : 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(!isTablet ? 25 : 40),
                color: Colors.white,
                border: Border.all(color: skyColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LocaleKeys.lesDeux.translateText
                    .appCommonText(
                      size: !isTablet ? 16 : 19,
                      weight: FontWeight.w400,
                      color: Colors.black,
                    )
                    .paddingOnly(left: 15),
                CustomRadioButton(
                  value: 1,
                  groupValue: ctrl.isArcadeTraiter,
                ).paddingOnly(right: 13)
              ],
            ),
          ).paddingSymmetric(horizontal: 15).onClick(() {
            ctrl.changeArcadeValue(1);
          }),
          10.space(),
          Container(
            height: !isTablet ? 55 : 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(!isTablet ? 25 : 40),
                color: Colors.white,
                border: Border.all(color: skyColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LocaleKeys.maxillaire.translateText
                    .appCommonText(
                      size: !isTablet ? 16 : 19,
                      weight: FontWeight.w400,
                      color: Colors.black,
                    )
                    .paddingOnly(left: 15),
                CustomRadioButton(
                  value: 2,
                  groupValue: ctrl.isArcadeTraiter,
                ).paddingOnly(right: 13)
              ],
            ),
          ).paddingSymmetric(horizontal: 15).onClick(() {
            ctrl.changeArcadeValue(2);
          }),
          10.space(),
          Container(
            height: !isTablet ? 55 : 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(!isTablet ? 25 : 40),
                color: Colors.white,
                border: Border.all(color: skyColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LocaleKeys.mandibulaire.translateText
                    .appCommonText(
                      size: !isTablet ? 16 : 19,
                      weight: FontWeight.w400,
                      color: Colors.black,
                    )
                    .paddingOnly(left: 15),
                CustomRadioButton(
                  value: 3,
                  groupValue: ctrl.isArcadeTraiter,
                ).paddingOnly(right: 13)
              ],
            ),
          ).paddingSymmetric(horizontal: 15).onClick(() {
            ctrl.changeArcadeValue(3);
          }),
          10.space(),
          LocaleKeys
              .threeDScansOfBothArchesAreNecessaryEvenIfYouChooseToTreatOnlyOneArch
              .translateText
              .appCommonText(
                weight: FontWeight.w400,
                align: TextAlign.start,
                color: Colors.black,
                fontStyle: FontStyle.italic,
                size: !isTablet ? 16 : 19,
              )
              .paddingSymmetric(horizontal: 15),
          10.space(),
          treatmentGoals(ctrl),
          techniquesPatient(ctrl),
          Divider(color: dividerColor, height: 2, thickness: 3),
          dentalHistory(ctrl),
          Divider(color: dividerColor, height: 2, thickness: 3),
          12.space(),
          LocaleKeys.dentalClass.translateText
              .appCommonText(
                align: TextAlign.start,
                size: !isTablet ? 24 : 27,
                maxLine: 2,
                overflow: TextOverflow.ellipsis,
                weight: FontWeight.w500,
                color: Colors.black,
              )
              .paddingSymmetric(horizontal: 15),
          10.space(),
          Container(
            height: !isTablet ? 55 : 65,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(!isTablet ? 25 : 40),
                color: Colors.white,
                border: Border.all(color: skyColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LocaleKeys.maintenir.translateText
                    .appCommonText(
                      size: !isTablet ? 16 : 19,
                      weight: FontWeight.w400,
                      color: Colors.black,
                    )
                    .paddingOnly(left: 15),
                CustomRadioButton(
                  value: 1,
                  groupValue: ctrl.isClassesDental,
                ).paddingOnly(right: 13)
              ],
            ),
          ).paddingSymmetric(horizontal: 15).onClick(() {
            ctrl.changeClassesDentalValue(1);
          }),
          10.space(),
          Container(
            height: !isTablet ? 55 : 65,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(!isTablet ? 25 : 40),
                color: Colors.white,
                border: Border.all(color: skyColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LocaleKeys.ameliorerClasses.translateText
                    .appCommonText(
                      size: !isTablet ? 16 : 19,
                      weight: FontWeight.w400,
                      color: Colors.black,
                    )
                    .paddingOnly(left: 15),
                CustomRadioButton(
                  value: 2,
                  groupValue: ctrl.isClassesDental,
                ).paddingOnly(right: 13)
              ],
            ),
          ).paddingSymmetric(horizontal: 15).onClick(() {
            ctrl.changeClassesDentalValue(2);
          }),
          7.space(),
          LocaleKeys.notes.translateText
              .appCommonText(
                align: TextAlign.start,
                size: !isTablet ? 24 : 27,
                maxLine: 2,
                overflow: TextOverflow.ellipsis,
                weight: FontWeight.w500,
                color: Colors.black,
              )
              .paddingSymmetric(horizontal: 15),
          AppTextField(
            textEditingController: ctrl.classesDentalNoteCtrl,
            onChanged: (value) {},
            validator: (value) {
              if (value.isEmpty) {
                ctrl.emailError = true;
                ctrl.update();
                return LocaleKeys.pleaseEnterDateOfBirth.translateText;
              }
              ctrl.update();
              return null;
            },
            textFieldPadding: EdgeInsets.zero,
            keyboardType: TextInputType.text,
            radius: 20,
            isError: ctrl.emailError,
            hintText: LocaleKeys.enterARemark.translateText,
            maxLines: !isTablet ? 3 : 5,
            // labelText: LocaleKeys.deliveryAddress.translateText,
            showPrefixIcon: false,
          ).paddingSymmetric(horizontal: 15),
          20.space(),
          Divider(
            color: dividerColor,
            height: 2,
            thickness: 3,
          ),
          12.space(),
          LocaleKeys.middleMaxillaryIncisor.translateText
              .appCommonText(
                align: TextAlign.start,
                size: !isTablet ? 24 : 27,
                maxLine: 2,
                overflow: TextOverflow.ellipsis,
                weight: FontWeight.w500,
                color: Colors.black,
              )
              .paddingSymmetric(horizontal: 15),
          10.space(),
          ListView.builder(
            itemCount: ctrl.middleMaxillaryItems.length,
            physics: PageScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = ctrl.middleMaxillaryItems[index];
              return Container(
                height: !isTablet ? 55 : 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(!isTablet ? 25 : 40),
                  color: Colors.white,
                  border: Border.all(color: skyColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: item.title
                          .appCommonText(
                              size: !isTablet ? 16 : 19,
                              align: TextAlign.start,
                              weight: FontWeight.w400,
                              maxLine: 2,
                              overflow: TextOverflow.ellipsis)
                          .paddingOnly(left: 15),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color:
                            item.isSelected ? primaryBrown : Colors.transparent,
                        border: Border.all(color: primaryBrown, width: 1),
                        shape: BoxShape.circle,
                      ),
                      child: item.isSelected
                          ? Icon(Icons.check, color: Colors.white, size: 16)
                          : Container(),
                    ).paddingOnly(right: 13),
                  ],
                ),
              ).paddingSymmetric(vertical: 5).onClick(() {
                ctrl.toggleMiddleMaxillaryItemsSelection(index);
              });
            },
          ).paddingSymmetric(horizontal: 15),
          5.space(),
          LocaleKeys.notes.translateText
              .appCommonText(
                align: TextAlign.start,
                size: !isTablet ? 24 : 27,
                maxLine: 2,
                overflow: TextOverflow.ellipsis,
                weight: FontWeight.w500,
                color: Colors.black,
              )
              .paddingSymmetric(horizontal: 15),
          AppTextField(
            textEditingController: ctrl.maxillaireNoteCtrl,
            onChanged: (value) {},
            validator: (value) {
              if (value.isEmpty) {
                ctrl.emailError = true;
                ctrl.update();
                return LocaleKeys.pleaseEnterDateOfBirth.translateText;
              }
              ctrl.update();
              return null;
            },
            textFieldPadding: EdgeInsets.zero,
            keyboardType: TextInputType.text,
            isError: ctrl.emailError,
            radius: 20,
            hintText: LocaleKeys.enterARemark.translateText,
            maxLines: !isTablet ? 3 : 5,
            // labelText: LocaleKeys.deliveryAddress.translateText,
            showPrefixIcon: false,
          ).paddingSymmetric(horizontal: 15),
          20.space(),
          Divider(
            color: dividerColor,
            height: 2,
            thickness: 3,
          ),
          incisorCovering(ctrl),
          Divider(
            color: dividerColor,
            height: 2,
            thickness: 3,
          ),
          15.space(),
          LocaleKeys.otherRecommendations.translateText
              .appCommonText(
                align: TextAlign.start,
                size: !isTablet ? 24 : 27,
                maxLine: 2,
                overflow: TextOverflow.ellipsis,
                weight: FontWeight.w500,
                color: Colors.black,
              )
              .paddingSymmetric(horizontal: 15),
          AppTextField(
            textEditingController: ctrl.autresRecommandationNoteCtrl,
            onChanged: (value) {},
            validator: (value) {
              if (value.isEmpty) {
                ctrl.emailError = true;
                ctrl.update();
                return LocaleKeys.pleaseEnterDateOfBirth.translateText;
              }
              ctrl.update();
              return null;
            },
            radius: 20,
            textFieldPadding: EdgeInsets.zero,
            keyboardType: TextInputType.text,
            isError: ctrl.emailError,
            hintText: LocaleKeys.enterARemark.translateText,
            maxLines: !isTablet ? 3 : 5,
            // labelText: LocaleKeys.deliveryAddress.translateText,
            showPrefixIcon: false,
          ).paddingSymmetric(horizontal: 15),
          100.space(),
        ],
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: !isTablet ? 80 : 100,
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Expanded(
                child: AppBorderButton(
                  btnHeight: !isTablet ? 55 : 70,
                  text: LocaleKeys.finishLatter.translateText,
                  onTap: () {
                    // ctrl.goToStep(1);
                    ctrl.addUpdatePatientDetails(
                        isFromFinishStep: true,
                        draftViewPage: "patient_prescription_page");
                  },
                  // boxShadow: [],
                  radius: !isTablet ? 25 : 40,
                  fontSize: !isTablet ? 18 : 22,
                  borderColor: primaryBrown,
                  // bgColor: primaryBrown,
                  fontColor: primaryBrown,
                ).paddingOnly(top: 10, right: 5, left: 15),
              ),
              Expanded(
                child: AppButton(
                  btnHeight: !isTablet ? 55 : 70,
                  text: LocaleKeys.add.translateText,
                  onTap: () {
                    if (ctrl.validateArcadeFields()) {
                      ctrl.addUpdatePatientDetails();
                    } else {
                      showAppSnackBar(LocaleKeys
                          .pleaseSelectAllRequiredFields.translateText);
                    }
                  },
                  boxShadow: [],
                  radius: !isTablet ? 25 : 40,
                  fontSize: !isTablet ? 18 : 22,
                  bgColor: primaryBrown,
                  fontColor: Colors.white,
                ).paddingOnly(top: 10, right: 15, left: 5),
              ),
            ],
          ).paddingOnly(bottom: 10),
        ),
      ),
    ],
  );
}

Widget techniquesPatient(AddPatientController ctrl) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      10.space(),
      LocaleKeys.acceptedTechniquesForThisPatient.translateText
          .appCommonText(
            align: TextAlign.start,
            size: !isTablet ? 24 : 27,
            maxLine: 2,
            overflow: TextOverflow.ellipsis,
            weight: FontWeight.w500,
            color: Colors.black,
          )
          .paddingSymmetric(horizontal: 15),
      ListView.builder(
        itemCount: ctrl.patientTechniquesItems.length,
        physics: PageScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final SelectionItem item = ctrl.patientTechniquesItems[index];
          return Column(
            children: [
              Container(
                height: !isTablet ? 55 : 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(!isTablet ? 25 : 40),
                  color: Colors.white,
                  border: Border.all(color: skyColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: item.title
                          .appCommonText(
                            maxLine: 2,
                            overflow: TextOverflow.ellipsis,
                            size: !isTablet ? 16 : 19,
                            align: TextAlign.start,
                            weight: FontWeight.w400,
                            color: Colors.black,
                          )
                          .paddingOnly(left: 15),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color:
                            item.isSelected ? primaryBrown : Colors.transparent,
                        border: Border.all(color: primaryBrown, width: 1),
                        shape: BoxShape.circle,
                      ),
                      child: item.isSelected
                          ? Icon(Icons.check, color: Colors.white, size: 16)
                          : Container(),
                    ).paddingOnly(right: 13),
                  ],
                ),
              ).paddingSymmetric(vertical: 5).onClick(() {
                ctrl.togglePatientSelection(index);
              }),
              Visibility(
                visible: item.requiresNote && item.isSelected,
                child: AppTextField(
                  textEditingController: item.noteController,
                  onChanged: (value) {
                    // item.note = value;
                    ctrl.changePatientNoteText(index, value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      ctrl.emailError = true;
                      ctrl.update();
                      return LocaleKeys.pleaseEnterDateOfBirth.translateText;
                    }
                    ctrl.update();
                    return null;
                  },
                  textFieldPadding: EdgeInsets.zero,
                  keyboardType: TextInputType.text,
                  isError: ctrl.emailError,
                  hintText: LocaleKeys.enterARemark.translateText,
                  maxLines: !isTablet ? 3 : 5,
                  radius: 20,
                  // labelText: LocaleKeys.deliveryAddress.translateText,
                  showPrefixIcon: false,
                ).paddingOnly(bottom: 7),
              )
            ],
          );
        },
      ).paddingSymmetric(horizontal: 15),
      5.space(),
      LocaleKeys.notes.translateText
          .appCommonText(
            align: TextAlign.start,
            size: !isTablet ? 24 : 27,
            maxLine: 2,
            overflow: TextOverflow.ellipsis,
            weight: FontWeight.w500,
            color: Colors.black,
          )
          .paddingSymmetric(horizontal: 15),
      AppTextField(
        textEditingController: ctrl.techniquesPatientsNoteCtrl,
        onChanged: (value) {},
        validator: (value) {
          if (value.isEmpty) {
            ctrl.emailError = true;
            ctrl.update();
            return LocaleKeys.pleaseEnterDateOfBirth.translateText;
          }
          ctrl.update();
          return null;
        },
        textFieldPadding: EdgeInsets.zero,
        keyboardType: TextInputType.text,
        isError: ctrl.emailError,
        radius: 20,
        hintText: LocaleKeys.enterARemark.translateText,
        maxLines: !isTablet ? 3 : 5,
        // labelText: LocaleKeys.deliveryAddress.translateText,
        showPrefixIcon: false,
      ).paddingSymmetric(horizontal: 15),
      20.space(),
    ],
  );
}

Widget dentalHistory(AddPatientController ctrl) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      15.space(),
      LocaleKeys.dentalHistory.translateText
          .appCommonText(
            align: TextAlign.start,
            size: !isTablet ? 24 : 27,
            maxLine: 2,
            overflow: TextOverflow.ellipsis,
            weight: FontWeight.w500,
            color: Colors.black,
          )
          .paddingSymmetric(horizontal: 15),
      5.space(),
      ListView.builder(
        itemCount: ctrl.dentalHistoryItems.length,
        physics: PageScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final SelectionItem item = ctrl.dentalHistoryItems[index];
          return Column(
            children: [
              Container(
                height: !isTablet ? 55 : 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(!isTablet ? 25 : 40),
                  color: Colors.white,
                  border: Border.all(color: skyColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: item.title
                            .appCommonText(
                              maxLine: 2,
                              overflow: TextOverflow.ellipsis,
                              align: TextAlign.start,
                              size: !isTablet ? 16 : 19,
                              weight: FontWeight.w400,
                              color: Colors.black,
                            )
                            .paddingOnly(left: 15)),
                    Container(
                      alignment: Alignment.center,
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color:
                            item.isSelected ? primaryBrown : Colors.transparent,
                        border: Border.all(color: primaryBrown, width: 1),
                        shape: BoxShape.circle,
                      ),
                      child: item.isSelected
                          ? Icon(Icons.check, color: Colors.white, size: 16)
                          : Container(),
                    ).paddingOnly(right: 13),
                  ],
                ),
              ).paddingSymmetric(vertical: 5).onClick(() {
                ctrl.toggleDentalSelection(index);
              }),
              Visibility(
                visible: item.requiresNote && item.isSelected,
                child: AppTextField(
                  textEditingController: item.noteController,
                  radius: 20,
                  onChanged: (value) {
                    ctrl.changeDentalHistoryNoteText(index, value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      ctrl.emailError = true;
                      ctrl.update();
                      return LocaleKeys.pleaseEnterDateOfBirth.translateText;
                    }
                    ctrl.update();
                    return null;
                  },
                  textFieldPadding: EdgeInsets.zero,
                  keyboardType: TextInputType.text,
                  isError: ctrl.emailError,
                  hintText: LocaleKeys.enterARemark.translateText,
                  maxLines: !isTablet ? 3 : 5,
                  // labelText: LocaleKeys.deliveryAddress.translateText,
                  showPrefixIcon: false,
                ).paddingOnly(bottom: 7),
              ),
              Visibility(
                visible: item.dentalHistory && item.isSelected,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: !isTablet ? 55 : 70,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(!isTablet ? 25 : 40),
                          color: Colors.white,
                          border: Border.all(color: skyColor),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              LocaleKeys.yes.translateText,
                              style: TextStyle(
                                fontSize: !isTablet ? 16 : 19,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ).paddingOnly(left: 15),
                            Container(
                              alignment: Alignment.center,
                              width: 20.0,
                              height: 20.0,
                              decoration: BoxDecoration(
                                color: item.dentalHistorySelected
                                    ? primaryBrown
                                    : Colors.transparent,
                                border:
                                    Border.all(color: primaryBrown, width: 1),
                                shape: BoxShape.circle,
                              ),
                              child: item.dentalHistorySelected
                                  ? Icon(Icons.check,
                                      color: Colors.white, size: 16)
                                  : Container(),
                            ).paddingOnly(right: 13),
                          ],
                        ),
                      ).onClick(
                        () {
                          ctrl.toggleProblemSelection(index);
                        },
                      ),
                    ),
                    10.space(),
                    Expanded(
                        child: Container(
                      height: !isTablet ? 55 : 65,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(!isTablet ? 25 : 40),
                        color: Colors.white,
                        border: Border.all(color: skyColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.no.translateText,
                            style: TextStyle(
                              fontSize: !isTablet ? 16 : 19,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ).paddingOnly(left: 15),
                          Container(
                            alignment: Alignment.center,
                            width: 20.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                              color: !item.dentalHistorySelected
                                  ? primaryBrown
                                  : Colors.transparent,
                              border: Border.all(color: primaryBrown, width: 1),
                              shape: BoxShape.circle,
                            ),
                            child: !item.dentalHistorySelected
                                ? Icon(Icons.check,
                                    color: Colors.white, size: 16)
                                : Container(),
                          ).paddingOnly(right: 13),
                        ],
                      ),
                    ).onClick(
                      () {
                        ctrl.toggleProblemSelection(index);
                      },
                    )),
                  ],
                ).paddingOnly(top: 5, bottom: 7),
              )
            ],
          );
        },
      ).paddingSymmetric(horizontal: 15),
      5.space(),
      LocaleKeys.notes.translateText
          .appCommonText(
            align: TextAlign.start,
            size: !isTablet ? 24 : 27,
            maxLine: 2,
            overflow: TextOverflow.ellipsis,
            weight: FontWeight.w500,
            color: Colors.black,
          )
          .paddingSymmetric(horizontal: 15),
      AppTextField(
        textEditingController: ctrl.dentalHistoryNoteCtrl,
        onChanged: (String value) {},
        radius: 20,
        validator: (String value) {
          if (value.isEmpty) {
            ctrl.emailError = true;
            ctrl.update();
            return LocaleKeys.pleaseEnterDateOfBirth.translateText;
          }
          ctrl.update();
          return null;
        },
        textFieldPadding: EdgeInsets.zero,
        keyboardType: TextInputType.text,
        isError: ctrl.emailError,
        hintText: LocaleKeys.enterARemark.translateText,
        maxLines: !isTablet ? 3 : 5,
        // labelText: LocaleKeys.deliveryAddress.translateText,
        showPrefixIcon: false,
      ).paddingSymmetric(horizontal: 15),
      20.space(),
    ],
  );
}

Widget incisorCovering(AddPatientController ctrl) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      15.space(),
      LocaleKeys.incisorCoveringOverbite.translateText
          .appCommonText(
            align: TextAlign.start,
            size: !isTablet ? 24 : 27,
            maxLine: 2,
            overflow: TextOverflow.ellipsis,
            weight: FontWeight.w500,
            color: Colors.black,
          )
          .paddingSymmetric(horizontal: 15),
      10.space(),
      ListView.builder(
        itemCount: ctrl.incisorCoveringItems.length,
        physics: PageScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final SelectionItem item = ctrl.incisorCoveringItems[index];
          return Container(
            height: !isTablet ? 55 : 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(!isTablet ? 25 : 40),
              color: Colors.white,
              border: Border.all(color: skyColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: item.title
                      .appCommonText(
                          size: !isTablet ? 16 : 19,
                          align: TextAlign.start,
                          weight: FontWeight.w400,
                          maxLine: 2,
                          overflow: TextOverflow.ellipsis)
                      .paddingOnly(left: 15),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: item.isSelected ? primaryBrown : Colors.transparent,
                    border: Border.all(color: primaryBrown, width: 1),
                    shape: BoxShape.circle,
                  ),
                  child: item.isSelected
                      ? Icon(Icons.check, color: Colors.white, size: 16)
                      : Container(),
                ).paddingOnly(right: 13),
              ],
            ),
          ).paddingSymmetric(vertical: 5).onClick(() {
            ctrl.toggleIncisorCoveringSelection(index);
          });
        },
      ).paddingSymmetric(horizontal: 15),
      5.space(),
      LocaleKeys.notes.translateText
          .appCommonText(
            align: TextAlign.start,
            size: !isTablet ? 24 : 27,
            maxLine: 2,
            overflow: TextOverflow.ellipsis,
            weight: FontWeight.w500,
            color: Colors.black,
          )
          .paddingSymmetric(horizontal: 15),
      AppTextField(
        textEditingController: ctrl.incisorCoveringNoteCtrl,
        onChanged: (value) {},
        validator: (value) {
          if (value.isEmpty) {
            ctrl.emailError = true;
            ctrl.update();
            return LocaleKeys.pleaseEnterText.translateText;
          }
          ctrl.update();
          return null;
        },
        textFieldPadding: EdgeInsets.zero,
        keyboardType: TextInputType.text,
        isError: ctrl.emailError,
        radius: 20,
        hintText: LocaleKeys.toInput.translateText,
        maxLines: !isTablet ? 3 : 5,
        // labelText: LocaleKeys.deliveryAddress.translateText,
        showPrefixIcon: false,
      ).paddingSymmetric(horizontal: 15),
      20.space(),
    ],
  );
}

Widget treatmentGoals(AddPatientController ctrl) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      LocaleKeys.treatmentGoals.translateText
          .appCommonText(
            align: TextAlign.start,
            size: !isTablet ? 24 : 27,
            maxLine: 2,
            overflow: TextOverflow.ellipsis,
            weight: FontWeight.w500,
            color: Colors.black,
          )
          .paddingSymmetric(horizontal: 15),
      LocaleKeys.patientRequest.translateText
          .appCommonText(
            align: TextAlign.start,
            size: !isTablet ? 16 : 19,
            maxLine: 2,
            overflow: TextOverflow.ellipsis,
            weight: FontWeight.w400,
            color: hintStepColor,
          )
          .paddingSymmetric(horizontal: 15),
      10.space(),
      Container(
        height: !isTablet ? 55 : 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(!isTablet ? 25 : 40),
            color: Colors.white,
            border: Border.all(color: skyColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: LocaleKeys.alignementEsthetique.translateText
                  .appCommonText(
                    size: !isTablet ? 16 : 19,
                    maxLine: 2,
                    overflow: TextOverflow.ellipsis,
                    align: TextAlign.start,
                    weight: FontWeight.w400,
                    color: Colors.black,
                  )
                  .paddingOnly(left: 15),
            ),
            CustomRadioButton(
              value: 1,
              groupValue: ctrl.isObjectTraitement,
            ).paddingOnly(right: 13)
          ],
        ),
      ).paddingSymmetric(horizontal: 15).onClick(() {
        ctrl.changeObjectValue(1);
      }),
      10.space(),
      Container(
        height: !isTablet ? 55 : 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(!isTablet ? 25 : 40),
            color: Colors.white,
            border: Border.all(color: skyColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: LocaleKeys.alignementEsthetiqueCorrection.translateText
                  .appCommonText(
                    size: !isTablet ? 16 : 19,
                    align: TextAlign.start,
                    maxLine: 2,
                    overflow: TextOverflow.ellipsis,
                    weight: FontWeight.w400,
                    color: Colors.black,
                  )
                  .paddingOnly(left: 15),
            ),
            CustomRadioButton(
              value: 2,
              groupValue: ctrl.isObjectTraitement,
            ).paddingOnly(right: 13),
          ],
        ),
      ).paddingSymmetric(horizontal: 15).onClick(() {
        ctrl.changeObjectValue(2);
      }),
      10.space(),
      AppTextField(
        textEditingController: ctrl.objectifsTraitementDeliveryAddressCtrl,
        onChanged: (String value) {},
        radius: 20,
        validator: (String value) {
          if (value.isEmpty) {
            ctrl.emailError = true;
            ctrl.update();
            return LocaleKeys.pleaseEnterAddress.translateText;
          }
          ctrl.update();
          return null;
        },
        textFieldPadding: EdgeInsets.zero,
        keyboardType: TextInputType.text,
        isError: ctrl.emailError,
        hintText: LocaleKeys.enterARemark.translateText,
        maxLines: !isTablet ? 3 : 5,
        labelText: LocaleKeys.remark.translateText,
        showPrefixIcon: false,
      ).paddingSymmetric(horizontal: 15),
    ],
  );
}
