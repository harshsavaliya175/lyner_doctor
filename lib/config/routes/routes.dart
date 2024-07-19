import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:lynerdoctor/ui/auth/splash/splash_screen.dart';

import '../../ui/auth/sign_up/signUp_logIn_screen.dart';

class Routes {
  Routes._();

  static const String splash = "/splash";
  static const String signUpScreen = "/signUpScreen";

  static List<GetPage> pages = [
    GetPage(name: Routes.splash, page: () => const SplashScreen()),
    GetPage(name: Routes.signUpScreen, page: () =>  SignUpScreen()),
  ];
}
