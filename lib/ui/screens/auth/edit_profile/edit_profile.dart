import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/home_image.dart';
import 'package:lynerdoctor/core/utils/image_picker.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/auth/edit_profile/edit_profile_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';
import 'package:lynerdoctor/ui/widgets/app_progress_view.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  final EditProfileController controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: false,
        title: Text(
          LocaleKeys.editProfile.translateText,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: Assets.fonts.maax,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: !isTablet ? 20 : 22,
          ),
        ),
        leading: Assets.icons.icBack
            .svg(
              height: 35,
              width: 35,
              fit: !isTablet ? BoxFit.scaleDown : BoxFit.fill,
            )
            .paddingOnly(
              left: 10,
              top: isTablet ? 22 : 2,
              bottom: isTablet ? 22 : 0,
              right: 10,
            )
            .onClick(() {
          Get.back();
        }),
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[300],
        titleSpacing: 1,
        elevation: 0.5,
        scrolledUnderElevation: 0,
      ),
      body: GetBuilder<EditProfileController>(builder: (ctrl) {
        return Stack(
          children: [
            Form(
              key: ctrl.editProfileFormKey,
              child: ListView(
                children: [
                  15.space(),
                  Stack(
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(70)),
                            child: ctrl.profileImage != null
                                ? HomeImage.fileImage(
                                    path: ctrl.profileImage!.path,
                                    size: !isTablet ? 150 : 200,
                                    fit: BoxFit.cover,
                                    shape: BoxShape.circle,
                                  )
                                : HomeImage.networkImage(
                                    path: ApiUrl.clinicProfileImagePath +
                                        '${ctrl.clinicData?.clinicPhoto}',
                                    size: !isTablet ? 150 : 200,
                                    shape: BoxShape.circle,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ],
                      ).center,
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(top: !isTablet ? 125 : 175),
                          height: !isTablet ? 40 : 45,
                          width: !isTablet ? 40 : 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Assets.icons.icCamera.svg(),
                        ).onClick(() {
                          imageUploadUtils.openImageChooser(
                              context: context,
                              onImageChose: (File? file) async {
                                ctrl.profileImage = file!;
                                ctrl.update();
                              });
                        }),
                      ),
                    ],
                  ),
                  20.space(),
                  AppTextField(
                    validator: (value) {
                      if (value.isEmpty) {
                        ctrl.update();
                        return LocaleKeys.pleaseEnterClinicName.translateText;
                      }
                      ctrl.update();
                      return null;
                    },
                    hintText: LocaleKeys.enterClinicName.translateText,
                    textEditingController: ctrl.clinicNameController,
                    labelText: LocaleKeys.nameOfTheClinic.translateText,
                    showPrefixIcon: false,
                    keyboardType: TextInputType.text,
                    isError: ctrl.isClinicError,
                    onChanged: (String value) {},
                  ),
                  15.space(),
                  AppTextField(
                    validator: (value) {
                      if (value.isEmpty) {
                        ctrl.update();
                        return LocaleKeys.pleaseEnterEmail.translateText;
                      } else if (!ctrl.emailAddressController.text
                          .isValidEmail()) {
                        ctrl.update();
                        return LocaleKeys.pleaseEnterValidEmail.translateText;
                      }
                      ctrl.update();
                      return null;
                    },
                    hintText: LocaleKeys.enterEmailAddress.translateText,
                    textEditingController: ctrl.emailAddressController,
                    labelText: LocaleKeys.clinicEmailAddress.translateText,
                    showPrefixIcon: false,
                    readOnly: true,
                    showCursor: false,
                    keyboardType: TextInputType.text,
                    isError: ctrl.emailAddressError,
                    onChanged: (String value) {},
                  ),
                  15.space(),
                  AppTextField(
                    validator: (value) {
                      if (value.isEmpty) {
                        ctrl.update();
                        return LocaleKeys.pleaseEnterPhoneNumber.translateText;
                      }
                      ctrl.update();
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatter: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    hintText: LocaleKeys.enterPhoneNumber.translateText,
                    textEditingController: ctrl.mobileNumController,
                    labelText: LocaleKeys.clinicMobileNumber.translateText,
                    showPrefixIcon: false,
                    isError: ctrl.mobileNumError,
                    onChanged: (String value) {},
                  ),
                  15.space(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Checkbox(
                                hoverColor: primaryBrown,
                                activeColor: primaryBrown,
                                checkColor: Colors.white,
                                side:
                                    BorderSide(color: primaryBrown, width: 1.5),
                                value: ctrl.isEmailNotification,
                                onChanged: (bool? value) {
                                  ctrl.isEmailNotification =
                                      !ctrl.isEmailNotification;
                                  ctrl.update();
                                },
                              ),
                            ),
                            Expanded(
                              child: LocaleKeys.emailNotification.translateText
                                  .appCommonText(
                                    weight: FontWeight.w400,
                                    align: TextAlign.start,
                                    color: blackColor,
                                    size: !isTablet ? 16.sp : 18.sp,
                                  )
                                  .paddingOnly(left: 10, right: 10),
                            ),
                          ],
                        ).onClick(
                          () {
                            ctrl.isEmailNotification =
                                !ctrl.isEmailNotification;
                            ctrl.update();
                          },
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Checkbox(
                                hoverColor: primaryBrown,
                                activeColor: primaryBrown,
                                checkColor: Colors.white,
                                side:
                                    BorderSide(color: primaryBrown, width: 1.5),
                                value: ctrl.isMobileNotification,
                                onChanged: (bool? value) {
                                  ctrl.isMobileNotification =
                                      !ctrl.isMobileNotification;
                                  ctrl.update();
                                },
                              ),
                            ),
                            Expanded(
                              child: LocaleKeys.mobileNotification.translateText
                                  .appCommonText(
                                      weight: FontWeight.w400,
                                      align: TextAlign.start,
                                      color: blackColor,
                                      size: !isTablet ? 16.sp : 18.sp)
                                  .paddingOnly(left: 10, right: 10),
                            ),
                          ],
                        ).onClick(
                          () {
                            ctrl.isMobileNotification =
                                !ctrl.isMobileNotification;
                            ctrl.update();
                          },
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 15),
                  35.space(),
                  AppButton(
                    text: LocaleKeys.update.translateText,
                    btnHeight: !isTablet ? 53 : 68,
                    onTap: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (ctrl.editProfileFormKey.currentState!.validate()) {
                        FocusScope.of(Get.context!).unfocus();
                        ctrl.onUpdateProfileClick();
                      }
                    },
                    boxShadow: [],
                    radius: !isTablet ? 25 : 40,
                    fontSize: !isTablet ? 20 : 23,
                    bgColor: primaryBrown,
                    weight: FontWeight.w700,
                    fontColor: Colors.white,
                  ).paddingSymmetric(horizontal: 15),
                ],
              ),
            ),
            GetBuilder<EditProfileController>(
              builder: (controller) {
                return controller.isLoading
                    ? AppProgressView(progressColor: Colors.black)
                    : Container();
              },
            ),
          ],
        );
      }),
    );
  }
}
