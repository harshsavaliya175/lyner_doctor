import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lynerdoctor/api/patients_repo/patients_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/model/lyner_patient_list_model.dart';
import 'package:lynerdoctor/ui/screens/main/lyner_connect/lyner_connect_add_patient/add_new_patient_controller.dart';
import 'package:lynerdoctor/ui/screens/main/lyner_connect/lyner_connect_home/lyner_connect_controller.dart';

class AddEditLynerController extends GetxController {
  GlobalKey<FormState> patientInformationFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController treatmentStartDateController = TextEditingController();
  TextEditingController doctorController = TextEditingController();
  TextEditingController alignerDaysController = TextEditingController();
  TextEditingController totalAlignerController = TextEditingController();
  TextEditingController mobileNumController = TextEditingController();
  TextEditingController currentAlignerController = TextEditingController();
  bool isLoading = false;
  DateTime? pickedDate;
  String? dateTextField;
  bool isFromNewPatient = false;

  LynerPatientListData? lynerPatientListData;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isFromNewPatient = Get.arguments[0];
    lynerPatientListData = Get.arguments[1];
    firstNameController.text=lynerPatientListData?.firstName??'';
    lastNameController.text=lynerPatientListData?.lastName??'';
    emailController.text=lynerPatientListData?.email??'';
    update();
  }
  void addLynerConnectDetails() async {
    isLoading = true;
    if(pickedDate != null){
      dateTextField =
          DateFormat('yyyy-MM-dd').format(pickedDate!);
    }else{
      dateTextField = "";
    }
    ResponseItem result = await PatientsRepo.addLynerConnectDetails(
      patientId: lynerPatientListData?.patientId.toString()??'',
      email: emailController.text,
      phoneNo: mobileNumController.text,
      currentAlignerStage: currentAlignerController.text,
      alignerDay: alignerDaysController.text,
      alignerStage: totalAlignerController.text,
      treatmentStartDate: dateTextField,
    );

    try {
      if (result.status) {
        if (result.data != null) {
          Get.back();
          showAppSnackBar(result.msg);
          Get.find<AddNewPatientController>().getLynerConnectPatientList();
          Get.find<LynerConnectController>().getLynerConnectList();
          isLoading = false;
        }else{
          showAppSnackBar(result.msg);
        }
      } else {
        showAppSnackBar(result.msg);
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
    }
    update();
  }
}
