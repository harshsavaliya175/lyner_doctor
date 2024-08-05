import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/patients_repo/patients_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/model/patient_details_model.dart';

class PatientsDetailsController extends GetxController {
  int selectedScreen = 0;
  bool isLoading = false;
  TextEditingController commentController = TextEditingController();
  PatientDetailsModel? patientDetailsModel;

  void changeData({int? selectedIndex}) {
    selectedScreen = selectedIndex ?? selectedScreen;
    update();
  }

  getPatientInformationDetails() async {
    isLoading = true;
    ResponseItem result =
        await PatientsRepo.getPatientInformationDetails(patientId: 167);
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          PatientDetailsResponseModel? patientDetailsResponseModel =
              PatientDetailsResponseModel.fromJson(result.data);
          patientDetailsModel = patientDetailsResponseModel.patientDetailsModel;
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
