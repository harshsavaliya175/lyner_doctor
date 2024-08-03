import 'package:flutter/material.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
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
          "Prescription".normalText(fontWeight: FontWeight.w600),
          6.space(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(top: 8, bottom: 50),
              children: [
                AppPatientDetailCard(
                  title: "Arcade a Traiter",
                  subTitle: "(ou la simulation sera réalisée)",
                  isShowSubTitle: true,
                  description: "Les deux",
                  isShowBottomWidget: true,
                  bottomText:
                      "Les scans 3D des deux arcades sont nécessaires même si vous choisissez de traiter une seule arcade.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
