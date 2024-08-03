import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LynerConnectDetailsController extends GetxController{
  String patientImagePath='';
  TextEditingController currentStageController = TextEditingController(text: "Stage1 (14/07/2024)");
  File? alignerLeftImageFile;
  File? alignerCentreImageFile;
  File? alignerRightImageFile;
  File? withoutAlignerRightImageFile;
  File? withoutAlignerLeftImageFile;
  File? withoutAlignerCentreImageFile;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}