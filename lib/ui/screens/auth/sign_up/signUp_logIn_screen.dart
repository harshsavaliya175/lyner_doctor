import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: GetBuilder<SignUpSignInController>(
              builder: (SignUpSignInController ctrl) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    100.space(),
                    (ctrl.isLogin ? LocaleKeys.logIn : LocaleKeys.register)
                        .translateText
                        .appCommonText(
                            color: whiteColor,
                            size: 40.sp,
                            weight: FontWeight.w700)
                        .paddingOnly(bottom: 10.w, left: 20.w, right: 20.w),
                    (ctrl.isLogin
                            ? LocaleKeys.logInText
                            : LocaleKeys.registerText)
                        .translateText
                        .appCommonText(
                            color: whiteColor,
                            size: 16.sp,
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
                              ? signInScreen(ctrl, context)
                              : signUpScreen(ctrl, context),
                        ],
                      ).paddingSymmetric(horizontal: 20.w),
                    )
                  ],
                );
              },
            ),
          ),
          GetBuilder<SignUpSignInController>(
            builder: (SignUpSignInController controller) {
              return controller.isLoading
                  ? AppProgressView(progressColor: Colors.black)
                  : Container();
            },
          ),
        ],
      ),
    );
  }

  Widget signInScreen(SignUpSignInController ctrl, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LocaleKeys.enterEmail.translateText
            .appCommonText(
                weight: FontWeight.w400, color: hintTextColor, size: 14.sp)
            .paddingOnly(bottom: 8.w),
        CommonTextField(
          prefixIcon: Assets.icons.mail,
          hintText: LocaleKeys.enterEmail.translateText,
          controller: ctrl.loginEmailController,
          action: TextInputAction.next,
        ),
        28.space(),
        LocaleKeys.password.translateText
            .appCommonText(
                weight: FontWeight.w400, color: hintTextColor, size: 14.sp)
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
              .svg(height: 18.w, width: 18.w, fit: BoxFit.contain)
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                weight: FontWeight.w400, color: hintTextColor, size: 16.sp),
            Spacer(),
            TextButton(
              onPressed: () {
                Get.toNamed(Routes.forgotPasswordScreen);
              },
              child: LocaleKeys.forgotPassword2.translateText.appCommonText(
                  weight: FontWeight.w500, color: blackColor, size: 16.sp),
            ),
          ],
        ),
        48.space(),
        AppButton(
          btnHeight: 55,
          text: LocaleKeys.logIn.translateText,
          onTap: () {
            ctrl.clinicLogin(context);
          },
          boxShadow: [],
          radius: 25,
          fontSize: 20,
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
                weight: FontWeight.w400, color: hintTextColor, size: 14.sp)
            .paddingOnly(bottom: 8.w),
        CommonTextField(
          prefixIcon: Assets.icons.clinic,
          hintText: LocaleKeys.enterName.translateText,
          controller: ctrl.clinicNameController,
          action: TextInputAction.next,
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
                          size: 14.sp)
                      .paddingOnly(bottom: 8.w),
                  CommonTextField(
                    prefixIcon: Assets.icons.icUser,
                    hintText: LocaleKeys.enterName.translateText,
                    controller: ctrl.firstNameController,
                    prefixIconSize: 10,
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
                          size: 14.sp)
                      .paddingOnly(bottom: 8.w),
                  CommonTextField(
                    prefixIcon: Assets.icons.icUser,
                    hintText: LocaleKeys.enterName.translateText,
                    controller: ctrl.lastNameController,
                    action: TextInputAction.next,
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
                weight: FontWeight.w400, color: hintTextColor, size: 14.sp)
            .paddingOnly(bottom: 8.w),
        CommonTextField(
          prefixIcon: Assets.icons.mail,
          hintText: LocaleKeys.enterEmail.translateText,
          controller: ctrl.signUpEmailController,
          action: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
        ),
        10.space(),
        LocaleKeys.phoneNumber.translateText
            .appCommonText(
                weight: FontWeight.w400, color: hintTextColor, size: 14.sp)
            .paddingOnly(bottom: 8.w),
        CommonTextField(
          prefixIcon: Assets.icons.phone,
          hintText: LocaleKeys.enterPhoneNo.translateText,
          controller: ctrl.phoneController,
          keyboardType: TextInputType.phone,
        ),
        48.space(),
        AppButton(
          btnHeight: 55,
          text: LocaleKeys.requestToRegister.translateText,
          onTap: () {
            ctrl.clinicRequestToRegister(context);
          },
          boxShadow: [],
          radius: 25,
          fontSize: 20,
          bgColor: primaryBrown,
          fontColor: Colors.white,
        ),
      ],
    );
  }

  Container tabBar(SignUpSignInController ctrl) {
    return Container(
      height: 60.w,
      decoration: BoxDecoration(
          color: tabColor, borderRadius: BorderRadius.circular(100)),
      child: Row(
        children: [
          Expanded(
              child: Container(
            height: 60.w,
            decoration: BoxDecoration(
                color: ctrl.isLogin ? whiteColor : tabColor,
                borderRadius: BorderRadius.circular(100)),
            margin: EdgeInsets.all(6.w),
            child: Center(
              child: LocaleKeys.logIn.translateText.appCommonText(
                size: 16.sp,
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
              height: 60.w,
              margin: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                  color: !ctrl.isLogin ? whiteColor : tabColor,
                  borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: LocaleKeys.register.translateText.appCommonText(
                    size: 16.sp,
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
