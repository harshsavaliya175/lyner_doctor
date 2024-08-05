import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/auth/change_password/change_password_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: false,

        title: Text(
          LocaleKeys.changePassword.translateText,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: Assets.fonts.maax,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: !isTablet ?20:22,
          ),
        ),
        leading: Assets.icons.icBack
            .svg(
          height: 35,
          width: 35,
          fit: BoxFit.scaleDown,
        ).paddingOnly(top: 2)
            .onClick(() {
          Get.back();
        }),
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[300],
        titleSpacing: 1,
        elevation: 0.5,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: appBgColor,
      body: GetBuilder<ChangePasswordController>(
          builder: (ChangePasswordController ctrl) {
        return Form(
          key: ctrl.changePasswordFormKey,
          child: ListView(
            children: [
              15.space(),
              AppTextField(
                validator: (value) {
                  if (value.isEmpty) {
                    ctrl.update();
                    return 'Please enter old password';
                  } else if (value.length < 6) {
                    ctrl.update();
                    return 'Password should atlas 6 characters';
                  }
                  ctrl.update();
                  return null;
                },
                hintText: LocaleKeys.oldPassword.translateText,
                textEditingController: ctrl.oldPasswordController,
                // action: TextInputAction.next,
                showPrefixIcon: false,
                obscureText: true,
                showSuffixIcon: true,
                keyboardType: TextInputType.text,
                isError: ctrl.oldPasswordError,
                onChanged: (String value) {},
              ),
              10.space(),
              AppTextField(
                validator: (value) {
                  if (value.isEmpty) {
                    ctrl.update();
                    return 'Please enter new password';
                  } else if (value.length < 6) {
                    ctrl.update();
                    return 'Password should atlas 6 characters';
                  }
                  ctrl.update();
                  return null;
                },
                hintText: LocaleKeys.newPassword.translateText,
                textEditingController: ctrl.newPasswordController,
                // action: TextInputAction.next,
                showPrefixIcon: false,
                obscureText: true,
                showSuffixIcon: true,
                isError: ctrl.newPasswordError,
                keyboardType: TextInputType.text,
                onChanged: (String value) {},
              ),
              10.space(),
              AppTextField(
                validator: (value) {
                  if (value.isEmpty) {
                    ctrl.update();
                    return 'Please confirm enter password';
                  } else if (value.length < 6) {
                    ctrl.update();
                    return 'Password should atlas 6 characters';
                  } else if (value != ctrl.newPasswordController.text) {
                    ctrl.update();
                    return "Password does not match";
                  }
                  return null;
                },
                hintText: LocaleKeys.confirmNewPassword.translateText,
                textEditingController: ctrl.confirmNewPasswordController,
                // action: TextInputAction.next,
                showPrefixIcon: false,
                obscureText: true,
                showSuffixIcon: true,
                isError: ctrl.confirmPasswordError,
                keyboardType: TextInputType.text,
                onChanged: (String value) {},
              ),
              45.space(),
              AppButton(
                text: "Change",
                btnHeight: !isTablet ?53:60,
                onTap: () async{
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (ctrl.changePasswordFormKey.currentState!.validate()) {
                    FocusScope.of(Get.context!).unfocus();
                    ctrl.onChangeClick();
                  }
                },
                boxShadow: [],
                radius: !isTablet ?25:40,
                fontSize: !isTablet ?20:23,
                bgColor: primaryBrown,
                weight: FontWeight.w700,
                fontColor: Colors.white,
              ).paddingSymmetric(horizontal: 15),
            ],
          ),
        );
      }),
    );
  }
}
