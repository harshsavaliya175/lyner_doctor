import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/case_repo/case_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/model/case_response_model.dart';

class CaseSelectionController extends GetxController {
  bool isLoading = false;
  int caseSelectionFilterValue = 1;
  String caseStatus = 'Analysis Requested';
  List<CaseSelectionData?> caseList = [];

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    getCaseSelectionListByStatus();
    FocusScope.of(Get.context!).unfocus();
    super.onInit();
  }

  void changeData({
    int? caseStatusValue,
    String? caseStatusString,
  }) {
    caseSelectionFilterValue = caseStatusValue ?? caseSelectionFilterValue;
    caseStatus = caseStatusString ?? caseStatus;
    update();
  }

  getCaseSelectionListByStatus({bool isFromSearch = false}) async {
    if (!isFromSearch) {
      isLoading = true;
    }
    ResponseItem result = await AddCaseRepo.getCaseSelectionListByStatus(
      caseStatus: caseStatus,
      searchText: searchController.text.trim(),
    );
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          caseList.clear();
          CaseSelectionResponseModel caseSelectionResponseModel =
              CaseSelectionResponseModel.fromJson(result.toJson());
          caseList.addAll(caseSelectionResponseModel.data!);
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
