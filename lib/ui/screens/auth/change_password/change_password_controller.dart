import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/auth_repo/auth_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';
import 'package:lynerdoctor/model/clinic_model.dart';

class ChangePasswordController extends GetxController {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool oldPasswordError = false;
  bool newPasswordError = false;
  bool confirmPasswordError = false;
  void onChangeClick() async {
    isLoading = true;
    ResponseItem result = ResponseItem(data: null, msg: '', status: false);
    result = await AuthRepo.changePassword(
      newPassword: newPasswordController.text.trim(),
      oldPassword: oldPasswordController.text.trim(),
    );
    isLoading = false;
    try {
      if (result.status) {
        showAppSnackBar(result.msg);
        preferences.clearUserItem();
        ClinicData doctorData = ClinicData.fromJson(result.data);
        preferences.saveClinicItem(doctorData);
        //Get.offAllNamed(Routes.signUpSignInScreen);
        Get.back();
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
