import 'dart:isolate';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/utils/base_binding.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';
import 'package:lynerdoctor/generated/codegen_loader.g.dart';

// void downloadCallback(String id, int status, int progress) {
//   final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
//   send?.send([id, status, progress]);
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await FlutterDownloader.initialize(
  //   debug: true, // Optional: set to false to disable printing logs to the console
  // );
  // FlutterDownloader.registerCallback(downloadCallback);
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableLevels = [
    LevelMessages.error,
    LevelMessages.warning
  ];

  await preferences.init();
  await preferences.putAppDeviceInfo();
  runApp(EasyLocalization(
    supportedLocales: const [Locale('en', '')],
    path: 'assets/translations',
    assetLoader: const CodegenLoader(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // designSize: Size(MediaQuery.of(context).size.width >= 500?600:430, 932),
      designSize: Size(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context2, Widget? child) {
        // ScreenUtil.init(context);
        return GetMaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
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
