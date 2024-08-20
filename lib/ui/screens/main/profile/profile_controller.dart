import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/model/clinic_model.dart';
import 'package:lynerdoctor/ui/widgets/common_dialog.dart';

class ProfileController extends GetxController {

  ClinicData? clinicData;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    clinicData = preferences.getClinicData();
  }
  void logout() {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) {
        return CommonDialog(
          dialogBackColor: Colors.white,
          tittleText: LocaleKeys.logOut.translateText,
          buttonText: LocaleKeys.confirm.translateText,
          buttonCancelText: LocaleKeys.cancel.translateText,
          descriptionText: LocaleKeys.areYouSureWantLogout.translateText,
          cancelOnTap: () => Get.back(),
          onTap: () {
            Get.offAllNamed(Routes.signUpSignInScreen);
            // callLogoutApi();
            preferences.clearUserItem();
          },
          alignment: Alignment.center,
        );
      },
    );
  }}
