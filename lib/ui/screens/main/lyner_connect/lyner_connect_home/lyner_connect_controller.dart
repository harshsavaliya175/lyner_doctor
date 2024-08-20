import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/patients_repo/patients_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/model/lyner_connect_list_model.dart';
import 'package:lynerdoctor/ui/widgets/common_dialog.dart';

class LynerConnectController extends GetxController {
  bool isLoading = false;
  List<LynerConnectList?> lynerConnectList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLynerConnectList();
  }

  void getLynerConnectList() async {
    isLoading = true;
    lynerConnectList.clear();
    ResponseItem result = await PatientsRepo.getLynerConnectList();
    try {
      if (result.status) {
        if (result.data != null) {
          LynerConnectListModel lynerConnectListModel =
              LynerConnectListModel.fromJson(result.toJson());
          lynerConnectList.addAll(lynerConnectListModel.data!);
          print(lynerConnectList);
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

  void callDeletePatientApi(int? userId) async {
    isLoading = true;
    Get.back();
    ResponseItem result = await PatientsRepo.deleteLynerConnect(
      userId: userId!,
    );
    try {
      if (result.status) {
        showAppSnackBar(result.msg);
        getLynerConnectList();
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
    }
    update();
  }

  void deletePatient(int? userId) {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) {
        return CommonDialog(
          dialogBackColor: Colors.white,
          tittleText: LocaleKeys.deletePatient.translateText,
          buttonText: LocaleKeys.confirm.translateText,
          buttonCancelText: LocaleKeys.cancel.translateText,
          descriptionText: LocaleKeys.areYouSureWantDeletePatient.translateText,
          cancelOnTap: () => Get.back(),
          onTap: () {
            callDeletePatientApi(userId);
          },
          alignment: Alignment.center,
        );
      },
    );
  }
}
