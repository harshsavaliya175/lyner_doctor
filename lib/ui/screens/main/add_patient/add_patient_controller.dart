import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPatientController extends GetxController{
  var currentStep = 0.obs;
  late PageController pageController;
  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentStep.value);
  }

  void goToStep(int step) {
    currentStep.value = step;
    pageController.jumpToPage(step);
    update();
  }
}