import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/auth/forgot_password/forgot_password_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_auth_divider.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';
import 'package:lynerdoctor/ui/widgets/app_progress_view.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBrown,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: GetBuilder<ForgotPasswordController>(
              builder: (ForgotPasswordController ctrl) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    100.space(),
                    (LocaleKeys.forgotPassword)
                        .translateText
                        .appCommonText(
                            color: whiteColor,
                            size: 40.sp,
                            weight: FontWeight.w700,
                            align: TextAlign.start)
                        .paddingOnly(bottom: 10.w, left: 20.w, right: 20.w),
                    (LocaleKeys.forgotPasswordText)
                        .translateText
                        .appCommonText(
                            color: whiteColor,
                            size: !isTablet ? 16.sp : 20.sp,
                            weight: FontWeight.w400,
                            align: TextAlign.start)
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
                          LocaleKeys.enterEmail.translateText
                              .appCommonText(
                                weight: FontWeight.w400,
                                color: hintTextColor,
                                size: !isTablet ? 14.sp : 18.sp,
                              )
                              .paddingOnly(bottom: 8.w),
                          CommonTextField(
                            prefixIcon: Assets.icons.mail,
                            hintText: LocaleKeys.enterEmail.translateText,
                            controller: ctrl.emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          48.space(),
                          AppButton(
                            btnHeight: !isTablet ? 55.h : 63.h,
                            text: LocaleKeys.sendRequest.translateText,
                            onTap: () {
                              ctrl.forgotPassword(context);
                            },
                            boxShadow: [],
                            radius: !isTablet ? 25.r : 40.r,
                            fontSize: !isTablet ? 20.sp : 21.sp,
                            bgColor: primaryBrown,
                            fontColor: Colors.white,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LocaleKeys.rememberPassword2.translateText
                                  .appCommonText(
                                weight: FontWeight.w400,
                                color: darkSkyColor,
                                size: !isTablet ? 16.sp : 20.sp,
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.offAllNamed(Routes.signUpSignInScreen);
                                },
                                child: LocaleKeys.logIn.translateText
                                    .appCommonText(
                                  weight: FontWeight.w500,
                                  color: primaryBrown,
                                  size: !isTablet ? 16.sp : 20.sp,
                                  decoration: TextDecoration.underline,
                                  decorationColor: primaryBrown,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 20.w),
                    )
                  ],
                );
              },
            ),
          ),
          GetBuilder<ForgotPasswordController>(
            builder: (ForgotPasswordController controller) {
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
