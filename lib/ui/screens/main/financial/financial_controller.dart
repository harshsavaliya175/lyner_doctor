import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/financial_repo/financial_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/model/financial_model.dart';

class FinancialController extends GetxController {
  bool isLoading = false;
  FinancialModel? financialModel;
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    getFinancialList();
    super.onInit();
  }

  void getFinancialList() async {
    isLoading = true;
    ResponseItem result = await FinancialRepo.getFinancialList();
    try {
      if (result.status) {
        if (result.data != null) {
          financialModel = FinancialModel.fromJson(result.data);
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
