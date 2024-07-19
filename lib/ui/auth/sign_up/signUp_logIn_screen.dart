import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/ui/auth/sign_up/signUp_logIn_controller.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_string.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final SignUpLogInController signUpController =
      Get.put(SignUpLogInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBrown,
      body: SingleChildScrollView(
        child: GetBuilder<SignUpLogInController>(builder: (ctrl) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              100.w.H(),
              (ctrl.isLogin ? logIn : Register)
                  .appCommonText(
                      color: whiteColor, size: 40.sp, weight: FontWeight.w700)
                  .paddingOnly(bottom: 10.w, left: 20.w, right: 20.w),
              (ctrl.isLogin ? logInText : RegisterText)
                  .appCommonText(
                      color: whiteColor, size: 16.sp, weight: FontWeight.w400)
                  .paddingSymmetric(horizontal: 20.w),
              48.w.H(),
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
                    12.w.H(),
                    divider(),
                    30.w.H(),
                    tabBar(ctrl),
                    40.w.H(),
                    enterEmail
                        .appCommonText(
                            weight: FontWeight.w400,
                            color: hintTextColor,
                            size: 14.sp)
                        .paddingOnly(bottom: 8.w),
                    CommonTextField(
                      prefixIcon: Assets.icons.mail,
                      hintText: enterEmail,
                      controller: ctrl.emailController,
                    ),
                    28.w.H(),
                    Password.appCommonText(
                            weight: FontWeight.w400,
                            color: hintTextColor,
                            size: 14.sp)
                        .paddingOnly(bottom: 8.w),
                    CommonTextField(
                      prefixPadding: 15.w,
                      isPasswordField: true,
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
                      hintText: enterPassword,
                      controller: ctrl.passwordController,
                    )
                  ],
                ).paddingSymmetric(horizontal: 20.w),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget divider() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 81.w,
        height: 6.w,
        decoration: BoxDecoration(
            color: skyColor, borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  Container tabBar(SignUpLogInController ctrl) {
    return Container(
      height: 60.w,
      decoration: BoxDecoration(
          color: skyColor, borderRadius: BorderRadius.circular(100)),
      child: Row(
        children: [
          Expanded(
              child: Container(
            height: 60.w,
            decoration: BoxDecoration(
                color: ctrl.isLogin ? whiteColor : skyColor,
                borderRadius: BorderRadius.circular(100)),
            margin: EdgeInsets.all(6.w),
            child: Center(
              child: logIn.appCommonText(
                  size: 16.sp,
                  weight: FontWeight.w700,
                  color: ctrl.isLogin ? primaryBrown : darkSkyColor),
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
                  color: !ctrl.isLogin ? whiteColor : skyColor,
                  borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: Register.appCommonText(
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
