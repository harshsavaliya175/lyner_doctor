import 'package:get/get.dart';
import 'package:lynerdoctor/ui/screens/auth/change_password/change_password_controller.dart';
import 'package:lynerdoctor/ui/screens/auth/forgot_password/forgot_password_controller.dart';
import 'package:lynerdoctor/ui/screens/auth/reset_password/reset_password_controller.dart';
import 'package:lynerdoctor/ui/screens/auth/sign_up/signUp_logIn_controller.dart';
import 'package:lynerdoctor/ui/screens/main/add_patient/add_patient_controller.dart';
import 'package:lynerdoctor/ui/screens/main/dash_board/dashboard_controller.dart';
import 'package:lynerdoctor/ui/screens/main/financial/financial_controller.dart';
import 'package:lynerdoctor/ui/screens/main/library/library_controller.dart';
import 'package:lynerdoctor/ui/screens/main/lyner_connect/lyner_connect_home/lyner_connect_controller.dart';
import 'package:lynerdoctor/ui/screens/main/patients/patients_controller.dart';
import 'package:lynerdoctor/ui/screens/main/profile/profile_controller.dart';

class BaseBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpSignInController(), fenix: true);
    Get.lazyPut(() => ForgotPasswordController(), fenix: true);
    Get.lazyPut(() => ResetPasswordController(), fenix: true);
    Get.lazyPut(() => AddPatientController(), fenix: true);
    Get.lazyPut(() => DashboardController(), fenix: true);
    Get.lazyPut(() => PatientsController(), fenix: true);
    Get.lazyPut(() => LynerConnectController(), fenix: true);
    Get.lazyPut(() => LibraryController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => ChangePasswordController(), fenix: true);
    Get.lazyPut(() => FinancialController(), fenix: true);
  }
}
