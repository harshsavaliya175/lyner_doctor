import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/patients_repo/patients_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/model/global_search_model.dart';
import 'package:lynerdoctor/model/lyner_connect_list_model.dart';
import 'package:lynerdoctor/ui/widgets/common_dialog.dart';

class GlobalSearchController extends GetxController {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  GlobalSearchModel? globalSearchModel;
  List<Archive?> archiveData = [];
  List<Archive?> patientTaskData = [];
  List<Archive?> patientData = [];
  List<LynerConnectList?> lynerConnectData = [];

  @override
  void onInit() {
    globalSearch();
    super.onInit();
  }

  globalSearch({bool isFromSearch = false}) async {
    if (!isFromSearch) {
      isLoading = true;
    }
    ResponseItem result = await PatientsRepo.getGlobalSearchData(
      searchText: searchController.text.trim(),
    );
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          globalSearchModel = null;
          GlobalSearchModel globalModel =
              GlobalSearchModel.fromJson(result.data);
          archiveData = globalModel.archive ?? [];
          patientData = globalModel.patient ?? [];
          patientTaskData = globalModel.patientTask ?? [];
          lynerConnectData = globalModel.lynerConnect ?? [];
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

  void callDeletePatientApi(int? userId) async {
    isLoading = true;
    Get.back();
    ResponseItem result = await PatientsRepo.deleteLynerConnect(
      userId: userId!,
    );
    try {
      if (result.status) {
        showAppSnackBar(result.msg);
        globalSearch();
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
    }
    update();
  }
}
