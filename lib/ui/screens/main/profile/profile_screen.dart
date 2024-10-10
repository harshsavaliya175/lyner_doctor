import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/home_image.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/profile/profile_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_progress_view.dart';
import 'package:lynerdoctor/ui/widgets/common_dialog.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: false,
        title: Text(
          LocaleKeys.myProfile.translateText,
          style: TextStyle(
            fontFamily: Assets.fonts.maax,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: !isTablet ? 20 : 25,
          ),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[300],
        elevation: 0.5,
        scrolledUnderElevation: 0,
      ),
      body: GetBuilder<ProfileController>(builder: (ProfileController ctrl) {
        return Stack(
          children: [
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 20, right: 20, top: 24),
              children: [
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: skyColor, width: 1),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      24.w.space(),
                      Container(
                        height: !isTablet ? 120.w : 140.w,
                        width: !isTablet ? 120.w : 140.w,
                        child: HomeImage.networkImage(
                          path: preferences.getClinicData()?.type ==
                                  SharedPreference.LOGIN_TYPE_DOCTOR
                              ? ApiUrl.doctorProfileImagePath +
                                  '${preferences.getString(SharedPreference.CLINIC_PHOTO)}'
                              : ApiUrl.clinicProfileImagePath +
                                  '${preferences.getString(SharedPreference.CLINIC_PHOTO)}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      16.w.space(),
                      (ctrl.clinicData?.clinicName ?? "").normalText(
                        color: blackColor,
                        fontWeight: FontWeight.w500,
                        fontSize: !isTablet ? 20 : 26,
                      ),
                      // 8.w.space(),
                      // (ctrl.clinicData?.email ?? "").normalText(
                      //   color: hintStepColor,
                      //   fontWeight: FontWeight.w400,
                      //   fontSize: !isTablet ? 14 : 20,
                      // ),
                      24.w.space(),
                    ],
                  ),
                ),
                20.space(),
                profileScreenItem(
                  leadingIcon: Assets.icons.icFinancial,
                  title: LocaleKeys.financial,
                  onTap: () {
                    Get.toNamed(Routes.financialScreen);
                  },
                ),
                16.space(),
                profileScreenItem(
                  leadingIcon: Assets.icons.icEditProfile,
                  title: LocaleKeys.editProfile,
                  onTap: () {
                    Get.toNamed(Routes.editProfile);
                  },
                ),
                16.space(),
                profileScreenItem(
                  leadingIcon: Assets.icons.lock,
                  title: LocaleKeys.changePassword,
                  onTap: () {
                    Get.toNamed(Routes.changePasswordScreen);
                  },
                ),
                16.space(),
                profileScreenItem(
                  leading: Icon(
                    Icons.language,
                    size: !isTablet ? 24 : 30,
                  ),
                  title: LocaleKeys.changeLanguage,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          insetPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          titlePadding: EdgeInsets.zero,
                          actionsPadding: EdgeInsets.zero,
                          surfaceTintColor: Colors.white,
                          backgroundColor: Colors.white,
                          content: Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LocaleKeys.selectLanguage.translateText
                                    .normalText(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    )
                                    .paddingOnly(top: 20, left: 20),
                                15.space(),
                                ListTile(
                                  onTap: () {
                                    ctrl.changeLanguage('fr');
                                  },
                                  dense: true,
                                  leading: Radio(
                                    value: 'fr',
                                    groupValue: ctrl.languageCode,
                                    onChanged: (String? value) {
                                      ctrl.changeLanguage('fr');
                                    },
                                    activeColor: Colors.black,
                                    fillColor:
                                        WidgetStateProperty.all(Colors.black),
                                  ),
                                  title: 'French'.boldText(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                                ListTile(
                                  onTap: () {
                                    ctrl.changeLanguage('en');
                                  },
                                  dense: true,
                                  leading: Radio(
                                    value: 'en',
                                    groupValue: ctrl.languageCode,
                                    onChanged: (String? value) {
                                      ctrl.changeLanguage('en');
                                    },
                                    activeColor: Colors.black,
                                    fillColor:
                                        WidgetStateProperty.all(Colors.black),
                                  ),
                                  title: 'English'.boldText(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                                5.space(),
                                // Container(
                                //   height: 40,
                                //   width: Get.width,
                                //   child: Row(
                                //     children: [
                                //       10.spaceW(),
                                //       Radio(
                                //         value: 'fr',
                                //         groupValue:
                                //             ctrl.languageCode,
                                //         onChanged: (String? value) {
                                //           ctrl.changeLanguage('en');
                                //         },
                                //         activeColor: Colors.black,
                                //         fillColor:
                                //             WidgetStateProperty.all(
                                //                 Colors.black),
                                //       ),
                                //       'French'.boldText(
                                //         fontWeight: FontWeight.w400,
                                //         fontSize: 16,
                                //         color: appBlackColor,
                                //       ),
                                //     ],
                                //   ),
                                // ).onClick(
                                //   () {
                                //     ctrl.changeLanguage('fr');
                                //   },
                                // ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                16.space(),
                profileScreenItem(
                  leadingIcon: Assets.icons.icDeleteIcon,
                  title: LocaleKeys.deleteAccount,
                  leadingIconColor: Colors.red,
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: Get.context!,
                      builder: (BuildContext context) {
                        return CommonDialog(
                          dialogBackColor: Colors.white,
                          tittleText: LocaleKeys.deleteAccount.translateText,
                          buttonText: LocaleKeys.delete.translateText,
                          buttonCancelText: LocaleKeys.cancel.translateText,
                          descriptionText: LocaleKeys
                              .areYouSureYouWantToDeleteYourAccount
                              .translateText,
                          cancelOnTap: () => Get.back(),
                          onTap: () {
                            Get.back();
                            ctrl.isLoading = true;
                            ctrl.update();
                            Future.delayed(
                              Duration(seconds: 3),
                              () {
                                ctrl.isLoading = false;
                                showAppSnackBar(LocaleKeys
                                    .afterDeleteAccountShowSnackBarText
                                    .translateText);
                                preferences.clearUserItem();
                                Get.offAllNamed(Routes.signUpSignInScreen);
                              },
                            );
                          },
                          alignment: Alignment.center,
                        );
                      },
                    );
                  },
                ),
                16.space(),
                profileScreenItem(
                  leadingIcon: Assets.icons.icLogout,
                  title: LocaleKeys.logOut,
                  leadingIconColor: Colors.red,
                  onTap: () {
                    ctrl.logout();
                  },
                ),
                !isTablet ? 100.space() : 150.space(),
              ],
            ),
            ctrl.isLoading
                ? AppProgressView(progressColor: Colors.black)
                : Container()
          ],
        );
      }),
    );
  }

  Widget profileScreenItem({
    SvgGenImage? leadingIcon,
    Widget? leading,
    Color leadingIconColor = blackColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        onTap: () {
          onTap();
        },
        borderRadius: BorderRadius.circular(100),
        child: Container(
          width: Get.width,
          height: !isTablet ? 60.w : 70.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: skyColor, width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              20.space(),
              leading ??
                  leadingIcon!.svg(
                    height: !isTablet ? 24 : 30,
                    width: !isTablet ? 24 : 30,
                    colorFilter:
                        ColorFilter.mode(leadingIconColor, BlendMode.srcIn),
                  ),
              12.space(),
              Expanded(
                child: title.translateText.normalText(
                  color: leadingIconColor,
                  fontSize: !isTablet ? 16 : 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: primaryBrown,
                size: !isTablet ? 20 : 24,
              ),
              20.space(),
            ],
          ),
        ),
      ),
    );
  }
}
