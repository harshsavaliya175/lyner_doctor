import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/auth_repo/auth_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';
import 'package:lynerdoctor/model/clinic_model.dart';

class EditProfileController extends GetxController {
  File? profileImage;
  TextEditingController clinicNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController mobileNumController = TextEditingController();
  GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();
  bool isClinicError = false;
  bool emailAddressError = false;
  bool mobileNumError = false;
  bool isMobileNotification = false;
  bool isEmailNotification = false;
  bool isLoading = false;
  ClinicData? clinicData;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    clinicData = preferences.getClinicData();
    emailAddressController.text = clinicData?.email??'';
    clinicNameController.text = clinicData?.clinicName??'';
    mobileNumController.text = clinicData?.clinicMobileNumber??'';
    isEmailNotification = clinicData?.isEmailNotification==1?true:false;
    isMobileNotification = clinicData?.isPhoneNotification==1?true:false;
    update();
  }
  void onUpdateProfileClick() async {
    isLoading = true;
    ResponseItem result = ResponseItem(data: null, msg: '', status: false);
    result = await AuthRepo.editProfile(
      email: emailAddressController.text,
      fullName: clinicNameController.text,
      isEmailNotification: isEmailNotification ? 1 : 0,
      isMobileNotification: isMobileNotification ? 1 : 0,
      phoneNumber: mobileNumController.text,
      profileImage: profileImage
    );
    isLoading = false;
    try {
      if (result.status) {
        ClinicData doctorData = ClinicData.fromJson(result.data);
        preferences.saveClinicItem(doctorData);
        showAppSnackBar(result.msg);
        // Get.offAllNamed(Routes.signUpSignInScreen);
      } else {
        isLoading = false;
        showAppSnackBar(result.msg);
      }
    } catch (e) {
      isLoading = false;
      showAppSnackBar(result.msg);
    }
    update();
  }
}
