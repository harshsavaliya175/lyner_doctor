import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/profile/profile_screen.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';
import 'package:lynerdoctor/ui/widgets/common_bottom_sheet_top_widget.dart';

class AddNewPatientBottomSheet extends StatefulWidget {
  const AddNewPatientBottomSheet({Key? key}) : super(key: key);

  @override
  _AddNewPatientBottomSheetState createState() =>
      _AddNewPatientBottomSheetState();
}

class _AddNewPatientBottomSheetState extends State<AddNewPatientBottomSheet> {
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
              title: LocaleKeys.add.translateText,
              onTap: () {
                Get.back();
              },
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.space(),
                profileScreenItem(
                  leadingIcon: Assets.icons.icPatients,
                  title: LocaleKeys.newPatient,
                  titleColor: Colors.black,
                  leadingIconColor: primaryBrown,
                  onTap: () {
                    Get.back();
                    Get.toNamed(Routes.addPatientScreen, arguments: null);
                  },
                ),
                12.space(),
                profileScreenItem(
                  leadingIcon: Assets.icons.icDevis,
                  title: LocaleKeys.devis,
                  titleColor: Colors.black,
                  leadingIconColor: primaryBrown,
                  onTap: () {
                    Get.back();
                    Get.toNamed(Routes.devisScreen, arguments: null);
                  },
                ),
                40.space(),
                AppButton(
                  bgColor: primaryBrown,
                  text: LocaleKeys.cancel.translateText,
                  fontColor: whiteColor,
                  radius: 100,
                  onTap: () {
                    Get.back();
                    // widget.onTap();
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
