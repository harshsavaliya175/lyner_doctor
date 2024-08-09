import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/patients_repo/patients_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/model/lyner_connect_details_model.dart';

class LynerConnectDetailsController extends GetxController{
  String patientImagePath='';
  TextEditingController currentStageController = TextEditingController(text: "Stage1 (14/07/2024)");
  File? alignerLeftImageFile;
  File? alignerCentreImageFile;
  File? alignerRightImageFile;
  File? withoutAlignerRightImageFile;
  File? withoutAlignerLeftImageFile;
  File? withoutAlignerCentreImageFile;
  var userId;
  bool isLoading = false;
  LynerConnectDetailsData? lynerConnectDetailsData;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userId = Get.arguments;
    getLynerConnectDetailsApi();
  }
  void getLynerConnectDetailsApi() async{
    isLoading = true;
    // lynerConnectList.clear();
    ResponseItem result = await PatientsRepo.getLynerConnectDetails(userId: userId);
    try {
      if (result.status) {
        if (result.data != null) {
          LynerConnectDetailsModel lynerConnectListModel =
          LynerConnectDetailsModel.fromJson(result.toJson());
          lynerConnectDetailsData = lynerConnectListModel.data;
          // lynerConnectDetailsModel.addAll(lynerConnectListModel.data!);
          print(lynerConnectDetailsData);
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