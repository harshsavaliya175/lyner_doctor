import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:lynerdoctor/core/utils/face_detector/face_detector_view.dart';
import 'package:lynerdoctor/ui/screens/auth/change_password/change_password_screen.dart';
import 'package:lynerdoctor/ui/screens/auth/edit_profile/edit_profile.dart';
import 'package:lynerdoctor/ui/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:lynerdoctor/ui/screens/auth/reset_password/reset_password_screen.dart';
import 'package:lynerdoctor/ui/screens/auth/sign_up/signUp_logIn_screen.dart';
import 'package:lynerdoctor/ui/screens/auth/splash/splash_screen.dart';
import 'package:lynerdoctor/ui/screens/main/add_patient/add_patient.dart';
import 'package:lynerdoctor/ui/screens/main/dash_board/dashboard_screen.dart';
import 'package:lynerdoctor/ui/screens/main/devis/devis_screen.dart';
import 'package:lynerdoctor/ui/screens/main/financial/financial_screen.dart';
import 'package:lynerdoctor/ui/screens/main/global_search/global_search_screen.dart';
import 'package:lynerdoctor/ui/screens/main/lyner_connect/add_edit_lyner_connect/add_edit_lyner_connect.dart';
import 'package:lynerdoctor/ui/screens/main/lyner_connect/lyner_connect_add_patient/add_new_patient.dart';
import 'package:lynerdoctor/ui/screens/main/lyner_connect/lyner_connect_details/lyner_connect_details.dart';
import 'package:lynerdoctor/ui/screens/main/patients_details/patients_details_screen.dart';
import 'package:lynerdoctor/ui/screens/main/patients_details/treatment_planning_screen.dart';
import 'package:lynerdoctor/ui/screens/main/upload_photographs/upload_photographs.dart';

class Routes {
  Routes._();

  static const String splash = "/splash";
  static const String signUpSignInScreen = "/signUpSignInScreen";
  static const String forgotPasswordScreen = "/forgotPasswordScreen";
  static const String resetPasswordScreen = "/resetPasswordScreen";
  static const String treatmentPlanning = "/treatmentPlanning";
  static const String dashboardScreen = "/dashboardScreen";
  static const String addPatientScreen = "/addPatientScreen";
  static const String devisScreen = "/devisScreen";
  static const String changePasswordScreen = "/changePasswordScreen";
  static const String editProfile = "/editProfile";
  static const String addLynerConnect = "/addLynerConnect";
  static const String lynerConnectDetails = "/lynerConnectDetails";
  static const String addEditLynerConnect = "/addEditLynerConnect";
  static const String patientsDetailsScreen = "/patientsDetailsScreen";
  static const String faceDetectorView = "/faceDetectorView";
  static const String financialScreen = "/financialScreen";
  static const String globalSearchScreen = "/globalSearchScreen";
  static const String uploadPhotographsScreen = "/uploadPhotographsScreen";

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
    GetPage(name: Routes.devisScreen, page: () => DevisScreen()),
    GetPage(name: Routes.editProfile, page: () => EditProfile()),
    GetPage(name: Routes.addLynerConnect, page: () => AddNewPatient()),
    GetPage(
        name: Routes.lynerConnectDetails, page: () => LynerConnectDetails()),
    GetPage(
        name: Routes.addEditLynerConnect, page: () => AddEditLynerConnect()),
    GetPage(
        name: Routes.treatmentPlanning, page: () => TreatmentPlanningScreen()),
    GetPage(
        name: Routes.patientsDetailsScreen,
        page: () => PatientsDetailsScreen()),
    GetPage(
        name: Routes.faceDetectorView, page: () => const FaceDetectorView()),
    GetPage(name: Routes.financialScreen, page: () => const FinancialScreen()),
    GetPage(name: Routes.globalSearchScreen, page: () => GlobalSearchScreen()),
    GetPage(
        name: Routes.uploadPhotographsScreen,
        page: () => UploadPhotographsScreen()),
  ];
}
