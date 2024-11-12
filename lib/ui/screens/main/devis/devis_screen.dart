import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/devis/devis_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';
import 'package:lynerdoctor/ui/widgets/app_progress_view.dart';
import 'package:lynerdoctor/ui/widgets/common_dialog.dart';

class DevisScreen extends StatelessWidget {
  DevisScreen({super.key});

  final DevisController ctrl = Get.put(DevisController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: false,
        title: Text(
          LocaleKeys.devis.translateText,
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
      body: GetBuilder<DevisController>(
        builder: (DevisController ctrl) {
          return Stack(
            children: [
              Form(
                key: ctrl.patientInformationFormKey,
                child: ListView(
                  padding: EdgeInsets.only(
                      left: 20, right: 20, bottom: 120, top: 20),
                  children: [
                    !isTablet ? 5.space() : 10.space(),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            textEditingController: ctrl.firstNameController,
                            onChanged: (String value) {},
                            validator: (String value) {
                              if (value.isEmpty) {
                                ctrl.firstNameError = true;
                                ctrl.update();
                                return LocaleKeys
                                    .pleaseEnterFirstname.translateText;
                              }
                              ctrl.update();
                              return null;
                            },
                            textFieldPadding: EdgeInsets.zero,
                            keyboardType: TextInputType.text,
                            hintText: LocaleKeys.enterFirstName.translateText,
                            labelText:
                                LocaleKeys.patientFirstName.translateText,
                            showPrefixIcon: false,
                          ),
                        ),
                        10.space(),
                        Expanded(
                          child: AppTextField(
                            textEditingController: ctrl.lastNameController,
                            onChanged: (String value) {},
                            validator: (String value) {
                              if (value.isEmpty) {
                                ctrl.lastNameError = true;
                                ctrl.update();
                                return LocaleKeys
                                    .pleaseEnterLastName.translateText;
                              }
                              ctrl.update();
                              return null;
                            },
                            textFieldPadding: EdgeInsets.zero,
                            keyboardType: TextInputType.text,
                            // isError: ctrl.lastNameError,
                            hintText: LocaleKeys.enterLastName.translateText,
                            labelText: LocaleKeys.patientLastName.translateText,
                            showPrefixIcon: false,
                          ),
                        ),
                      ],
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
                      textEditingController: ctrl.emailController,
                      onChanged: (String value) {},
                      validator: (String value) {
                        if (value.isEmpty) {
                          ctrl.emailError = true;
                          ctrl.update();
                          return LocaleKeys.pleaseEnterEmail.translateText;
                        } else if (!(value.isValidEmail())) {
                          ctrl.emailError = true;
                          ctrl.update();
                          return LocaleKeys.pleaseEnterValidEmail.translateText;
                        }
                        ctrl.update();
                        return null;
                      },
                      textFieldPadding: EdgeInsets.zero,
                      keyboardType: TextInputType.text,
                      // isError: ctrl.emailError,
                      hintText: LocaleKeys.enterPatientEmail.translateText,
                      labelText: LocaleKeys.patientEmail.translateText,
                      showPrefixIcon: false,
                    ),
                    15.space(),
                    AppTextField(
                      textEditingController: ctrl.totalAmountController,
                      onChanged: (String value) {},
                      validator: (String value) {
                        if (value.isEmpty) {
                          ctrl.totalAmountError = true;
                          ctrl.update();
                          return LocaleKeys
                              .pleaseEnterTotalAmount.translateText;
                        }
                        ctrl.update();
                        return null;
                      },
                      textFieldPadding: EdgeInsets.zero,
                      keyboardType: TextInputType.number,
                      // isError: ctrl.emailError,
                      hintText: LocaleKeys.enterAmount.translateText,
                      labelText: LocaleKeys.totalAmount.translateText,
                      showPrefixIcon: false,
                    ),
                    15.space(),
                    AppTextField(
                      textEditingController: ctrl.numberOfSemesterController,
                      onChanged: (String value) {},
                      validator: (String value) {
                        if (value.isEmpty) {
                          ctrl.numberOfSemesterError = true;
                          ctrl.update();
                          return LocaleKeys
                              .pleaseSelectNumberOfSemester.translateText;
                        }
                        ctrl.update();
                        return null;
                      },
                      onTap: () {
                        ctrl.showNumberOfSemesterDropDown =
                            !ctrl.showNumberOfSemesterDropDown;
                        ctrl.update();
                      },
                      readOnly: true,
                      showCursor: false,
                      textFieldPadding: EdgeInsets.zero,
                      keyboardType: TextInputType.text,
                      // isError: ctrl.emailError,
                      hintText: LocaleKeys.select.translateText,
                      labelText: LocaleKeys.numberOfSemester.translateText,
                      showPrefixWidget: Assets.icons.icDown
                          .svg(
                            height: 10,
                            width: 10,
                          )
                          .paddingOnly(left: 15, right: 15),
                      showPrefixIcon: true,
                    ),
                    Visibility(
                      visible: ctrl.showNumberOfSemesterDropDown,
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
                            String data = ctrl.numberOfSemester[index];
                            return InkWell(
                              onTap: () {
                                print("onTap : $index");
                                ctrl.showNumberOfSemesterDropDown =
                                    !ctrl.showNumberOfSemesterDropDown;
                                ctrl.numberOfSemesterController.text =
                                    '${data}';
                                ctrl.selectedNumberOfSemester = data;
                                print(ctrl.selectedNumberOfSemester);
                                ctrl.update();
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: '${data}'.appCommonText(
                                      color: Colors.black,
                                      maxLine: 1,
                                      align: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      weight: FontWeight.w400,
                                      size: !isTablet ? 15 : 18,
                                    ),
                                  ),
                                  if (ctrl.numberOfSemesterController.text
                                      .contains('${data}')) ...[
                                    Assets.icons.icSelectArrow.svg(
                                        colorFilter: ColorFilter.mode(
                                      primaryBrown,
                                      BlendMode.srcIn,
                                    )),
                                  ] else ...[
                                    const SizedBox.shrink(),
                                  ]
                                ],
                              ).paddingOnly(
                                  left: 20, right: 20, top: 10, bottom: 10),
                            );
                          },
                          itemCount: ctrl.numberOfSemester.length,
                        ).paddingOnly(top: 5, bottom: 5),
                      ).paddingOnly(top: 15),
                    ),
                    15.space(),
                    AppTextField(
                      textEditingController: ctrl.contentionPriceController,
                      onChanged: (String value) {},
                      validator: (String value) {
                        if (value.isEmpty) {
                          ctrl.connectionError = true;
                          ctrl.update();
                          return LocaleKeys
                              .pleaseEnterContentionPrice.translateText;
                        }
                        ctrl.update();
                        return null;
                      },
                      textFieldPadding: EdgeInsets.zero,
                      keyboardType: TextInputType.number,
                      // isError: ctrl.emailError,
                      hintText: LocaleKeys.enterContentionPrice.translateText,
                      labelText: LocaleKeys.contentionPrice.translateText,
                      showPrefixIcon: false,
                    ),
                    20.space(),
                  ],
                ),
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
                    text: LocaleKeys.export.translateText,
                    onTap: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (ctrl.patientInformationFormKey.currentState!
                          .validate()) {
                        FocusScope.of(Get.context!).unfocus();

                        ctrl.getLynerConnectList(context);
                      }
                    },
                    boxShadow: [],
                    radius: 40,
                    fontSize: !isTablet ? 20 : 25,
                    bgColor: primaryBrown,
                    fontColor: Colors.white,
                  )
                      .paddingOnly(top: 10, bottom: 10)
                      .paddingSymmetric(horizontal: 15),
                ),
              ),
              GetBuilder<DevisController>(
                builder: (DevisController controller) {
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
