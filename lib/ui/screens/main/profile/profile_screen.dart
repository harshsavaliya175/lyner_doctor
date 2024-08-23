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

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final controller = Get.put(ProfileController());
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
      body: GetBuilder<ProfileController>(builder: (ctrl) {
        return ListView(
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
                      path: ApiUrl.clinicProfileImagePath +
                          '${preferences.getString(SharedPreference.CLINIC_PHOTO)}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  16.w.space(),
                  (ctrl.clinicData?.clinicName ?? "Jane Cooper").normalText(
                    color: blackColor,
                    fontWeight: FontWeight.w500,
                    fontSize: !isTablet ? 20 : 26,
                  ),
                  8.w.space(),
                  (ctrl.clinicData?.email ?? "Janecooperlyner@gmail.com")
                      .normalText(
                    color: hintStepColor,
                    fontWeight: FontWeight.w400,
                    fontSize: !isTablet ? 14 : 20,
                  ),
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
              leadingIcon: Assets.icons.icLogout,
              title: LocaleKeys.logOut,
              leadingIconColor: Colors.red,
              onTap: () {
                ctrl.logout();
              },
            ),
            !isTablet ? 20.space() : 100.space(),
          ],
        );
      }),
    );
  }

  Widget profileScreenItem({
    required SvgGenImage leadingIcon,
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
              leadingIcon.svg(
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
