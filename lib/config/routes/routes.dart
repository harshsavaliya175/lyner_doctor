import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:lynerdoctor/ui/screens/auth/sign_up/signUp_logIn_screen.dart';
import 'package:lynerdoctor/ui/screens/auth/splash/splash_screen.dart';
import 'package:lynerdoctor/ui/screens/main/add_patient/add_patient.dart';

class Routes {
  Routes._();

  static const String splash = "/splash";
  static const String signUpScreen = "/signUpScreen";
  static const String addPatientScreen = "/addPatientScreen";

  static List<GetPage> pages = [
    GetPage(name: Routes.splash, page: () => const SplashScreen()),
    GetPage(name: Routes.signUpScreen, page: () =>  SignUpScreen()),
    GetPage(name: Routes.addPatientScreen, page: () =>  AddPatientScreen()),
  ];
}
