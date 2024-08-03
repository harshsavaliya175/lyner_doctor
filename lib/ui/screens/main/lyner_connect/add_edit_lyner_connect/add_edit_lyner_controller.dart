import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditLynerController extends GetxController{
  GlobalKey<FormState> patientInformationFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController doctorController = TextEditingController();
  TextEditingController billingAddressController = TextEditingController();
  TextEditingController deliveryAddressController = TextEditingController();
  TextEditingController mobileNumController = TextEditingController();
  TextEditingController currentAlignerController = TextEditingController();
  bool firstNameError = false;
  bool emailError = false;
  bool lastNameError = false;
  bool mobileNumError = false;
  bool isLoading = false;
  DateTime? pickedDate;
  DateTime? dateText;
  String? dateTextField;
  bool isFromNewPatient = false;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isFromNewPatient = Get.arguments;
    update();
  }
}