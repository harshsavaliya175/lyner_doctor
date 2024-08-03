import 'package:get/get.dart';
import 'package:lynerdoctor/ui/screens/main/library/library_screen.dart';
import 'package:lynerdoctor/ui/screens/main/lyner_connect/lyner_connect_home/lyner_connect_screen.dart';
import 'package:lynerdoctor/ui/screens/main/patients/patients_screen.dart';
import 'package:lynerdoctor/ui/screens/main/profile/profile_screen.dart';

class DashboardController extends GetxController {
  int currentIndex = 0;

  List screen = [
    PatientsScreen(),
    LynerConnectScreen(),
    LibraryScreen(),
    ProfileScreen()
  ];

  void changeData({int? currentIdx}) {
    currentIndex = currentIdx ?? currentIndex;
    update();
  }
}
