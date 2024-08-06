import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/auth/reset_password/reset_password_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_auth_divider.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';
import 'package:lynerdoctor/ui/widgets/app_progress_view.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final ResetPasswordController resetPasswordController =
      Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBrown,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: GetBuilder<ResetPasswordController>(
              builder: (ResetPasswordController ctrl) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    100.space(),
                    (LocaleKeys.resetPassword)
                        .translateText
                        .appCommonText(
                            color: whiteColor,
                            size: 40.sp,
                            weight: FontWeight.w700)
                        .paddingOnly(bottom: 10.w, left: 20.w, right: 20.w),
                    (LocaleKeys.enterOtpAndResetPassword)
                        .translateText
                        .appCommonText(
                            color: whiteColor,
                            size: !isTablet ? 16.sp : 20.sp,
                            weight: FontWeight.w400)
                        .paddingSymmetric(horizontal: 20.w),
                    48.space(),
                    Container(
                      width: Get.width,
                      height: Get.height,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30.w)),
                        color: whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          12.space(),
                          AppAuthDivider(),
                          30.space(),
                          LocaleKeys.verificationCode.translateText
                              .appCommonText(
                                weight: FontWeight.w400,
                                color: hintTextColor,
                                size: !isTablet ? 14.sp : 18.sp,
                              )
                              .paddingOnly(bottom: 8.w),
                          CommonTextField(
                            prefixIcon: Assets.icons.mail,
                            hintText:
                                LocaleKeys.enterVerificationCode.translateText,
                            controller: ctrl.verificationCodeController,
                            action: TextInputAction.next,
                            keyboardType: TextInputType.text,
                          ),
                          20.space(),
                          LocaleKeys.password.translateText
                              .appCommonText(
                                weight: FontWeight.w400,
                                color: hintTextColor,
                                size: !isTablet ? 14.sp : 18.sp,
                              )
                              .paddingOnly(bottom: 8.w),
                          CommonTextField(
                            hintText: LocaleKeys.enterPassword.translateText,
                            controller: ctrl.passwordController,
                            prefixPadding: 15.w,
                            isPasswordField: true,
                            action: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            obscureText: !(ctrl.isPasswordVisible),
                            suffixIcon: (ctrl.isPasswordVisible
                                    ? Assets.icons.openEye
                                    : Assets.icons.closeEye)
                                .svg(
                                    height: !isTablet ? 18.w : 22.w,
                                    width: !isTablet ? 18.w : 22.w,
                                    fit: BoxFit.contain)
                                .paddingAll(15.w)
                                .onTap(
                              () {
                                ctrl.isPasswordVisible =
                                    !ctrl.isPasswordVisible;
                                ctrl.update();
                              },
                            ),
                            prefixIcon: Assets.icons.lock,
                          ),
                          28.space(),
                          LocaleKeys.confirmPassword.translateText
                              .appCommonText(
                                  weight: FontWeight.w400,
                                  color: hintTextColor,
                                  size: !isTablet ? 14.sp : 18.sp)
                              .paddingOnly(bottom: 8.w),
                          CommonTextField(
                            hintText: LocaleKeys.reEnterPassword.translateText,
                            controller: ctrl.confirmPasswordController,
                            prefixPadding: 15.w,
                            isPasswordField: true,
                            keyboardType: TextInputType.text,
                            obscureText: !(ctrl.isConfirmPasswordVisible),
                            suffixIcon: (ctrl.isConfirmPasswordVisible
                                    ? Assets.icons.openEye
                                    : Assets.icons.closeEye)
                                .svg(
                                    height: !isTablet ? 18.w : 22.w,
                                    width: !isTablet ? 18.w : 22.w,
                                    fit: BoxFit.contain)
                                .paddingAll(15.w)
                                .onTap(
                              () {
                                ctrl.isConfirmPasswordVisible =
                                    !ctrl.isConfirmPasswordVisible;
                                ctrl.update();
                              },
                            ),
                            prefixIcon: Assets.icons.lock,
                          ),
                          48.space(),
                          AppButton(
                            btnHeight: !isTablet ? 55.h : 63.h,
                            text: LocaleKeys.request.translateText,
                            onTap: () {
                              ctrl.resetPassword(context);
                            },
                            boxShadow: [],
                            radius: !isTablet ? 25.r : 40.r,
                            fontSize: !isTablet ? 20.sp : 22.sp,
                            bgColor: primaryBrown,
                            fontColor: Colors.white,
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 20.w),
                    )
                  ],
                );
              },
            ),
          ),
          GetBuilder<ResetPasswordController>(
            builder: (ResetPasswordController controller) {
              return controller.isLoading
                  ? AppProgressView(progressColor: Colors.black)
                  : Container();
            },
          ),
        ],
      ),
    );
  }
}
