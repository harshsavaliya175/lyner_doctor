import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/add_patient/add_patient.dart';
import 'package:lynerdoctor/ui/screens/main/add_patient/add_patient_controller.dart';

class UploadPhotographsScreen extends StatelessWidget {
  UploadPhotographsScreen({super.key});

  final AddPatientController ctrl = Get.put(AddPatientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: false,
        title: Text(
          LocaleKeys.addRefinement.translateText,
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
      body: uploadPhotographs(ctrl, true),
    );
  }
}
