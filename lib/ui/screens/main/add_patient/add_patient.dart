import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/home_image.dart';
import 'package:lynerdoctor/core/utils/image_picker.dart';
import 'package:lynerdoctor/core/utils/step_indicator.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/add_patient/add_patient_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_bar.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';
import 'package:lynerdoctor/ui/widgets/app_progress_view.dart';
import 'package:lynerdoctor/ui/widgets/common_dialog.dart';
import 'package:lynerdoctor/ui/widgets/custom_radio_button.dart';

class AddPatientScreen extends StatelessWidget {
  AddPatientScreen({super.key});

  final controller = Get.put(AddPatientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarWithIcons(
          centerTitle: false,
          title: Text(
            LocaleKeys.addNewPatient.translateText,
            style: TextStyle(
                fontFamily: Assets.fonts.maax,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: 20),
          ),
          backgroundColor: Colors.white,
          leadingWidth: 40,
          leading: Assets.icons.icBack
              .svg(
                height: 25,
                width: 25,
                fit: BoxFit.scaleDown,
              )
              .paddingOnly(
                left: 10,
              )
              .onClick(() {
            Get.back();
          }),
        ),
        body: GetBuilder<AddPatientController>(builder: (ctrl) {
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
                      onStepTapped: (index) async {
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
                                showAppSnackBar(
                                    "Please select any product plan to go next step");
                              }
                              break;
                            case 2:
                              if (ctrl.firstNameController.text.isEmpty ||
                                  ctrl.lastNameController.text.isEmpty) {
                                if (ctrl.currentStep == 1) {
                                  showAppSnackBar(
                                      "Please enter firstname and lastname");
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
                                  showAppSnackBar(
                                      "Please enter firstname and lastname");
                                }
                                return;
                              } else {
                                if (ctrl.patientData == null) {
                                  await ctrl.addNewPatient();
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
                        onPageChanged: (index) {
                          ctrl.goToStep(index);
                        },
                        children: [
                          chooseTheProduct(ctrl),
                          patientInformation(ctrl),
                          uploadPhotographs(ctrl),
                          arcadeTraiter(ctrl),
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
        }));
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
            size: 24,
            weight: FontWeight.w500,
            color: Colors.black,
          ),
          5.space(),
          ListView.builder(
            itemCount: ctrl.products.length,
            padding: const EdgeInsets.only(bottom: 10),
            physics: const PageScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final product = ctrl.products[index];
              final isSelectedProductPlan =
                  ctrl.selectedProduct.value == product;
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
                        height: 55,
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
                                weight: FontWeight.w500, size: 20),
                            Container(
                              alignment: Alignment.center,
                              width: 22.0,
                              height: 22.0,
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
                                        alignment: Alignment.center, width: 12)
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
                              size: 16,
                              align: TextAlign.start)
                          .paddingSymmetric(horizontal: 15),
                      10.space(),
                      product.caseDesc
                          .appCommonText(
                              weight: FontWeight.w300,
                              size: 16,
                              color: hintColor,
                              maxLine: 2,
                              overflow: TextOverflow.ellipsis,
                              align: TextAlign.start)
                          .paddingSymmetric(horizontal: 15),
                      12.space(),
                      product.casePrice
                          .appCommonText(weight: FontWeight.w500, size: 16)
                          .paddingSymmetric(horizontal: 15),
                      13.space(),
                      Container(
                        height: 55,
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
                                  size: 20,
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
          60.space(),
        ],
      ).paddingSymmetric(horizontal: 15),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 70,
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: AppButton(
            btnHeight: 55,
            text: LocaleKeys.next.translateText,
            onTap: () {
              if (ctrl.isSelectedProductPlan) {
                ctrl.goToStep(1);
              } else {
                showAppSnackBar("Please select any product plan to continue ");
              }
            },
            boxShadow: [],
            radius: 25,
            fontSize: 20,
            bgColor: primaryBrown,
            fontColor: Colors.white,
          ).paddingOnly(top: 10).paddingSymmetric(horizontal: 15),
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
            5.space(),
            LocaleKeys.patientInformation.translateText.appCommonText(
              align: TextAlign.start,
              size: 24,
              weight: FontWeight.w500,
              color: Colors.black,
            ),
            10.space(),
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
                        return 'Please enter firstname';
                      }
                      ctrl.update();
                      return null;
                    },
                    textFieldPadding: EdgeInsets.zero,
                    keyboardType: TextInputType.text,
                    // isError: ctrl.firstNameError,
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
                        return 'Please enter lastname';
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
              onChanged: (value) {},
              validator: (value) {},
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
              validator: (value) {
                if (value.isEmpty) {
                  ctrl.emailError = true;
                  ctrl.update();
                  return 'Please enter Date of Birth';
                }
                ctrl.update();
                return null;
              },
              onTap: () async {
                ctrl.pickedDate =
                    await datePickerDialog(Get.context!, ctrl.dateText);
                if (ctrl.pickedDate != null) {
                  ctrl.dateText = ctrl.pickedDate;
                  ctrl.dateTextField =
                      DateFormat('dd-MM-yyyy').format(ctrl.pickedDate!);
                  ctrl.dateOfBirthController.text = ctrl.dateTextField!;
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
            AppTextField(
              textEditingController: ctrl.doctorController,
              onChanged: (value) {},
              validator: (value) {
                if (value.isEmpty) {
                  ctrl.emailError = true;
                  ctrl.update();
                  return 'Please enter Doctor';
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
            ),
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
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const PageScrollPhysics(),
                  itemBuilder: (builder, index) {
                    var data = ctrl.doctorDataList[
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
                              size: 15,
                            ),
                          ),
                          if (ctrl.doctorController.text.contains(
                              '${data?.firstName} ${data?.lastName}')) ...[
                            Assets.icons.icSelectArrow.svg(color: primaryBrown),
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
                  return 'Please enter billing address';
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
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const PageScrollPhysics(),
                  itemBuilder: (builder, index) {
                    var data = ctrl.clinicBillingList[
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
                              size: 15,
                            ),
                          ),
                          if (ctrl.billingAddressController.text
                              .contains('${data?.billingName}')) ...[
                            Assets.icons.icSelectArrow.svg(color: primaryBrown),
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
              onChanged: (value) {},
              validator: (value) {
                if (value.isEmpty) {
                  ctrl.emailError = true;
                  ctrl.update();
                  return 'Please enter delivery address';
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
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const PageScrollPhysics(),
                  itemBuilder: (builder, index) {
                    var data = ctrl.clinicDeliveryLocationList[
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
                              size: 15,
                            ),
                          ),
                          if (ctrl.billingAddressController.text
                              .contains('${data?.address}')) ...[
                            Assets.icons.icSelectArrow.svg(color: primaryBrown),
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
            100.space(),
          ],
        ).paddingSymmetric(horizontal: 15),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 70,
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: AppButton(
            btnHeight: 55,
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
            radius: 25,
            fontSize: 20,
            bgColor: primaryBrown,
            fontColor: Colors.white,
          ).paddingOnly(top: 10).paddingSymmetric(horizontal: 15),
        ),
      ),
    ],
  );
}

Widget uploadPhotographs(AddPatientController ctrl) {
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
                      size: 24,
                      maxLine: 2,
                      overflow: TextOverflow.ellipsis,
                      weight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    (".jpg & .heif format").appCommonText(
                      align: TextAlign.start,
                      size: 16,
                      maxLine: 2,
                      overflow: TextOverflow.ellipsis,
                      weight: FontWeight.w400,
                      color: hintStepColor,
                    ),
                  ],
                ),
              ),
              "+Add all Photos".appCommonText(
                align: TextAlign.start,
                size: 16,
                decoration: TextDecoration.underline,
                decorationColor: primaryBrown,
                weight: FontWeight.w500,
                color: primaryBrown,
              )
            ],
          ),
          10.space(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              photoCardWidget(
                image: Assets.images.imgProfile.path,
                title: "Profile",
                ctrl: ctrl,
                fileImage: ctrl.profileImageFile ?? File(''),
                onTap: () {
                  imageUploadUtils.openImageChooser(
                      context: Get.context!,
                      onImageChose: (File? file) async {
                        // ctrl.cuisinePhoto?[0] =(file!);
                        ctrl.profileImageFile = file!;
                        ctrl.uploadPatientSingleImage(
                            paramName: 'patient_gauche', file: file);
                        ctrl.update();
                      });
                },
              ),
              10.space(),
              photoCardWidget(
                image: Assets.images.imgFace.path,
                title: "Face",
                ctrl: ctrl,
                fileImage: ctrl.faceImageFile ?? File(''),
                onTap: () {
                  imageUploadUtils.openImageChooser(
                      context: Get.context!,
                      onImageChose: (File? file) async {
                        // ctrl.cuisinePhoto?[0] =(file!);
                        ctrl.faceImageFile = file!;
                        ctrl.uploadPatientSingleImage(
                            paramName: 'patient_face', file: file);
                        ctrl.update();
                      });
                },
              ),
              10.space(),
              photoCardWidget(
                image: Assets.images.imgSmile.path,
                title: "Smile",
                ctrl: ctrl,
                fileImage: ctrl.smileImageFile ?? File(''),
                onTap: () {
                  imageUploadUtils.openImageChooser(
                      context: Get.context!,
                      onImageChose: (File? file) async {
                        // ctrl.cuisinePhoto?[0] =(file!);
                        ctrl.smileImageFile = file!;
                        ctrl.uploadPatientSingleImage(
                            paramName: 'patient_sourire', file: file);
                        ctrl.update();
                      });
                },
              ),
            ],
          ),
          5.space(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              photoCardWidget(
                image: Assets.images.imgIntraMax.path,
                title: "Intra Max",
                ctrl: ctrl,
                fileImage: ctrl.intraMaxImageFile ?? File(''),
                onTap: () {
                  imageUploadUtils.openImageChooser(
                      context: Get.context!,
                      onImageChose: (File? file) async {
                        // ctrl.cuisinePhoto?[0] =(file!);
                        ctrl.intraMaxImageFile = file!;
                        ctrl.uploadPatientSingleImage(
                            paramName: 'patient_intra_max', file: file);
                        ctrl.update();
                      });
                },
              ),
              143.space(),
              photoCardWidget(
                image: Assets.images.imgIntraMand.path,
                title: "Intra Mand",
                ctrl: ctrl,
                fileImage: ctrl.intraMandImageFile ?? File(''),
                onTap: () {
                  imageUploadUtils.openImageChooser(
                      context: Get.context!,
                      onImageChose: (File? file) async {
                        // ctrl.cuisinePhoto?[0] =(file!);
                        ctrl.intraMandImageFile = file!;
                        ctrl.uploadPatientSingleImage(
                            paramName: 'inter_mandi', file: file);
                        ctrl.update();
                      });
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
                ctrl: ctrl,
                fileImage: ctrl.intraRightImageFile ?? File(''),
                title: "Inter Right",
                onTap: () {
                  imageUploadUtils.openImageChooser(
                      context: Get.context!,
                      onImageChose: (File? file) async {
                        // ctrl.cuisinePhoto?[0] =(file!);
                        ctrl.intraRightImageFile = file!;
                        ctrl.uploadPatientSingleImage(
                            paramName: 'patient_intra_droite', file: file);
                        ctrl.update();
                      });
                },
              ),
              10.space(),
              photoCardWidget(
                ctrl: ctrl,
                fileImage: ctrl.intraFaceImageFile ?? File(''),
                image: Assets.images.imgInterFace.path,
                title: "Inter Face",
                onTap: () {
                  imageUploadUtils.openImageChooser(
                      context: Get.context!,
                      onImageChose: (File? file) async {
                        // ctrl.cuisinePhoto?[0] =(file!);
                        ctrl.intraFaceImageFile = file!;
                        ctrl.uploadPatientSingleImage(
                            paramName: 'patient_inter_face', file: file);
                        ctrl.update();
                      });
                },
              ),
              10.space(),
              photoCardWidget(
                ctrl: ctrl,
                fileImage: ctrl.intraLeftImageFile ?? File(''),
                image: Assets.images.imgInterLeft.path,
                title: "Inter Left",
                onTap: () {
                  imageUploadUtils.openImageChooser(
                      context: Get.context!,
                      onImageChose: (File? file) async {
                        // ctrl.cuisinePhoto?[0] =(file!);
                        ctrl.intraLeftImageFile = file!;
                        ctrl.uploadPatientSingleImage(
                            paramName: 'patient_inter_gauche', file: file);
                        ctrl.update();
                      });
                },
              ),
            ],
          ),
          5.space(),
          "Radios".appCommonText(
            align: TextAlign.start,
            size: 24,
            maxLine: 2,
            overflow: TextOverflow.ellipsis,
            weight: FontWeight.w500,
            color: Colors.black,
          ),
          "(.jpg & .heif format)".appCommonText(
            align: TextAlign.start,
            size: 16,
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
                  child: Container(
                height: 135,
                width: 200,
                child: ((ctrl.radiosFirstImageFile != null &&
                        ctrl.radiosFirstImageFile?.path != "")
                    ? HomeImage.fileImage(
                        path: ctrl.radiosFirstImageFile!.path,
                        height: 135,
                        width: 200,
                        shape: BoxShape.rectangle,
                        fit: BoxFit.cover,
                        radius: BorderRadius.circular(10),
                      )
                    : HomeImage.assetImage(
                        path: Assets.images.imgTab.path,
                        height: 135,
                        shape: BoxShape.rectangle,
                        // fit: BoxFit.cover,
                        width: 200,
                      )),
              ).onClick(
                () {
                  imageUploadUtils.openImageChooser(
                      context: Get.context!,
                      onImageChose: (File? file) async {
                        // ctrl.cuisinePhoto?[0] =(file!);
                        ctrl.radiosFirstImageFile = file!;
                        ctrl.uploadPatientSingleImage(
                            paramName: 'patient_panoramique', file: file);
                        ctrl.update();
                      });
                },
              )),
              15.space(),
              /*Expanded(
                child: Image.asset(
                  Assets.images.imgTab.path,
                  height: 135,
                  width: 200,
                ),
              ),*/
              Expanded(
                child: Container(
                  height: 135,
                  width: 200,
                  child: ((ctrl.radiosSecondImageFile != null &&
                          ctrl.radiosSecondImageFile?.path != "")
                      ? HomeImage.fileImage(
                          path: ctrl.radiosSecondImageFile!.path,
                          height: 135,
                          width: 200,
                          shape: BoxShape.rectangle,
                          fit: BoxFit.cover,
                          radius: BorderRadius.circular(10),
                        )
                      : HomeImage.assetImage(
                          path: Assets.images.imgTab.path,
                          height: 135,
                          width: 200,
                          shape: BoxShape.rectangle,
                          // fit: BoxFit.cover,
                        )),
                ).onClick(
                  () {
                    imageUploadUtils.openImageChooser(
                        context: Get.context!,
                        onImageChose: (File? file) async {
                          // ctrl.cuisinePhoto?[0] =(file!);
                          ctrl.radiosSecondImageFile = file!;
                          ctrl.uploadPatientSingleImage(
                              paramName: 'patient_cephalometrique', file: file);
                          ctrl.update();
                        });
                  },
                ),
              ),
            ],
          ),
          10.space(),
          "STL Files".appCommonText(
            align: TextAlign.start,
            size: 24,
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
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: ctrl.isUploadStl ? primaryBrown : Colors.white,
                      border: Border.all(
                          color: ctrl.isUploadStl ? Colors.white : skyColor,
                          width: 1),
                      borderRadius: BorderRadius.circular(25)),
                  child: 'Upload STL'.appCommonText(
                      align: TextAlign.center,
                      color: ctrl.isUploadStl ? Colors.white : darkSkyColor,
                      size: 16),
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
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: !ctrl.isUploadStl ? primaryBrown : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          color: !ctrl.isUploadStl ? Colors.white : skyColor,
                          width: 1)),
                  child: 'Posted by 3shape'.appCommonText(
                      align: TextAlign.center,
                      color: !ctrl.isUploadStl ? Colors.white : darkSkyColor,
                      size: 16,
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
                    "Upper Jaw STL File".appCommonText(
                        size: 14,
                        weight: FontWeight.w400,
                        align: TextAlign.start),
                    3.space(),
                    "*"
                        .appCommonText(
                            size: 14,
                            weight: FontWeight.w400,
                            color: Colors.red,
                            align: TextAlign.start)
                        .paddingOnly(bottom: 5)
                  ],
                ),
                AppTextField(
                  textEditingController: TextEditingController(
                      text: ctrl.upperJawImageFile != null
                          ? ctrl.upperJawImageFile!.path.substring(
                              ctrl.upperJawImageFile!.path.length - 20)
                          : ''),
                  onChanged: (value) {},
                  validator: (value) {},
                  textFieldPadding: EdgeInsets.zero,
                  keyboardType: TextInputType.text,
                  readOnly: true,
                  showCursor: false,
                  isError: ctrl.lastNameError,
                  prefixIcon: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    alignment: Alignment.center,
                    width: 100,
                    decoration: BoxDecoration(
                        color: primaryBrown,
                        borderRadius: BorderRadius.circular(25)),
                    child: "Choose File".appCommonText(
                        size: 14, color: Colors.white, align: TextAlign.center),
                  )
                      .onClick(
                        () {
                          imageUploadUtils.openImageChooser(
                              context: Get.context!,
                              onImageChose: (File? file) async {
                                // ctrl.cuisinePhoto?[0] =(file!);
                                ctrl.upperJawImageFile = file!;
                                ctrl.uploadPatientSingleImage(
                                    paramName: 'upper_jaw_stl_file',
                                    file: file);
                                ctrl.update();
                              });
                        },
                      )
                      .paddingSymmetric(vertical: 7)
                      .paddingOnly(left: 10, right: 6),
                  hintText: "No file chosen",
                  // labelText: "Upper Jaw STL File*",
                  showPrefixIcon: false,
                ),
                10.space(),
                Row(
                  children: [
                    "Lower Jaw STL File".appCommonText(
                        size: 14,
                        weight: FontWeight.w400,
                        align: TextAlign.start),
                    3.space(),
                    "*"
                        .appCommonText(
                            size: 14,
                            weight: FontWeight.w400,
                            color: Colors.red,
                            align: TextAlign.start)
                        .paddingOnly(bottom: 5)
                  ],
                ),
                AppTextField(
                  textEditingController: TextEditingController(
                      text: ctrl.lowerJawImageFile != null
                          ? ctrl.lowerJawImageFile!.path.substring(
                              ctrl.lowerJawImageFile!.path.length - 20)
                          : ''),
                  onChanged: (value) {},
                  validator: (value) {},
                  textFieldPadding: EdgeInsets.zero,
                  keyboardType: TextInputType.text,
                  isError: ctrl.lastNameError,
                  prefixIcon: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    alignment: Alignment.center,
                    width: 100,
                    decoration: BoxDecoration(
                        color: primaryBrown,
                        borderRadius: BorderRadius.circular(25)),
                    child: "Choose File".appCommonText(
                        size: 14, color: Colors.white, align: TextAlign.center),
                  )
                      .onClick(
                        () {
                          imageUploadUtils.openImageChooser(
                              context: Get.context!,
                              onImageChose: (File? file) async {
                                // ctrl.cuisinePhoto?[0] =(file!);
                                ctrl.lowerJawImageFile = file!;
                                ctrl.uploadPatientSingleImage(
                                    paramName: 'lower_jaw_stl_file',
                                    file: file);
                                ctrl.update();
                              });
                        },
                      )
                      .paddingSymmetric(vertical: 7)
                      .paddingOnly(left: 10, right: 6),
                  hintText: "No file chosen",
                  // labelText: "Upper Jaw STL File*",
                  showPrefixIcon: false,
                ),
              ],
            ),
          ),
          10.space(),
          "CBCT / DICOM".appCommonText(
            align: TextAlign.start,
            size: 24,
            maxLine: 2,
            overflow: TextOverflow.ellipsis,
            weight: FontWeight.w500,
            color: Colors.black,
          ),
          10.space(),
          DottedBorder(
            borderType: BorderType.RRect,
            color: primaryBrown,
            padding: EdgeInsets.zero,
            radius: Radius.circular(35),
            dashPattern: [5, 5, 5, 5],
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: primaryBrown.withOpacity(0.08)),
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.icons.icDocument.svg(),
                  10.space(),
                  "Upload DICOM File".appCommonText(
                      size: 16, weight: FontWeight.w400, color: primaryBrown),
                ],
              ),
            ),
          ),
          100.space(),
        ],
      ).paddingSymmetric(horizontal: 15),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 70,
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Expanded(
                child: AppBorderButton(
                  btnHeight: 55,
                  text: "Finish Latter",
                  onTap: () {
                    ctrl.addUpdatePatientDetails(
                        isFromFinishStep: true,
                        draftViewPage: "upload_photo_page");
                  },
                  // boxShadow: [],
                  radius: 25,
                  fontSize: 18,
                  borderColor: primaryBrown,
                  // bgColor: primaryBrown,
                  fontColor: primaryBrown,
                ).paddingOnly(top: 10, right: 5, left: 15),
              ),
              Expanded(
                child: AppButton(
                  btnHeight: 55,
                  text: LocaleKeys.next.translateText,
                  onTap: () {
                    if (ctrl.validateUploadPhotoFiles()) {
                      ctrl.goToStep(3);
                    } else {
                      showAppSnackBar("Please select all required photos");
                    }
                  },
                  boxShadow: [],
                  radius: 25,
                  fontSize: 18,
                  bgColor: primaryBrown,
                  fontColor: Colors.white,
                ).paddingOnly(top: 10, right: 15, left: 5),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget photoCardWidget(
    {required String title,
    required String image,
    required File? fileImage,
    required GestureTapCallback onTap,
    required AddPatientController ctrl}) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ((fileImage != null && fileImage.path != "")
                ? HomeImage.fileImage(
                    path: fileImage.path,
                    size: 123,
                    shape: BoxShape.rectangle,
                    fit: BoxFit.cover,
                    radius: BorderRadius.circular(15),
                  )
                : HomeImage.assetImage(
                    path: image,
                    height: 123,
                    shape: BoxShape.rectangle,
                    width: 123,
                  ))
            .onClick(onTap),
        5.space(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            title.appCommonText(
                size: 16, weight: FontWeight.w300, color: hintStepColor),
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

Widget arcadeTraiter(AddPatientController ctrl) {
  return Stack(
    children: [
      ListView(
        children: [
          5.space(),
          LocaleKeys.arcadeTraiter.translateText
              .appCommonText(
                align: TextAlign.start,
                size: 24,
                maxLine: 2,
                overflow: TextOverflow.ellipsis,
                weight: FontWeight.w500,
                color: Colors.black,
              )
              .paddingSymmetric(horizontal: 15),
          "((ou la simulation sera réalisée)"
              .appCommonText(
                align: TextAlign.start,
                size: 16,
                maxLine: 2,
                overflow: TextOverflow.ellipsis,
                weight: FontWeight.w400,
                color: hintStepColor,
              )
              .paddingSymmetric(horizontal: 15),
          10.space(),
          Container(
            height: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
                border: Border.all(color: skyColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LocaleKeys.lesDeux.translateText
                    .appCommonText(
                      size: 16,
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
            height: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
                border: Border.all(color: skyColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LocaleKeys.maxillaire.translateText
                    .appCommonText(
                      size: 16,
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
            height: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
                border: Border.all(color: skyColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LocaleKeys.mandibulaire.translateText
                    .appCommonText(
                      size: 16,
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
          "Les scans 3D des deux arcades sont nécessaires même si vous choisissez de traiter une seule arcade."
              .appCommonText(
                weight: FontWeight.w400,
                align: TextAlign.start,
                color: Colors.black,
                fontStyle: FontStyle.italic,
                size: 16,
              )
              .paddingSymmetric(horizontal: 15),
          10.space(),
          treatmentGoals(ctrl),
          techniquesPatient(ctrl),
          Divider(
            color: dividerColor,
            height: 2,
            thickness: 3,
          ),
          dentalHistory(ctrl),
          Divider(
            color: dividerColor,
            height: 2,
            thickness: 3,
          ),
          12.space(),
          "Classe Dentaire"
              .appCommonText(
                align: TextAlign.start,
                size: 24,
                maxLine: 2,
                overflow: TextOverflow.ellipsis,
                weight: FontWeight.w500,
                color: Colors.black,
              )
              .paddingSymmetric(horizontal: 15),
          10.space(),
          Container(
            height: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
                border: Border.all(color: skyColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LocaleKeys.maintenir.translateText
                    .appCommonText(
                      size: 16,
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
            height: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
                border: Border.all(color: skyColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LocaleKeys.ameliorerClasses.translateText
                    .appCommonText(
                      size: 16,
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
          "Notes"
              .appCommonText(
                align: TextAlign.start,
                size: 24,
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
                return 'Please enter Date of Birth';
              }
              ctrl.update();
              return null;
            },
            textFieldPadding: EdgeInsets.zero,
            keyboardType: TextInputType.text,
            radius: 20,
            isError: ctrl.emailError,
            hintText: "Saisir une remarque",
            maxLines: 3,
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
          "Milieu Incisif Maxillaire"
              .appCommonText(
                align: TextAlign.start,
                size: 24,
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
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                  border: Border.all(color: skyColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: item.title
                          .appCommonText(
                              size: 16,
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
          "Notes"
              .appCommonText(
                align: TextAlign.start,
                size: 24,
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
                return 'Please enter Date of Birth';
              }
              ctrl.update();
              return null;
            },
            textFieldPadding: EdgeInsets.zero,
            keyboardType: TextInputType.text,
            isError: ctrl.emailError,
            radius: 20,
            hintText: "Saisir une remarque",
            maxLines: 3,
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
          "Autres Recommandations"
              .appCommonText(
                align: TextAlign.start,
                size: 24,
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
                return 'Please enter Date of Birth';
              }
              ctrl.update();
              return null;
            },
            radius: 20,
            textFieldPadding: EdgeInsets.zero,
            keyboardType: TextInputType.text,
            isError: ctrl.emailError,
            hintText: "Saisir une remarque",
            maxLines: 3,
            // labelText: LocaleKeys.deliveryAddress.translateText,
            showPrefixIcon: false,
          ).paddingSymmetric(horizontal: 15),
          100.space(),
        ],
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 70,
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Expanded(
                child: AppBorderButton(
                  btnHeight: 55,
                  text: "Finish Latter",
                  onTap: () {
                    // ctrl.goToStep(1);
                    ctrl.addUpdatePatientDetails(
                        isFromFinishStep: true,
                        draftViewPage: "patient_prescription_page");
                  },
                  // boxShadow: [],
                  radius: 25,
                  fontSize: 18,
                  borderColor: primaryBrown,
                  // bgColor: primaryBrown,
                  fontColor: primaryBrown,
                ).paddingOnly(top: 10, right: 5, left: 15),
              ),
              Expanded(
                child: AppButton(
                  btnHeight: 55,
                  text: "Add",
                  onTap: () {
                    if (ctrl.validateArcadeFields()) {
                      ctrl.addUpdatePatientDetails();
                    } else {
                      showAppSnackBar("Please select all required fields");
                    }
                  },
                  boxShadow: [],
                  radius: 25,
                  fontSize: 18,
                  bgColor: primaryBrown,
                  fontColor: Colors.white,
                ).paddingOnly(top: 10, right: 15, left: 5),
              ),
            ],
          ),
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
      "Techniques Acceptees Pour Ce Patient"
          .appCommonText(
            align: TextAlign.start,
            size: 24,
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
        itemBuilder: (context, index) {
          final item = ctrl.patientTechniquesItems[index];
          return Column(
            children: [
              Container(
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
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
                            size: 16,
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
                  textEditingController: TextEditingController(text: item.note),

                  onChanged: (value) {
                    // item.note = value;
                    ctrl.changePatientNoteText(index, value);
                    print(item.note);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      ctrl.emailError = true;
                      ctrl.update();
                      return 'Please enter Date of Birth';
                    }
                    ctrl.update();
                    return null;
                  },
                  textFieldPadding: EdgeInsets.zero,
                  keyboardType: TextInputType.text,
                  isError: ctrl.emailError,
                  hintText: "Saisir une remarque",
                  maxLines: 3,
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
      "Notes"
          .appCommonText(
            align: TextAlign.start,
            size: 24,
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
            return 'Please enter Date of Birth';
          }
          ctrl.update();
          return null;
        },
        textFieldPadding: EdgeInsets.zero,
        keyboardType: TextInputType.text,
        isError: ctrl.emailError,
        radius: 20,
        hintText: "Saisir une remarque",
        maxLines: 3,
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
      "Historique Dentaire"
          .appCommonText(
            align: TextAlign.start,
            size: 24,
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
        itemBuilder: (context, index) {
          final item = ctrl.dentalHistoryItems[index];
          return Column(
            children: [
              Container(
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
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
                              size: 16,
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
                  textEditingController: TextEditingController(text: item.note),
                  radius: 20,
                  onChanged: (value) {
                    ctrl.changeDentalHistoryNoteText(index, value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      ctrl.emailError = true;
                      ctrl.update();
                      return 'Please enter Date of Birth';
                    }
                    ctrl.update();
                    return null;
                  },
                  textFieldPadding: EdgeInsets.zero,
                  keyboardType: TextInputType.text,
                  isError: ctrl.emailError,
                  hintText: "Saisir une remarque",
                  maxLines: 3,
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
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          border: Border.all(color: skyColor),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Yes",
                              style: TextStyle(
                                fontSize: 16,
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
                    Expanded(
                        child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        border: Border.all(color: skyColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "No",
                            style: TextStyle(
                              fontSize: 16,
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
      "Notes"
          .appCommonText(
            align: TextAlign.start,
            size: 24,
            maxLine: 2,
            overflow: TextOverflow.ellipsis,
            weight: FontWeight.w500,
            color: Colors.black,
          )
          .paddingSymmetric(horizontal: 15),
      AppTextField(
        textEditingController: ctrl.dentalHistoryNoteCtrl,
        onChanged: (value) {},
        radius: 20,
        validator: (value) {
          if (value.isEmpty) {
            ctrl.emailError = true;
            ctrl.update();
            return 'Please enter Date of Birth';
          }
          ctrl.update();
          return null;
        },
        textFieldPadding: EdgeInsets.zero,
        keyboardType: TextInputType.text,
        isError: ctrl.emailError,
        hintText: "Saisir une remarque",
        maxLines: 3,
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
      "Recouvrement Incisives (Supraclusion)"
          .appCommonText(
            align: TextAlign.start,
            size: 24,
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
        itemBuilder: (context, index) {
          final item = ctrl.incisorCoveringItems[index];
          return Container(
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
              border: Border.all(color: skyColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: item.title
                      .appCommonText(
                          size: 16,
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
      "Notes"
          .appCommonText(
            align: TextAlign.start,
            size: 24,
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
            return 'Please enter text';
          }
          ctrl.update();
          return null;
        },
        textFieldPadding: EdgeInsets.zero,
        keyboardType: TextInputType.text,
        isError: ctrl.emailError,
        radius: 20,
        hintText: "Saisir....",
        maxLines: 3,
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
      "Objectifs Du Traitement"
          .appCommonText(
            align: TextAlign.start,
            size: 24,
            maxLine: 2,
            overflow: TextOverflow.ellipsis,
            weight: FontWeight.w500,
            color: Colors.black,
          )
          .paddingSymmetric(horizontal: 15),
      "(demande du patient)"
          .appCommonText(
            align: TextAlign.start,
            size: 16,
            maxLine: 2,
            overflow: TextOverflow.ellipsis,
            weight: FontWeight.w400,
            color: hintStepColor,
          )
          .paddingSymmetric(horizontal: 15),
      10.space(),
      Container(
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
            border: Border.all(color: skyColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: LocaleKeys.alignementEsthetique.translateText
                  .appCommonText(
                    size: 16,
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
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
            border: Border.all(color: skyColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: LocaleKeys.alignementEsthetiqueCorrection.translateText
                  .appCommonText(
                    size: 16,
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
        onChanged: (value) {},
        radius: 20,
        validator: (value) {
          if (value.isEmpty) {
            ctrl.emailError = true;
            ctrl.update();
            return 'Please enter address';
          }
          ctrl.update();
          return null;
        },
        textFieldPadding: EdgeInsets.zero,
        keyboardType: TextInputType.text,
        isError: ctrl.emailError,
        hintText: "Saisir une remarque",
        maxLines: 3,
        labelText: LocaleKeys.deliveryAddress.translateText,
        showPrefixIcon: false,
      ).paddingSymmetric(horizontal: 15),
    ],
  );
}
