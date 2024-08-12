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

  final AddEditLynerController controller = Get.put(AddEditLynerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: appbarWithIcons(
        centerTitle: false,
        title: Text(
          controller.isFromNewPatient
              ? LocaleKeys.addLynerConnect.translateText
              : LocaleKeys.editLynerConnect.translateText,
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
                              return LocaleKeys.pleaseEnterFirstName.translateText;
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
                    onChanged: (value) {},
                    validator: (value) {
                      if (value.isEmpty) {
                        return LocaleKeys.pleaseEnterEmail.translateText;
                      } else if (!ctrl.emailController.text.isValidEmail()) {
                        return LocaleKeys.pleaseEnterValidEmail.translateText;
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
                    hintText: LocaleKeys.pleaseEnterPhoneNumber.translateText,
                    textEditingController: ctrl.mobileNumController,
                    labelText: LocaleKeys.phoneNumber.translateText,
                    showPrefixIcon: false,
                    onChanged: (String value) {},
                  ),
                  15.space(),
                  AppTextField(
                    validator: (value) {
                      if (value.isEmpty) {
                        ctrl.update();
                        return LocaleKeys.pleaseEnterCurrentAligner.translateText;
                      }
                      ctrl.update();
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    textFieldPadding: EdgeInsets.zero,
                    inputFormatter: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    hintText: LocaleKeys.enterCurrentAligner.translateText,
                    textEditingController: ctrl.currentAlignerController,
                    labelText: LocaleKeys.currentAligner.translateText,
                    showPrefixIcon: false,
                    onChanged: (String value) {},
                  ),
                  15.space(),
                  AppTextField(
                    textEditingController: ctrl.totalAlignerController,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value.isEmpty) {
                        return LocaleKeys.enterTotalAligner.translateText;
                      }
                      ctrl.update();
                      return null;
                    },
                    textFieldPadding: EdgeInsets.zero,
                    keyboardType: TextInputType.text,
                    // isError: ctrl.emailError,
                    hintText: LocaleKeys.enterTotalAligner.translateText,
                    labelText:LocaleKeys.totalAligner.translateText,
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
                        return LocaleKeys.pleaseEnterAlignerDays.translateText;
                      }
                      ctrl.update();
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    textFieldPadding: EdgeInsets.zero,
                    inputFormatter: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    hintText: LocaleKeys.enterAlignerDays.translateText,
                    textEditingController: ctrl.alignerDaysController,
                    labelText:LocaleKeys.alignerDays.translateText,
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
                        return LocaleKeys.pleaseEnterTreatmentStartDate.translateText;
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
                    labelText:LocaleKeys.treatmentStartDate.translateText,
                    showPrefixIcon: false,
                  ),
                  100.space(),
                ],
              ).paddingSymmetric(horizontal: 15),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: !isTablet ? 80 : 90,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: AppButton(
                  btnHeight: !isTablet ? 55 : 65,
                  text: controller.isFromNewPatient
                      ? LocaleKeys.add.translateText
                      : LocaleKeys.update.translateText,
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (ctrl.patientInformationFormKey.currentState!
                        .validate()) {
                      FocusScope.of(Get.context!).unfocus();
                      ctrl.isFromNewPatient
                          ? ctrl.addLynerConnectDetails()
                          : ctrl.editLynerConnectDetails();
                    }
                  },
                  boxShadow: [],
                  radius: !isTablet ? 25 : 40,
                  fontSize: !isTablet ? 20 : 24,
                  bgColor: primaryBrown,
                  fontColor: Colors.white,
                ).paddingOnly(top: 10,bottom: 10).paddingSymmetric(horizontal: 15),
              ),
            ),
            Visibility(visible: ctrl.isLoading, child: AppProgressView())
          ],
        );
      }),
    );
  }
}
