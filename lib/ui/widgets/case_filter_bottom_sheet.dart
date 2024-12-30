import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/case_selection/case_selection_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';
import 'package:lynerdoctor/ui/widgets/app_radio_button_with_title.dart';
import 'package:lynerdoctor/ui/widgets/common_bottom_sheet_top_widget.dart';

class CaseFilterBottomSheet extends StatefulWidget {
  const CaseFilterBottomSheet({Key? key, required this.onTap})
      : super(key: key);

  final VoidCallback onTap;

  @override
  State<CaseFilterBottomSheet> createState() =>
      _PatientsScreenFilterBottomSheetState();
}

class _PatientsScreenFilterBottomSheetState
    extends State<CaseFilterBottomSheet> {
  int caseStatusValue = 1;
  String caseStatus = 'Analysis Requested';
  CaseSelectionController caseSelectionController =
      Get.put(CaseSelectionController());

  @override
  void initState() {
    caseStatusValue = caseSelectionController.caseSelectionFilterValue;
    caseStatus = caseSelectionController.caseStatus;
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
                  LocaleKeys.caseStatus.translateText,
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
                      caseStatusValue = 1;
                      caseStatus = 'Analysis Requested';
                    });
                  },
                  title: LocaleKeys.analysisRequested.translateText,
                  radiobuttonValue: 1,
                  radiobuttonGroupValue: caseStatusValue,
                ),
                12.space(),
                AppRadioButtonWithTitle(
                  onTap: () {
                    setState(() {
                      caseStatusValue = 2;
                      caseStatus = 'Ongoing';
                    });
                  },
                  title: LocaleKeys.ongoing.translateText,
                  radiobuttonValue: 2,
                  radiobuttonGroupValue: caseStatusValue,
                ),
                12.space(),
                AppRadioButtonWithTitle(
                  onTap: () {
                    setState(() {
                      caseStatusValue = 3;
                      caseStatus = 'Eligible';
                    });
                  },
                  title: LocaleKeys.eligible.translateText,
                  radiobuttonValue: 3,
                  radiobuttonGroupValue: caseStatusValue,
                ),
                12.space(),
                AppRadioButtonWithTitle(
                  onTap: () {
                    setState(() {
                      caseStatusValue = 4;
                      caseStatus = 'Non-Eligible';
                    });
                  },
                  title: LocaleKeys.nonEligible.translateText,
                  radiobuttonValue: 4,
                  radiobuttonGroupValue: caseStatusValue,
                ),
                12.space(),
                AppRadioButtonWithTitle(
                  onTap: () {
                    setState(() {
                      caseStatusValue = 5;
                      caseStatus = 'Pending Lyner Conversion';
                    });
                  },
                  title: LocaleKeys.pendingLynerConversion.translateText,
                  radiobuttonValue: 5,
                  radiobuttonGroupValue: caseStatusValue,
                ),
                40.space(),
                AppButton(
                  bgColor: primaryBrown,
                  text: LocaleKeys.apply.translateText,
                  fontColor: whiteColor,
                  radius: 100,
                  onTap: () {
                    Get.back();
                    caseSelectionController.changeData(
                      caseStatusValue: caseStatusValue,
                      caseStatusString: caseStatus,
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
