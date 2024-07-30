import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/auth_repo/auth_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';

class ForgotPasswordController extends GetxController {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();

  forgotPassword(BuildContext context) async {
    hideKeyBoard(context);
    if (emailController.text.isEmpty) {
      showAppSnackBar(LocaleKeys.pleaseEnterEmail.translateText);
    } else if (!emailController.text.isValidEmail()) {
      showAppSnackBar(LocaleKeys.pleaseEnterValidEmail.translateText);
    } else {
      isLoading = true;
      ResponseItem result = ResponseItem(data: null, msg: '', status: false);
      result =
          await AuthRepo.forgotPassword(email: emailController.text.trim());
      isLoading = false;

      try {
        if (result.status) {
          showAppSnackBar(result.msg);
          Get.offNamed(
            Routes.resetPasswordScreen,
            arguments: emailController.text.trim(),
          );
          emailController.clear();
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
