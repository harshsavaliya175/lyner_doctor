import 'package:get/get.dart';

class PatientsDetailsController extends GetxController {
  int selectedScreen = 0;

  void changeData({int? selectedIndex}) {
    selectedScreen = selectedIndex ?? selectedScreen;
    update();
  }
}
