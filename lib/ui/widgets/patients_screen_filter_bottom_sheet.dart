import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/patients/patients_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';
import 'package:lynerdoctor/ui/widgets/app_radio_button_with_title.dart';
import 'package:lynerdoctor/ui/widgets/common_bottom_sheet_top_widget.dart';

class PatientsScreenFilterBottomSheet extends StatefulWidget {
  const PatientsScreenFilterBottomSheet({Key? key, required this.onTap})
      : super(key: key);

  final VoidCallback onTap;
  @override
  State<PatientsScreenFilterBottomSheet> createState() =>
      _PatientsScreenFilterBottomSheetState();
}

class _PatientsScreenFilterBottomSheetState
    extends State<PatientsScreenFilterBottomSheet> {
  int treatmentStatusValue = 1;
  String treatmentStatus = 'task';
  PatientsController patientsController = Get.put(PatientsController());

  @override
  void initState() {
    treatmentStatusValue = patientsController.treatmentStatusFilterValue;
    treatmentStatus = patientsController.treatmentStatusFilter;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: Container(
        color: appBgColor,
        child: ListView(
          shrinkWrap: true,
          children: [
            CommonBottomSheetTopWidget(
              title: LocaleKeys.filter.translateText,
              onTap: () {
                Get.back();
              },
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.space(),
                Text(
                  LocaleKeys.treatmentStatus.translateText,
                  style: hintTextStyle(
                    size: 16,
                    weight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                12.space(),
                AppRadioButtonWithTitle(
                  onTap: () {
                    setState(() {
                      treatmentStatusValue = 1;
                      treatmentStatus = 'task';
                    });
                  },
                  title: LocaleKeys.tasks.translateText,
                  radiobuttonValue: 1,
                  radiobuttonGroupValue: treatmentStatusValue,
                ),
                12.space(),
                AppRadioButtonWithTitle(
                  onTap: () {
                    setState(() {
                      treatmentStatusValue = 2;
                      treatmentStatus = 'patients';
                    });
                  },
                  title: LocaleKeys.patients.translateText,
                  radiobuttonValue: 2,
                  radiobuttonGroupValue: treatmentStatusValue,
                ),
                12.space(),
                AppRadioButtonWithTitle(
                  onTap: () {
                    setState(() {
                      treatmentStatusValue = 3;
                      treatmentStatus = 'archived';
                    });
                  },
                  title: LocaleKeys.archived.translateText,
                  radiobuttonValue: 3,
                  radiobuttonGroupValue: treatmentStatusValue,
                ),
                40.space(),
                AppButton(
                  bgColor: primaryBrown,
                  text: LocaleKeys.apply.translateText,
                  fontColor: whiteColor,
                  radius: 100,
                  onTap: () {
                    Get.back();
                    patientsController.changeData(
                      treatmentStatusValue: treatmentStatusValue,
                      treatmentStatus: treatmentStatus,
                    );
                    widget.onTap();
                  },
                ),
                28.space(),
              ],
            ).paddingSymmetric(horizontal: 20),
          ],
        ),
      ),
    );
  }
}
