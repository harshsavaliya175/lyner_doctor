import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/step_indicator.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/ui/screens/main/add_patient/add_patient_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_bar.dart';

class AddPatientScreen extends StatelessWidget {
  AddPatientScreen({super.key});

  final controller = Get.put(AddPatientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarWithIcons(
          centerTitle: false,
          title: Text(
            "Add Patient",
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
          return Column(
            children: [
              10.space(),
              CommonStepIndicator(
                totalSteps: 4,
                currentStep: ctrl.currentStep,
                onStepTapped: (index) {
                  ctrl.goToStep(index);
                },
              ),
              Expanded(
                child: PageView(
                  controller: ctrl.pageController,
                  onPageChanged: (index) {
                    ctrl.goToStep(index);
                  },
                  children: [
                    chooseTheProduct(),
                    patientInformation(),
                    uploadPhotographs(),
                    arcadeTraiter(),
                  ],
                ),
              ),
            ],
          );
        }));
  }
}

Widget chooseTheProduct() {
  return ListView(
    children: [
      10.space(),
      "Choose the Product".appCommonText(
        align: TextAlign.start,
        size: 24,
        weight: FontWeight.w500,
        color: Colors.black,
      ),
      10.space(),
      Container(
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(13)),
          border: Border.all(color: skyColor,)
        ),
        child: Column(
          children: [
            Container(
              color: primaryBrown.withOpacity(0.2),
              child: Row(
                children: [
                  "LYNER LIGHT".appCommonText(),
                  
                ],
              ).paddingSymmetric(horizontal: 10,vertical: 5),
            )
          ],
        ),
      )
    ],
  ).paddingSymmetric(horizontal: 15);
}
Widget patientInformation() {
  return ListView(
    children: [
      10.space(),
      "Patient Information".appCommonText(
        align: TextAlign.start,
        size: 24,
        weight: FontWeight.w500,
        color: Colors.black,
      ),

    ],
  ).paddingSymmetric(horizontal: 15);
}
Widget uploadPhotographs() {
  return ListView(
    children: [
      10.space(),
      "Upload Photographs".appCommonText(
        align: TextAlign.start,
        size: 24,
        weight: FontWeight.w500,
        color: Colors.black,
      ),

    ],
  ).paddingSymmetric(horizontal: 15);
}
Widget arcadeTraiter() {
  return ListView(
    children: [
      10.space(),
      "Arcade a Traiter".appCommonText(
        align: TextAlign.start,
        size: 24,
        weight: FontWeight.w500,
        color: Colors.black,
      ),

    ],
  ).paddingSymmetric(horizontal: 15);
}
