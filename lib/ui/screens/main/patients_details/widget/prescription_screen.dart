import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/model/prescription_model.dart';
import 'package:lynerdoctor/ui/screens/main/patients_details/patients_details_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_patient_detail_card.dart';

class PrescriptionScreen extends StatelessWidget {
  const PrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.space(),
          LocaleKeys.prescription.translateText
              .normalText(fontWeight: FontWeight.w600),
          6.space(),
          Expanded(
            child: GetBuilder<PatientsDetailsController>(
              builder: (PatientsDetailsController controller) {
                PrescriptionData? prescription = controller.prescriptionData;
                return ListView(
                  padding: EdgeInsets.only(top: 8, bottom: 50),
                  children: [
                    AppPatientDetailCard(
                      title: LocaleKeys.arcadeToTreat.translateText,
                      subTitle: LocaleKeys
                          .whereTheSimulationWillBeCarriedOut.translateText,
                      isShowSubTitle: true,
                      description: prescription?.arcadeToBeTreated ?? "",
                      isShowBottomWidget: true,
                      bottomText: LocaleKeys
                          .threeDScansOfBothArchesAreNecessaryEvenIfYouChooseToTreatOnlyOneArch
                          .translateText,
                    ),
                    12.space(),
                    AppPatientDetailCard(
                      title: LocaleKeys.treatmentGoals.translateText,
                      subTitle: LocaleKeys.patientRequest.translateText,
                      isShowSubTitle: true,
                      description: prescription?.treatmentObjectives ?? "",
                      isShowBottomWidget: false,
                      isShowNote: true,
                      note: prescription?.treatmentNotes ?? "",
                    ),
                    12.space(),
                    AppPatientDetailCard(
                      title: LocaleKeys
                          .acceptedTechniquesForThisPatient.translateText,
                      subTitle: LocaleKeys.patientRequest.translateText,
                      isShowSubTitle: true,
                      description: prescription?.acceptedTechniques ?? "",
                      isShowBottomWidget: false,
                      isShowNote: true,
                      note: prescription?.acceptedTechniqueNote ?? "",
                    ),
                    12.space(),
                    AppPatientDetailCard(
                      title: LocaleKeys.dentalHistory.translateText,
                      isShowSubTitle: false,
                      description: prescription?.dentalHistory ?? "",
                      isShowBottomWidget: false,
                      isShowNote: true,
                      note: prescription?.dentalHistoryNote ?? "",
                    ),
                    12.space(),
                    AppPatientDetailCard(
                      title: LocaleKeys.dentalClass.translateText,
                      isShowSubTitle: false,
                      description: prescription?.dentalClass ?? "",
                      isShowBottomWidget: false,
                      isShowNote: true,
                      note: prescription?.dentalNote ?? "",
                    ),
                    12.space(),
                    AppPatientDetailCard(
                      title: LocaleKeys.middleMaxillaryIncisor.translateText,
                      isShowSubTitle: false,
                      description: prescription?.maxillaryIncisalMiddle ?? "",
                      isShowBottomWidget: false,
                      isShowNote: true,
                      note: prescription?.maxillaryIncisalNote ?? "",
                    ),
                    12.space(),
                    AppPatientDetailCard(
                      title: LocaleKeys.incisorCoveringOverbite.translateText,
                      isShowSubTitle: false,
                      description: prescription?.incisiveCovering ?? "",
                      isShowBottomWidget: false,
                      isShowNote: true,
                      note: prescription?.incisiveCoveringNote ?? "",
                    ),
                    12.space(),
                    AppPatientDetailCard(
                      title: LocaleKeys.otherRecommendations.translateText,
                      isShowSubTitle: false,
                      description: prescription?.otherRecommendations ?? "",
                      isShowBottomWidget: false,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
