import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/patients_repo/patients_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/model/lyner_patient_list_model.dart';

class AddNewPatientController extends GetxController {
  TextEditingController searchController = TextEditingController();
  List<LynerPatientListData?> lynerPatientListData = [];
  var selectedIndex = (-1); // Use -1 to indicate no selection
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    getLynerConnectPatientList();
  }

  void togglePatientSelection(int index) {
    if (selectedIndex == index) {
      selectedIndex = -1; // Deselect if already selected
    } else {
      selectedIndex = index; // Select the new index
    }
    update();
  }

  void getLynerConnectPatientList({bool isFromSearch = false}) async {
    if (!isFromSearch) {
      isLoading = true;
    }
    lynerPatientListData.clear();
    ResponseItem result = await PatientsRepo.getLynerConnectPatientsList(
        searchText: searchController.text);
    try {
      if (result.status) {
        if (result.data != null) {
          lynerPatientListData.clear();
          LynerConnectPatientListModel lynerConnectPatientListModel =
              LynerConnectPatientListModel.fromJson(result.toJson());
          lynerPatientListData.addAll(lynerConnectPatientListModel.data!);
          print(lynerConnectPatientListModel);
          isLoading = false;
        }
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
    }
    update();
  }
}
