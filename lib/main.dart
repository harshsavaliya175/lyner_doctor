import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/config/themes/app_theme.dart';
import 'package:lynerdoctor/core/utils/base_binding.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';
import 'package:lynerdoctor/generated/codegen_loader.g.dart';

import 'core/utils/firebase_options.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackGroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    log('some notification received');
    await Firebase.initializeApp();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableLevels = [
    LevelMessages.error,
    LevelMessages.warning
  ];
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackGroundHandler);
  await FlutterDownloader.initialize(debug: true);
  await preferences.init();
  await preferences.putAppDeviceInfo();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('fr')],
      path: 'assets/translations',
      saveLocale: true,
      useOnlyLangCode: true,
      startLocale: const Locale('fr'),
      fallbackLocale: const Locale('fr'),
      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // designSize: Size(MediaQuery.of(context).size.width >= 500?600:430, 932),
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context2, Widget? child) {
        return GetMaterialApp(
          theme: AppTheme.lightTheme,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: 'Lyner Doctor',
          getPages: Routes.pages,
          initialBinding: BaseBindings(),
          initialRoute: Routes.splash,
        );
      },
    );
  }
}
