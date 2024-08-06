import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/lyner_connect/add_edit_lyner_connect/add_edit_lyner_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_bar.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';
import 'package:lynerdoctor/ui/widgets/common_dialog.dart';

class AddEditLynerConnect extends StatelessWidget {
  AddEditLynerConnect({super.key});

  var controller = Get.put(AddEditLynerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: appbarWithIcons(
        centerTitle: false,
        title: Text(
          controller.isFromNewPatient
              ? LocaleKeys.addLynerConnect.translateText
              : "Edit Lyner connect",
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
      body: GetBuilder<AddEditLynerController>(builder: (ctrl) {
        return Stack(
          children: [
            Form(
              key: ctrl.patientInformationFormKey,
              child: ListView(
                children: [
                  15.space(),
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
                    validator: (value) {
                      if (value.isEmpty) {
                        ctrl.update();
                        return 'Please enter mobile number';
                      }
                      ctrl.update();
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    textFieldPadding: EdgeInsets.zero,
                    inputFormatter: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    hintText: "Enter mobile number",
                    textEditingController: ctrl.mobileNumController,
                    labelText: "Phone Number",
                    showPrefixIcon: false,
                    isError: ctrl.mobileNumError,
                    onChanged: (String value) {},
                  ),
                  15.space(),
                  AppTextField(
                    validator: (value) {
                      if (value.isEmpty) {
                        ctrl.update();
                        return 'Please enter mobile number';
                      }
                      ctrl.update();
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    textFieldPadding: EdgeInsets.zero,
                    inputFormatter: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    hintText: "Enter current aligner",
                    textEditingController: ctrl.currentAlignerController,
                    labelText: "Current Aligner",
                    showPrefixIcon: false,
                    isError: ctrl.mobileNumError,
                    onChanged: (String value) {},
                  ),
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
                      // ctrl.showDoctorDropDown = !ctrl.showDoctorDropDown;
                      // ctrl.update();
                    },
                    textFieldPadding: EdgeInsets.zero,
                    keyboardType: TextInputType.text,
                    // isError: ctrl.emailError,
                    hintText: "Select total aligner",
                    labelText: "Total Aligner",
                    showPrefixWidget: Assets.icons.icDown
                        .svg(
                      colorFilter: ColorFilter.mode(
                        primaryBrown,
                        BlendMode.srcIn,
                      ),
                          height: 10,
                          width: 10,
                        )
                        .paddingOnly(left: 15, right: 15),
                    showPrefixIcon: true,
                  ),
                  15.space(),
                  AppTextField(
                    validator: (value) {
                      if (value.isEmpty) {
                        ctrl.update();
                        return 'Please enter mobile number';
                      }
                      ctrl.update();
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    textFieldPadding: EdgeInsets.zero,
                    inputFormatter: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    hintText: "Enter aligner days",
                    textEditingController: ctrl.currentAlignerController,
                    labelText: "Aligner Days",
                    showPrefixIcon: false,
                    isError: ctrl.mobileNumError,
                    onChanged: (String value) {},
                  ),
                  15.space(),
                  AppTextField(
                    textEditingController: ctrl.dateOfBirthController,
                    // onChanged: (value) {},
                    readOnly: true,
                    showCursor: false,
                    showPrefixWidget: Assets.icons.icCalendar
                        .svg(
                          height: 15,
                          width: 15,
                        )
                        .paddingOnly(right: 12, top: 14, bottom: 14),
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
                    labelText: "Treatment Start Date",
                    showPrefixIcon: false,
                  ),
                  100.space(),
                ],
              ).paddingSymmetric(horizontal: 15),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: !isTablet ?70:80,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: AppButton(
                  btnHeight: !isTablet ?55:65,
                  text: controller.isFromNewPatient
                      ? LocaleKeys.add.translateText
                      : "Update",
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (ctrl.patientInformationFormKey.currentState!
                        .validate()) {
                      FocusScope.of(Get.context!).unfocus();
                    }
                  },
                  boxShadow: [],
                  radius: !isTablet ?25:40,
                  fontSize: !isTablet ?20:24,
                  bgColor: primaryBrown,
                  fontColor: Colors.white,
                ).paddingOnly(top: 10).paddingSymmetric(horizontal: 15),
              ),
            ),
          ],
        );
      }),
    );
  }
}
