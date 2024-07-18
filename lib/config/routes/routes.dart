import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:lynerdoctor/ui/auth/splash/splash_screen.dart';

class Routes {
  Routes._();

  static const String splash = "/splash";
  static const String signInSignUp = "/signInSignUp";

  static List<GetPage> pages = [
    GetPage(name: Routes.splash, page: () => const SplashScreen()),
    GetPage(name: Routes.splash, page: () => const SplashScreen()),
  ];
}
