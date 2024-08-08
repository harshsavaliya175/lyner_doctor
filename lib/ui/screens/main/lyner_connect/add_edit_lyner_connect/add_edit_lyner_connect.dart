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
import 'package:lynerdoctor/ui/widgets/app_progress_view.dart';
import 'package:lynerdoctor/ui/widgets/common_dialog.dart';

class AddEditLynerConnect extends StatelessWidget {
  AddEditLynerConnect({super.key});

  AddEditLynerController controller = Get.put(AddEditLynerController());

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
        leadingWidth: !isTablet ? 40 : 50,
        leading: Assets.icons.icBack
            .svg(
              height: !isTablet ? 25 : 30,
              width: !isTablet ? 25 : 30,
              fit: !isTablet ? BoxFit.scaleDown : BoxFit.fill,
            )
            .paddingOnly(
                left: 10, top: isTablet ? 22 : 0, bottom: isTablet ? 22 : 0)
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
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter email address';
                      } else if (!ctrl.emailController.text.isValidEmail()) {
                        return 'Please enter valid email';
                      }
                      ctrl.update();
                      return null;
                    },
                    textFieldPadding: EdgeInsets.zero,
                    keyboardType: TextInputType.text,
                    hintText: LocaleKeys.enterEmailAddress.translateText,
                    labelText: LocaleKeys.emailAddress.translateText,
                    showPrefixIcon: false,
                  ),
                  15.space(),
                  AppTextField(
                    validator: (value) {
                      // if (value.isEmpty) {
                      //   ctrl.update();
                      //   return 'Please enter mobile number';
                      // }
                      // ctrl.update();
                      // return null;
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
                    onChanged: (String value) {},
                  ),
                  15.space(),
                  AppTextField(
                    validator: (value) {
                      if (value.isEmpty) {
                        ctrl.update();
                        return 'Please enter current aligner';
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
                    onChanged: (String value) {},
                  ),
                  15.space(),
                  AppTextField(
                    textEditingController: ctrl.totalAlignerController,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter total aligner';
                      }
                      ctrl.update();
                      return null;
                    },
                    textFieldPadding: EdgeInsets.zero,
                    keyboardType: TextInputType.text,
                    // isError: ctrl.emailError,
                    hintText: "Enter total aligner",
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
                        return 'Please enter aligner days';
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
                    textEditingController: ctrl.alignerDaysController,
                    labelText: "Aligner Days",
                    showPrefixIcon: false,
                    onChanged: (String value) {},
                  ),
                  15.space(),
                  AppTextField(
                    textEditingController: ctrl.treatmentStartDateController,
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
                        ctrl.update();
                        return 'Please enter treatment start date';
                      }
                      ctrl.update();
                      return null;
                    },
                    onTap: () async {
                      ctrl.pickedDate = await datePickerDialog(Get.context!);
                      if (ctrl.pickedDate != null) {
                        // ctrl.dateText = ctrl.pickedDate;
                        ctrl.dateTextField =
                            DateFormat('dd-MM-yyyy').format(ctrl.pickedDate!);
                        ctrl.treatmentStartDateController.text =
                            ctrl.dateTextField!;
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
                height: !isTablet ? 70 : 80,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: AppButton(
                  btnHeight: !isTablet ? 55 : 65,
                  text: controller.isFromNewPatient
                      ? LocaleKeys.add.translateText
                      : "Update",
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (ctrl.patientInformationFormKey.currentState!
                        .validate()) {
                      FocusScope.of(Get.context!).unfocus();
                      ctrl.addLynerConnectDetails();
                    }
                  },
                  boxShadow: [],
                  radius: !isTablet ? 25 : 40,
                  fontSize: !isTablet ? 20 : 24,
                  bgColor: primaryBrown,
                  fontColor: Colors.white,
                ).paddingOnly(top: 10).paddingSymmetric(horizontal: 15),
              ),
            ),
            Visibility(visible: ctrl.isLoading, child: AppProgressView())
          ],
        );
      }),
    );
  }
}
