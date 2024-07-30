import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/auth_repo/auth_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/model/clinic_model.dart';

class SignUpSignInController extends GetxController {
  bool isLogin = true;
  bool isPasswordVisible = false;
  bool isRememberPassword = false;
  bool isLoading = false;
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController clinicNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  clinicLogin(BuildContext context) async {
    hideKeyBoard(context);
    if (loginEmailController.text.isEmpty) {
      showAppSnackBar(LocaleKeys.pleaseEnterEmail.translateText);
    } else if (!loginEmailController.text.isValidEmail()) {
      showAppSnackBar(LocaleKeys.pleaseEnterValidEmail.translateText);
    } else if (passwordController.text.isEmpty) {
      showAppSnackBar(LocaleKeys.pleaseEnterPassword.translateText);
    } else {
      isLoading = true;
      ResponseItem result = ResponseItem(data: null, msg: '', status: false);
      result = await AuthRepo.clinicLogin(
        email: loginEmailController.text.trim(),
        password: passwordController.text.trim(),
      );
      isLoading = false;

      try {
        if (result.status) {
          if (result.data != null) {
            loginEmailController.clear();
            passwordController.clear();
            ClinicData doctorData = ClinicData.fromJson(result.data);
            preferences.saveClinicItem(doctorData);
            Get.offAllNamed(Routes.dashboardScreen);
          }
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

  clinicRequestToRegister(BuildContext context) async {
    hideKeyBoard(context);
    if (clinicNameController.text.isEmpty) {
      showAppSnackBar(LocaleKeys.pleaseEnterClinicName.translateText);
    } else if (firstNameController.text.isEmpty) {
      showAppSnackBar(LocaleKeys.pleaseEnterFirstName.translateText);
    } else if (lastNameController.text.isEmpty) {
      showAppSnackBar(LocaleKeys.pleaseEnterLastName.translateText);
    } else if (signUpEmailController.text.isEmpty) {
      showAppSnackBar(LocaleKeys.pleaseEnterEmail.translateText);
    } else if (!signUpEmailController.text.isValidEmail()) {
      showAppSnackBar(LocaleKeys.pleaseEnterValidEmail.translateText);
    } else if (phoneController.text.isEmpty) {
      showAppSnackBar(LocaleKeys.pleaseEnterPhoneNumber.translateText);
    } else {
      isLoading = true;
      ResponseItem result = ResponseItem(data: null, msg: '', status: false);
      result = await AuthRepo.requestToRegister(
        email: signUpEmailController.text.trim(),
        clinicName: clinicNameController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        phoneNumber: phoneController.text.trim(),
      );
      isLoading = false;
      try {
        if (result.status) {
          clinicNameController.clear();
          firstNameController.clear();
          lastNameController.clear();
          signUpEmailController.clear();
          phoneController.clear();
          isLogin = true;
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
}
