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
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
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
  String? loginUserType = '';

  @override
  void onInit() {
    super.onInit();
    loginUserType = preferences.getClinicData()?.type;
    clinicData = preferences.getClinicData();
    emailAddressController.text = clinicData?.email ?? '';
    firstNameController.text = clinicData?.doctorData?.firstName ?? '';
    lastNameController.text = clinicData?.doctorData?.lastName ?? '';
    clinicNameController.text = clinicData?.clinicName ?? '';
    mobileNumController.text = clinicData?.clinicMobileNumber ?? '';
    isEmailNotification = clinicData?.isEmailNotification == 1 ? true : false;
    isMobileNotification = clinicData?.isPhoneNotification == 1 ? true : false;
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
        //firstName: firstNameController.text,
        //lastName: lastNameController.text,
        profileImage: profileImage);
    isLoading = false;
    try {
      if (result.status) {
        ClinicData doctorData = ClinicData.fromJson(result.data);
        preferences.saveClinicItem(doctorData);
        showAppSnackBar(result.msg);
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
