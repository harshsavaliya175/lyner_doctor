import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/config/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context2, child) {
        // ScreenUtil.init(context);
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Lyner Doctor',
          getPages: Routes.pages,
          initialRoute: Routes.splash,);
      },
    );
  }
}
