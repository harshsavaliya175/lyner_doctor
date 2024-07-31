import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/patients_repo/patients_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';
import 'package:lynerdoctor/model/clinic_location_model.dart';
import 'package:lynerdoctor/model/doctor_model.dart';
import 'package:lynerdoctor/model/patient_model.dart';

class PatientsController extends GetxController {
  bool isDataNotFound = true; //for testing
  bool isLoading = true; //for testing
  int treatmentStatusFilterValue = 1;
  String treatmentStatusFilter = 'task';
  dynamic allDoctorAndClinicAddressGroupValue = 'All';
  String appbarSubTitle = 'All';
  String filterType = '';
  String clinicLocationId = '';
  String sessionDoctorId = '';

  TextEditingController searchController = TextEditingController();

  List<DoctorData?> doctorDataList = [];
  List<ClinicLocation?> clinicLocationList = [];
  List<PatientData?> patientList = [];

  @override
  void onInit() {
    getDoctorList();
    getClinicLocationList();
    getClinicListBySearchOrFilter();
    super.onInit();
  }

  void changeData({
    int? treatmentStatusValue,
    String? treatmentStatus,
    dynamic allDoctorAndClinicAddressValue,
    String? appbarSubTitleValue,
    String? clinicLocationIdValue,
    String? sessionDoctorIdValue,
    String? filterTypeValue,
  }) {
    treatmentStatusFilterValue =
        treatmentStatusValue ?? treatmentStatusFilterValue;
    allDoctorAndClinicAddressGroupValue =
        allDoctorAndClinicAddressValue ?? allDoctorAndClinicAddressGroupValue;
    treatmentStatusFilter = treatmentStatus ?? treatmentStatusFilter;
    appbarSubTitle = appbarSubTitleValue ?? appbarSubTitle;
    clinicLocationId = clinicLocationIdValue ?? clinicLocationId;
    sessionDoctorId = sessionDoctorIdValue ?? sessionDoctorId;
    filterType = filterTypeValue ?? filterType;
    update();
  }

  getDoctorList() async {
    doctorDataList.clear();
    ResponseItem result = await PatientsRepo.getDoctorListByClinicId(
        clinicId: preferences.getInt(SharedPreference.CLINIC_ID) ?? 0);
    try {
      if (result.status) {
        if (result.data != null) {
          result.data.forEach(
            (dynamic e) {
              DoctorData doctorData = DoctorData.fromJson(e);
              doctorDataList.add(doctorData);
            },
          );
        }
      }
    } catch (e) {
      log('error --> $e');
    }
    update();
  }

  getClinicLocationList() async {
    clinicLocationList.clear();
    ResponseItem result = await PatientsRepo.getClinicLocationList(
        clinicId: preferences.getInt(SharedPreference.CLINIC_ID) ?? 0);
    try {
      if (result.status) {
        if (result.data != null) {
          result.data.forEach(
            (dynamic e) {
              ClinicLocation clinicLocation = ClinicLocation.fromJson(e);
              clinicLocationList.add(clinicLocation);
            },
          );
        }
      }
    } catch (e) {
      log('error --> $e');
    }
    update();
  }

  getClinicListBySearchOrFilter({bool isFromSearch = false}) async {
    if (!isFromSearch) {
      isLoading = true;
    }
    patientList.clear();
    ResponseItem result = await PatientsRepo.getClinicListBySearchOrFilter(
      clinicLocationId: clinicLocationId,
      filterType: filterType,
      searchText: searchController.text.trim(),
      sessionDoctorId: sessionDoctorId,
      treatmentStatus: treatmentStatusFilter,
    );
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          result.data.forEach(
            (dynamic e) {
              PatientData patientData = PatientData.fromJson(e);
              patientList.add(patientData);
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
