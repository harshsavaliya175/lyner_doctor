import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/patients_repo/patients_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/model/lyner_connect_details_model.dart';

class LynerConnectDetailsController extends GetxController {
  String patientImagePath = '';
  TextEditingController currentStageController =
      TextEditingController(text: "");
  File? alignerLeftImageFile;
  File? alignerCentreImageFile;
  File? alignerRightImageFile;
  File? withoutAlignerRightImageFile;
  File? withoutAlignerLeftImageFile;
  File? withoutAlignerCentreImageFile;
  var userId;
  bool isLoading = false;
  bool showCurrentStageDropDown = false;
  LynerConnectDetailsData? lynerConnectDetailsData;
  Gallery? selectedGalleryData;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userId = Get.arguments;
    getLynerConnectDetailsApi();
  }

  void getLynerConnectDetailsApi() async {
    isLoading = true;
    // lynerConnectList.clear();
    ResponseItem result =
        await PatientsRepo.getLynerConnectDetails(userId: userId);
    try {
      if (result.status) {
        if (result.data != null) {
          LynerConnectDetailsModel lynerConnectListModel =
              LynerConnectDetailsModel.fromJson(result.toJson());
          lynerConnectDetailsData = lynerConnectListModel.data;
          print(lynerConnectDetailsData);
          currentStageController.text =
              "Stage ${lynerConnectDetailsData?.gallery?[0].alignerStage} (${lynerConnectDetailsData?.gallery?[0].stageCompletedDate?.ddMMYYYYFormat()})";
          selectedGalleryData = lynerConnectDetailsData?.gallery?[0];
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

  void onAlignerStageTap() {
    showCurrentStageDropDown = !showCurrentStageDropDown;
    update();
    // showAlignerStageDialog();
  }

  /*void showAlignerStageDialog() {
    Get.bottomSheet(
      Container(
        height: 250,
        decoration: BoxDecoration(
            color: appBgColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25), topLeft: Radius.circular(25))),
        child: ListView.builder(
          itemCount: lynerConnectDetailsData?.gallery?.length,
          itemBuilder: (context, index) {
            var galleryData = lynerConnectDetailsData?.gallery?[index];
            var isSelected =
                ("Stage ${galleryData?.alignerStage} (${galleryData?.stageCompletedDate?.ddMMYYYYFormat()})" ==
                    currentStageController.text);
            return ListTile(
              title:
                  "Stage ${galleryData?.alignerStage} (${galleryData?.stageCompletedDate?.ddMMYYYYFormat()})"
                      .appCommonText(
                size: 16,
                align: TextAlign.start,
                color: isSelected ? primaryBrown : Colors.black,
                weight: isSelected ?FontWeight.w600:FontWeight.w400,
              ),
              trailing: isSelected
                  ? Assets.icons.icSelect
                      .svg(height: 18, width: 18, color: primaryBrown)
                  : null,
              onTap: () {
                // Update the current aligner stage
                updateGalleryImageData(galleryData!);
                Get.back(); // Close the bottom sheet
              },
            );
          },
        ),
      ),
    );
  }*/

  void updateGalleryImageData(Gallery galleryData) {
    currentStageController.text =
        "Stage ${galleryData.alignerStage} (${galleryData.stageCompletedDate?.ddMMYYYYFormat()})";

    selectedGalleryData = galleryData;
    update();
  }
}
