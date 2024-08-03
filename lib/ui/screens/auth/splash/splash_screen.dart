import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then(
      (dynamic value) {
        Get.offAllNamed(Routes.patientsDetailsScreen);
        // if (preferences.getBool(SharedPreference.IS_LOGGED_IN) ?? false) {
        //   Get.offAllNamed(Routes.dashboardScreen);
        // } else {
        //   Get.offAllNamed(Routes.signUpSignInScreen);
        // }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: primaryBrown,
        child: Center(
          child: Assets.images.imgSplash.svg(),
        ),
      ),
    );
  }
}
