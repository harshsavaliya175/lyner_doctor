import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/step_indicator.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/add_patient/add_patient_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_bar.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';
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
          leadingWidth: 45,
          leading: Assets.icons.icBack
              .svg(
                height: 25,
                width: 25,
              )
              .paddingOnly(
                left: 10,
              )
              .onClick(() {
            Get.back();
          }),
        ),
        body: GetBuilder<AddPatientController>(builder: (ctrl) {
          return Container(
            color: appBgColor,
            child: Column(
              children: [
                10.space(),
                CommonStepIndicator(
                  totalSteps: 4,
                  currentStep: ctrl.currentStep,
                  onStepTapped: (index) {
                    ctrl.goToStep(index);
                  },
                ),
                10.space(),
                Expanded(
                  child: PageView(
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
              final isSelected = ctrl.selectedProduct.value == product;
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
                                color: isSelected
                                    ? primaryBrown
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: primaryBrown, width: 1),
                              ),
                              child: Center(
                                child: isSelected
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
                          color: isSelected ? primaryBrown : skyColor,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(13),
                              bottomLeft: Radius.circular(13)),
                        ),
                        child: Center(
                          child: (isSelected
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
              ctrl.goToStep(1);
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
      ListView(
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
                  textEditingController: TextEditingController(text: ''),
                  onChanged: (value) {},
                  validator: (value) {
                    if (value.isEmpty) {
                      // ctrl.firstNameError = true;
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
                  textEditingController: TextEditingController(text: ''),
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
                  isError: ctrl.lastNameError,
                  hintText: LocaleKeys.enterName.translateText,
                  labelText: LocaleKeys.lastName.translateText,
                  showPrefixIcon: false,
                ),
              ),
            ],
          ),
          15.space(),
          AppTextField(
            textEditingController: TextEditingController(text: ''),
            onChanged: (value) {},
            validator: (value) {
              if (value.isEmpty) {
                ctrl.emailError = true;
                ctrl.update();
                return 'Please enter E-mail Address';
              }
              ctrl.update();
              return null;
            },
            textFieldPadding: EdgeInsets.zero,
            keyboardType: TextInputType.text,
            isError: ctrl.emailError,
            hintText: LocaleKeys.enterEmailAddress.translateText,
            labelText: LocaleKeys.emailAddress.translateText,
            showPrefixIcon: false,
          ),
          15.space(),
          AppTextField(
            textEditingController: TextEditingController(text: ''),
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
            hintText: LocaleKeys.dateField.translateText,
            labelText: LocaleKeys.dateOfBirth.translateText,
            showPrefixIcon: false,
          ),
          15.space(),
          AppTextField(
            textEditingController: TextEditingController(text: ''),
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
          15.space(),
          AppTextField(
            textEditingController: TextEditingController(text: ''),
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
          15.space(),
          AppTextField(
            textEditingController: TextEditingController(text: ''),
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
          child: AppButton(
            btnHeight: 55,
            text: LocaleKeys.next.translateText,
            onTap: () {
              ctrl.goToStep(2);
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
                  image: Assets.images.imgProfile.path, title: "Profile"),
              10.space(),
              photoCardWidget(image: Assets.images.imgFace.path, title: "Face"),
              10.space(),
              photoCardWidget(
                  image: Assets.images.imgSmile.path, title: "Smile"),
            ],
          ),
          5.space(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              photoCardWidget(
                  image: Assets.images.imgIntraMax.path, title: "Intra Max"),
              143.space(),
              photoCardWidget(
                  image: Assets.images.imgIntraMand.path, title: "Intra Mand"),
            ],
          ),
          10.space(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              photoCardWidget(
                  image: Assets.images.imgInterRight.path,
                  title: "Inter Right"),
              10.space(),
              photoCardWidget(
                  image: Assets.images.imgInterFace.path, title: "Inter Face"),
              10.space(),
              photoCardWidget(
                  image: Assets.images.imgInterLeft.path, title: "Inter Left"),
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
                child: Image.asset(
                  Assets.images.imgTab.path,
                  width: 200,
                  height: 135,
                ),
              ),
              15.space(),
              Expanded(
                child: Image.asset(
                  Assets.images.imgTab.path,
                  height: 135,
                  width: 200,
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
                      color: primaryBrown,
                      borderRadius: BorderRadius.circular(25)),
                  child: 'Upload STL'.appCommonText(
                      align: TextAlign.center, color: Colors.white, size: 16),
                ),
              ),
              25.space(),
              Expanded(
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: skyColor, width: 1)),
                  child: 'Posted by 3shape'.appCommonText(
                      align: TextAlign.center,
                      color: darkSkyColor,
                      size: 16,
                      weight: FontWeight.w400),
                ),
              ),
            ],
          ),
          10.space(),
          Row(
            children: [
              "Upper Jaw STL File".appCommonText(
                  size: 14, weight: FontWeight.w400, align: TextAlign.start),
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
            textEditingController: TextEditingController(text: ''),
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
                  color: primaryBrown, borderRadius: BorderRadius.circular(25)),
              child: "Choose File".appCommonText(
                  size: 14, color: Colors.white, align: TextAlign.center),
            ).paddingSymmetric(vertical: 7).paddingOnly(left: 10, right: 6),
            hintText: "No file chosen",
            // labelText: "Upper Jaw STL File*",
            showPrefixIcon: false,
          ),
          10.space(),
          Row(
            children: [
              "Lower Jaw STL File".appCommonText(
                  size: 14, weight: FontWeight.w400, align: TextAlign.start),
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
            textEditingController: TextEditingController(text: ''),
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
                  color: primaryBrown, borderRadius: BorderRadius.circular(25)),
              child: "Choose File".appCommonText(
                  size: 14, color: Colors.white, align: TextAlign.center),
            ).paddingSymmetric(vertical: 7).paddingOnly(left: 10, right: 6),
            hintText: "No file chosen",
            // labelText: "Upper Jaw STL File*",
            showPrefixIcon: false,
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
                    ctrl.goToStep(1);
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
                    ctrl.goToStep(1);
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

Widget photoCardWidget({required String title, required String image}) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          image,
          height: 123,
          width: 123,
        ),
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
                "Les deux"
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
                "Maxillaire"
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
                "Mandibulaire"
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
                "Maintenir"
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
                "Améliorer vers classe 1"
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
            textEditingController: TextEditingController(text: ''),
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
                    Text(
                      item.title,
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
            textEditingController: TextEditingController(text: ''),
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
            textEditingController: TextEditingController(text: ''),
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
                    ctrl.goToStep(1);
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
                    ctrl.goToStep(1);
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
                    Text(
                      item.title,
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
                  textEditingController: TextEditingController(text: ''),
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
                  hintText: "Saisir une remarque",
                  maxLines: 3,
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
        textEditingController: TextEditingController(text: ''),
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
                    Text(
                      item.title,
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
                        color: item.isSelected
                            ? primaryBrown
                            : Colors.transparent,
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
                  textEditingController: TextEditingController(text: ''),
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
                                border: Border.all(
                                    color: primaryBrown, width: 1),
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
                                  border:
                                  Border.all(color: primaryBrown, width: 1),
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
        textEditingController: TextEditingController(text: ''),
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
        textEditingController: TextEditingController(text: ''),
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
            "Les deux"
                .appCommonText(
              size: 16,
              weight: FontWeight.w400,
              color: Colors.black,
            )
                .paddingOnly(left: 15),
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
            "Maxillaire"
                .appCommonText(
              size: 16,
              weight: FontWeight.w400,
              color: Colors.black,
            )
                .paddingOnly(left: 15),
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
        textEditingController: TextEditingController(text: ''),
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
        hintText: "Saisir une remarque",
        maxLines: 3,
        labelText: LocaleKeys.deliveryAddress.translateText,
        showPrefixIcon: false,
      ).paddingSymmetric(horizontal: 15),
    ],
  );
}