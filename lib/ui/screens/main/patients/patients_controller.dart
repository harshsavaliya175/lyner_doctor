import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/patients_repo/patients_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';
import 'package:lynerdoctor/model/clinic_location_model.dart';
import 'package:lynerdoctor/model/doctor_model.dart';

class PatientsController extends GetxController {
  bool isLoading = true; //for testing
  dynamic filterRadioGroupValue = 0;
  bool isDataNotFound = true; //for testing
  String appbarSubTitle = 'All';
  TextEditingController searchController = TextEditingController();
  List<DoctorData?> doctorDataList = [];
  List<ClinicLocation?> clinicLocationList = [];

  @override
  void onInit() {
    getDoctorList();
    getClinicLocationList();
    super.onInit();
  }

  void changeData({dynamic filterGroupValue}) {
    filterRadioGroupValue = filterGroupValue ?? filterRadioGroupValue;
    update();
  }

  getDoctorList() async {
    doctorDataList.clear();
    isLoading = true;
    ResponseItem result = await PatientsRepo.getDoctorListByClinicId(
        clinicId: preferences.getInt(SharedPreference.CLINIC_ID) ?? 0);
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          result.data.forEach(
            (dynamic e) {
              DoctorData doctorData = DoctorData.fromJson(e);
              doctorDataList.add(doctorData);
            },
          );
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

  getClinicLocationList() async {
    clinicLocationList.clear();
    isLoading = true;
    ResponseItem result = await PatientsRepo.getClinicLocationList(
        clinicId: preferences.getInt(SharedPreference.CLINIC_ID) ?? 0);
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          result.data.forEach(
            (dynamic e) {
              ClinicLocation clinicLocation = ClinicLocation.fromJson(e);
              clinicLocationList.add(clinicLocation);
            },
          );
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
