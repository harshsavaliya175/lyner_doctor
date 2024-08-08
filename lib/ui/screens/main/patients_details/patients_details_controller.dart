import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/patients_repo/patients_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/model/comment_model.dart';
import 'package:lynerdoctor/model/patient_details_model.dart';

class PatientsDetailsController extends GetxController {
  int selectedScreen = 0;
  bool isLoading = false;
  TextEditingController commentController = TextEditingController();
  PatientDetailsModel? patientDetailsModel;
  List<CommentModel?> commentModelList = [];

  @override
  void onInit() {
    getPatientCommentsDetails();
    super.onInit();
  }

  void changeData({int? selectedIndex}) {
    selectedScreen = selectedIndex ?? selectedScreen;
    update();
  }

  getPatientInformationDetails() async {
    isLoading = true;
    ResponseItem result =
        await PatientsRepo.getPatientInformationDetails(patientId: 191);
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          patientDetailsModel = PatientDetailsModel.fromJson(result.data);
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

  getPatientCommentsDetails() async {
    isLoading = true;
    commentModelList.clear();
    ResponseItem result =
        await PatientsRepo.getPatientCommentsDetails(patientId: 134);
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          List commentDataList = result.data as List;
          for (int i = 0; i < commentDataList.length; i++) {
            CommentModel? commentModel =
                CommentModel.fromJson(commentDataList[i]);
            commentModelList.add(commentModel);
          }
          isLoading = false;
        }
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
      log("error ------> $e");
    }
    update();
  }
}
