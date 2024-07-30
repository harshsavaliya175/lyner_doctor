import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/auth_repo/auth_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';

class ResetPasswordController extends GetxController {
  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  TextEditingController verificationCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  resetPassword(BuildContext context) async {
    hideKeyBoard(context);
    if (verificationCodeController.text.isEmpty) {
      showAppSnackBar(LocaleKeys.pleaseEnterVerificationCode.translateText);
    } else if (passwordController.text.isEmpty) {
      showAppSnackBar(LocaleKeys.pleaseEnterPassword.translateText);
    } else if (confirmPasswordController.text.isEmpty) {
      showAppSnackBar(LocaleKeys.pleaseEnterConfirmPassword.translateText);
    } else if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      showAppSnackBar(LocaleKeys.passwordDoesNotMatch.translateText);
    } else {
      isLoading = true;
      ResponseItem result = ResponseItem(data: null, msg: '', status: false);
      result = await AuthRepo.changePasswordWithVerifyCode(
        email: Get.arguments,
        newPassword: passwordController.text.trim(),
        verifyCode: verificationCodeController.text.trim(),
      );
      isLoading = false;
      try {
        if (result.status) {
          showAppSnackBar(result.msg);
          Get.offAllNamed(Routes.signUpSignInScreen);
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
