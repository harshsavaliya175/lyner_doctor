import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/auth/sign_up/signUp_logIn_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_auth_divider.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';
import 'package:lynerdoctor/ui/widgets/app_progress_view.dart';

class SignUpSignInScreen extends StatelessWidget {
  SignUpSignInScreen({super.key});

  final SignUpSignInController signUpSignInController =
      Get.put(SignUpSignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBrown,
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return mainScreen(context, orientation == Orientation.portrait);
          } else {
            return mainScreen(context, orientation == Orientation.portrait);
          }
        },
      ),
    );
  }

  Widget mainScreen(
    BuildContext context,
    bool isPortrait,
  ) {
    return Stack(
      children: [
        ListView(
          children: [
            GetBuilder<SignUpSignInController>(
              builder: (SignUpSignInController ctrl) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    25.space(),
                    (ctrl.isLogin ? LocaleKeys.logIn : LocaleKeys.register)
                        .translateText
                        .appCommonText(
                            color: whiteColor,
                            size: !isTablet ? 40.sp : 50.sp,
                            weight: FontWeight.w700)
                        .paddingOnly(bottom: 10.w, left: 20.w, right: 20.w),
                    (ctrl.isLogin
                            ? LocaleKeys.logInText
                            : LocaleKeys.registerText)
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
                          tabBar(ctrl),
                          40.space(),
                          ctrl.isLogin
                              ? signInScreen(ctrl, context, isPortrait)
                              : signUpScreen(ctrl, context),
                        ],
                      ).paddingSymmetric(horizontal: 20.w),
                    )
                  ],
                );
              },
            ),
          ],
        ),
        GetBuilder<SignUpSignInController>(
          builder: (SignUpSignInController controller) {
            return controller.isLoading
                ? AppProgressView(progressColor: Colors.black)
                : Container();
          },
        ),
      ],
    );
  }

  Widget signInScreen(
      SignUpSignInController ctrl, BuildContext context, bool isPortrait) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LocaleKeys.enterEmail.translateText
            .appCommonText(
                weight: FontWeight.w400,
                color: hintTextColor,
                size: !isTablet ? 14.sp : 17.sp)
            .paddingOnly(bottom: 8.w),
        CommonTextField(
          prefixIcon: Assets.icons.mail,
          hintText: LocaleKeys.enterEmail.translateText,
          controller: ctrl.loginEmailController,
          action: TextInputAction.next,
          prefixPadding: 15.w,
        ),
        28.space(),
        LocaleKeys.password.translateText
            .appCommonText(
                weight: FontWeight.w400,
                color: hintTextColor,
                size: !isTablet ? 14.sp : 17.sp)
            .paddingOnly(bottom: 8.w),
        CommonTextField(
          hintText: LocaleKeys.enterPassword.translateText,
          controller: ctrl.passwordController,
          prefixPadding: 15.w,
          isPasswordField: true,
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
              ctrl.isPasswordVisible = !ctrl.isPasswordVisible;
              ctrl.update();
            },
          ),
          prefixIcon: Assets.icons.lock,
        ),
        5.space(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Checkbox(
                      hoverColor: primaryBrown,
                      activeColor: primaryBrown,
                      checkColor: Colors.white,
                      side: BorderSide(color: primaryBrown, width: 1.5),
                      value: ctrl.isRememberPassword,
                      onChanged: (bool? value) {
                        ctrl.isRememberPassword = !ctrl.isRememberPassword;
                        ctrl.update();
                      },
                    ),
                  ),
                  10.space(),
                  LocaleKeys.rememberPassword.translateText.appCommonText(
                    weight: FontWeight.w400,
                    maxLine: 2,
                    color: hintTextColor,
                    size: !isTablet ? 16.sp : 18.sp,
                  ),
                ],
              ),
            ),
            // Spacer(),
            TextButton(
              onPressed: () {
                Get.toNamed(Routes.forgotPasswordScreen);
              },
              child: LocaleKeys.forgotPassword2.translateText.appCommonText(
                  weight: FontWeight.w500,
                  color: blackColor,
                  align: TextAlign.start,
                  size: !isTablet ? 16.sp : 18.sp),
            ).paddingOnly(left: 10),
          ],
        ),
        48.space(),
        AppButton(
          btnHeight: !isTablet ? 55 : 64,
          radius: !isTablet ? 25 : 40,
          text: LocaleKeys.logIn.translateText,
          onTap: () {
            ctrl.clinicLogin(context);
          },
          boxShadow: [],
          fontSize: !isTablet ? 18.sp : 21.sp,
          bgColor: primaryBrown,
          fontColor: Colors.white,
        ),
      ],
    );
  }

  Widget signUpScreen(SignUpSignInController ctrl, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LocaleKeys.clinicName.translateText
            .appCommonText(
                weight: FontWeight.w400,
                color: hintTextColor,
                size: !isTablet ? 14.sp : 17.sp)
            .paddingOnly(bottom: 8.w),
        CommonTextField(
          prefixIcon: Assets.icons.clinic,
          hintText: LocaleKeys.enterName.translateText,
          controller: ctrl.clinicNameController,
          action: TextInputAction.next,
          prefixPadding: 15.w,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
        ),
        20.space(),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LocaleKeys.firstName.translateText
                      .appCommonText(
                          weight: FontWeight.w400,
                          color: hintTextColor,
                          size: !isTablet ? 14.sp : 17.sp)
                      .paddingOnly(bottom: 8.w),
                  CommonTextField(
                    prefixIcon: Assets.icons.icUser,
                    hintText: LocaleKeys.enterName.translateText,
                    controller: ctrl.firstNameController,
                    prefixPadding: 15.w,
                    action: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                  ),
                ],
              ),
            ),
            16.space(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LocaleKeys.lastName.translateText
                      .appCommonText(
                          weight: FontWeight.w400,
                          color: hintTextColor,
                          size: !isTablet ? 14.sp : 17.sp)
                      .paddingOnly(bottom: 8.w),
                  CommonTextField(
                    prefixIcon: Assets.icons.icUser,
                    hintText: LocaleKeys.enterName.translateText,
                    controller: ctrl.lastNameController,
                    action: TextInputAction.next,
                    prefixPadding: 15.w,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                  ),
                ],
              ),
            ),
          ],
        ),
        20.space(),
        LocaleKeys.emailAddress.translateText
            .appCommonText(
                weight: FontWeight.w400,
                color: hintTextColor,
                size: !isTablet ? 14.sp : 17.sp)
            .paddingOnly(bottom: 8.w),
        CommonTextField(
          prefixIcon: Assets.icons.mail,
          prefixPadding: 15.w,
          hintText: LocaleKeys.enterEmail.translateText,
          controller: ctrl.signUpEmailController,
          action: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
        ),
        10.space(),
        LocaleKeys.phoneNumber.translateText
            .appCommonText(
                weight: FontWeight.w400,
                color: hintTextColor,
                size: !isTablet ? 14.sp : 17.sp)
            .paddingOnly(bottom: 8.w),
        CommonTextField(
          prefixIcon: Assets.icons.phone,
          hintText: LocaleKeys.enterPhoneNo.translateText,
          controller: ctrl.phoneController,
          prefixPadding: !isTablet ? 15.w : 15.w,
          prefixIconSize: !isTablet ? 18.h : 22.h,
          hintTextSize: !isTablet ? 18.h : 20.h,
          keyboardType: TextInputType.phone,
        ),
        48.space(),
        AppButton(
          btnHeight: !isTablet ? 55 : 65,
          radius: !isTablet ? 25 : 40,
          text: LocaleKeys.requestToRegister.translateText,
          onTap: () {
            ctrl.clinicRequestToRegister(context);
          },
          boxShadow: [],
          fontSize: !isTablet ? 18.sp : 21.sp,
          bgColor: primaryBrown,
          fontColor: Colors.white,
        ),
      ],
    );
  }

  Container tabBar(SignUpSignInController ctrl) {
    return Container(
      height: !isTablet ? 60.h : 65.h,
      decoration: BoxDecoration(
          color: tabColor, borderRadius: BorderRadius.circular(100)),
      child: Row(
        children: [
          Expanded(
              child: Container(
            height: !isTablet ? 60.h : 65.h,
            decoration: BoxDecoration(
                color: ctrl.isLogin ? whiteColor : tabColor,
                borderRadius: BorderRadius.circular(100)),
            margin: EdgeInsets.all(6.w),
            child: Center(
              child: LocaleKeys.logIn.translateText.appCommonText(
                size: !isTablet ? 16.sp : 20.sp,
                weight: FontWeight.w700,
                color: ctrl.isLogin ? primaryBrown : darkSkyColor,
              ),
            ),
          ).onTap(
            () {
              ctrl.isLogin = true;
              ctrl.update();
            },
          )),
          Expanded(
            child: Container(
              height: !isTablet ? 60.h : 65.h,
              margin: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                  color: !ctrl.isLogin ? whiteColor : tabColor,
                  borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: LocaleKeys.register.translateText.appCommonText(
                    size: !isTablet ? 16.sp : 20.sp,
                    weight: FontWeight.w700,
                    color: !ctrl.isLogin ? primaryBrown : darkSkyColor),
              ),
            ).onTap(
              () {
                ctrl.isLogin = false;
                ctrl.update();
              },
            ),
          ),
        ],
      ),
    );
  }
}
