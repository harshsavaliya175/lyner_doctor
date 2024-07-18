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
        Get.offAllNamed(Routes.signInSignUp);
        // if (preferences.getBool(SharedPreference.IS_LOGGED_IN) ?? false) {
        //   //Get.offAllNamed(Routes.home);
        // } else {
        //   //Get.offAllNamed(Routes.auth);
        //   // Get.offAllNamed(Routes.login);
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
