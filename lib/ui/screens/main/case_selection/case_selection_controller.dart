import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/patients_repo/patients_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/model/patient_resposne_model.dart';

class CaseSelectionController extends GetxController {
  bool isLoading = false;
  int caseSelectionFilterValue = 1;
  List<PatientResponseData?> patientList = [];

  TextEditingController searchController = TextEditingController();

  getClinicListBySearchOrFilter({bool isFromSearch = false}) async {
    if (!isFromSearch) {
      isLoading = true;
    }
    ResponseItem result = await PatientsRepo.getClinicListBySearchOrFilter(
      clinicLocationId: "clinicLocationId",
      filterType: "filterType",
      searchText: searchController.text.trim(),
      sessionDoctorId: "sessionDoctorId",
      treatmentStatus: "treatmentStatusFilter",
    );
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          patientList.clear();
          PatientResponseModel patientResponseModel =
              PatientResponseModel.fromJson(result.toJson());
          patientList.addAll(patientResponseModel.patientData!);
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
