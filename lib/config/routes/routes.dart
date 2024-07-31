import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:lynerdoctor/ui/screens/auth/change_password/change_password_screen.dart';
import 'package:lynerdoctor/ui/screens/auth/edit_profile/edit_profile.dart';
import 'package:lynerdoctor/ui/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:lynerdoctor/ui/screens/auth/reset_password/reset_password_screen.dart';
import 'package:lynerdoctor/ui/screens/auth/sign_up/signUp_logIn_screen.dart';
import 'package:lynerdoctor/ui/screens/auth/splash/splash_screen.dart';
import 'package:lynerdoctor/ui/screens/main/add_patient/add_patient.dart';
import 'package:lynerdoctor/ui/screens/main/dash_board/dashboard_screen.dart';

class Routes {
  Routes._();

  static const String splash = "/splash";
  static const String signUpSignInScreen = "/signUpSignInScreen";
  static const String forgotPasswordScreen = "/forgotPasswordScreen";
  static const String resetPasswordScreen = "/resetPasswordScreen";
  static const String dashboardScreen = "/dashboardScreen";
  static const String addPatientScreen = "/addPatientScreen";
  static const String changePasswordScreen = "/changePasswordScreen";
  static const String editProfile = "/editProfile";

  static List<GetPage> pages = [
    GetPage(name: Routes.splash, page: () => const SplashScreen()),
    GetPage(name: Routes.signUpSignInScreen, page: () => SignUpSignInScreen()),
    GetPage(
        name: Routes.forgotPasswordScreen, page: () => ForgotPasswordScreen()),
    GetPage(
        name: Routes.resetPasswordScreen, page: () => ResetPasswordScreen()),
    GetPage(
        name: Routes.changePasswordScreen, page: () => ChangePasswordScreen()),
    GetPage(name: Routes.dashboardScreen, page: () => DashboardScreen()),
    GetPage(name: Routes.addPatientScreen, page: () => AddPatientScreen()),
    GetPage(name: Routes.editProfile, page: () => EditProfile()),
  ];
}
