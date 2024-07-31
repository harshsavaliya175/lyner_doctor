import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/add_patient_repo/add_patient_repo.dart';
import 'package:lynerdoctor/api/patients_repo/patients_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/model/clinic_billing_model.dart';
import 'package:lynerdoctor/model/clinic_location_model.dart';
import 'package:lynerdoctor/model/doctor_model.dart';
import 'package:lynerdoctor/model/patient_model.dart';
import 'package:lynerdoctor/model/productListModel.dart';
import 'package:lynerdoctor/model/selection_item.dart';

class AddPatientController extends GetxController {
  var currentStep = 0.obs;
  late PageController pageController;

  List<ProductListData> products = [];
  var selectedProduct = Rxn<ProductListData>();
  bool isSelectedProductPlan = false;
  bool firstNameError = false;
  bool emailError = false;
  bool lastNameError = false;
  GlobalKey<FormState> patientInformationFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController doctorController = TextEditingController();
  TextEditingController billingAddressController = TextEditingController();
  TextEditingController deliveryAddressController = TextEditingController();
  File? profileImageFile;
  File? faceImageFile;
  File? smileImageFile;
  File? intraMaxImageFile;
  File? intraMandImageFile;
  File? intraRightImageFile;
  File? intraLeftImageFile;
  File? intraFaceImageFile;
  File? radiosFirstImageFile;
  File? radiosSecondImageFile;

  // bool isArcadeTraiter = false;
  var isArcadeTraiter = 0;
  var isClassesDental = 0;
  var isObjectTraitement = 0;
  bool isUploadStl = false;
  bool isLoading = false;
  DateTime? pickedDate;
  DateTime? dateText;
  String? dateTextField;
  List<DoctorData?> doctorDataList = [];
  DoctorData? selectedDoctorData;

  ClinicLocation? selectedClinicDeliveryData;
  ClinicBillingData? selectedClinicBillingData;

  List<ClinicLocation?> clinicDeliveryLocationList = [];
  List<ClinicBillingData?> clinicBillingList = [];
  bool showDoctorDropDown = false;
  bool showBillingDropDown = false;
  bool showDeliveryDropDown = false;
  PatientData? patientData;
  var patientTechniquesItems = <SelectionItem>[
    SelectionItem(title: LocaleKeys.recommandeLyner.translateText),
    SelectionItem(title: LocaleKeys.iprStripping.translateText),
    SelectionItem(title: LocaleKeys.taquets.translateText),
    SelectionItem(title: LocaleKeys.pasDeTaquetSurLesDents.translateText, requiresNote: true),
    SelectionItem(title: LocaleKeys.elastiques.translateText),
    SelectionItem(title: LocaleKeys.boutonsaColler.translateText),
    SelectionItem(title: LocaleKeys.extractionsRequisesDents.translateText, requiresNote: true),
  ];

  bool validateUploadPhotoFiles() {
    if (profileImageFile == null) return false;
    if (faceImageFile == null) return false;
    if (smileImageFile == null) return false;
    if (intraMaxImageFile == null) return false;
    if (intraMandImageFile == null) return false;
    if (intraRightImageFile == null) return false;
    if (intraLeftImageFile == null) return false;
    if (intraFaceImageFile == null) return false;
    if (radiosFirstImageFile == null) return false;
    if (radiosSecondImageFile == null) return false;

    return true;
  }

  bool validateArcadeFields() {
    if (isArcadeTraiter == 0) return false;
    if (isClassesDental == 0) return false;
    if (isObjectTraitement == 0) return false;

    return true;
  }

  var dentalHistoryItems = <SelectionItem>[
    SelectionItem(title: LocaleKeys.rienDeParticulier.translateText),
    SelectionItem(title: LocaleKeys.dentsMobiles.translateText, requiresNote: true),
    SelectionItem(title: LocaleKeys.traumat.translateText, requiresNote: true),
    SelectionItem(title: LocaleKeys.implant.translateText, requiresNote: true),
    SelectionItem(title: LocaleKeys.bridge.translateText, requiresNote: true),
    SelectionItem(
        title: LocaleKeys.problemAtm.translateText,
        dentalHistory: true,
        dentalHistorySelected: true),
    SelectionItem(title: LocaleKeys.apneduSomeil.translateText),
    SelectionItem(title:LocaleKeys.autresInformationsPertinentes.translateText, requiresNote: true),
  ];
  var middleMaxillaryItems = <SelectionItem>[
    SelectionItem(title: LocaleKeys.centre.translateText),
    SelectionItem(title: LocaleKeys.decaleVersLaDroite.translateText),
    SelectionItem(title: LocaleKeys.decaleVersLaGauche.translateText),
  ];
  var incisorCoveringItems = <SelectionItem>[
    SelectionItem(title: LocaleKeys.recommandeLyner.translateText),
    SelectionItem(
        title:
        LocaleKeys.augmentationDimension.translateText),
    SelectionItem(title: LocaleKeys.ingressionDesIncisivesMaxillaire.translateText),
    SelectionItem(title: LocaleKeys.ingressionDesIncisivesMandibulaires.translateText),
  ];
  var stepErrors = <int, bool>{};

  void checkStepErrors() {
    if (currentStep.value == 0) {
      if (patientInformationFormKey.currentState != null) {
        if (patientInformationFormKey.currentState!.validate()) {
          stepErrors[1] = false;
          stepErrors.remove(0);
        }
      }
      update();
    }
    if (currentStep.value == 1) {
      if (!isSelectedProductPlan) {
        stepErrors[1] = true;
      } else {
        stepErrors.remove(1);
      }
      update();
    }

    if (currentStep.value == 2) {
      if (!validateUploadPhotoFiles()) {
        stepErrors.remove(2);
      } else {
        stepErrors.remove(2);
      }
      update();
    }
    if (currentStep.value == 3) {
      if (!validateArcadeFields()) {
        stepErrors.remove(3);
      } else {
        stepErrors.remove(3);
      }
      update();
    }
  }

  void togglePatientSelection(int index) {
    patientTechniquesItems[index].isSelected =
        !patientTechniquesItems[index].isSelected;
    update();
  }

  void toggleIncisorCoveringSelection(int index) {
    incisorCoveringItems[index].isSelected =
        !incisorCoveringItems[index].isSelected;
    update();
  }

  void toggleMiddleMaxillaryItemsSelection(int index) {
    middleMaxillaryItems[index].isSelected =
        !middleMaxillaryItems[index].isSelected;
    update();
  }

  // void updatePatientNote(int index, String note) {
  //   patientTechniquesItems[index].note = note;
  //   update();
  // }
  void toggleDentalSelection(int index) {
    dentalHistoryItems[index].isSelected =
        !dentalHistoryItems[index].isSelected;
    update();
  }

  void toggleProblemSelection(int index) {
    dentalHistoryItems[index].dentalHistorySelected =
        !dentalHistoryItems[index].dentalHistorySelected;
    update();
  }

  void changeArcadeValue(int value) {
    if (isArcadeTraiter == value) {
      isArcadeTraiter = 0;
    } else {
      isArcadeTraiter = value;
    }
    update();
  }

  void changeClassesDentalValue(int value) {
    if (isClassesDental == value) {
      isClassesDental = 0;
    } else {
      isClassesDental = value;
    }

    update();
  }

  void changeObjectValue(int value) {
    isObjectTraitement = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentStep.value);
    fetchProducts();
    getDoctorList();
    getClinicLocationList();
    getClinicBillingList();
  }

  void selectProduct(ProductListData product) {
    selectedProduct.value = product;
    isSelectedProductPlan = selectedProduct.value == product;
    stepErrors[0] = false;
    update();
  }

  void fetchProducts() async {
    products.clear();
    isLoading = true;
    try {
      ResponseItem result = await AddPatientRepo.getProductsList();
      if (result.status) {
        if (result.data != null) {
          ProductListModel productList =
              ProductListModel.fromJson(result.toJson());
          products.addAll(productList.data);
          print(products);
        }
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      update();
    }
  }

  getDoctorList() async {
    doctorDataList.clear();
    isLoading = true;
    ResponseItem result = await PatientsRepo.getDoctorListByClinicId(
        clinicId: preferences.getInt(SharedPreference.CLINIC_ID) ?? 0);
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          result.data.forEach(
            (dynamic e) {
              DoctorData doctorData = DoctorData.fromJson(e);
              doctorDataList.add(doctorData);
            },
          );
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

  getClinicLocationList() async {
    clinicDeliveryLocationList.clear();
    isLoading = true;
    ResponseItem result = await PatientsRepo.getClinicLocationList(
        clinicId: preferences.getInt(SharedPreference.CLINIC_ID) ?? 0);
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          result.data.forEach(
            (dynamic e) {
              ClinicLocation clinicLocation = ClinicLocation.fromJson(e);
              clinicDeliveryLocationList.add(clinicLocation);
            },
          );
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

  getClinicBillingList() async {
    clinicBillingList.clear();
    isLoading = true;
    ResponseItem result = await PatientsRepo.getClinicBillingList(
        clinicId: preferences.getInt(SharedPreference.CLINIC_ID) ?? 0);
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          result.data.forEach(
            (dynamic e) {
              ClinicBillingData clinicBillingData =
                  ClinicBillingData.fromJson(e);
              clinicBillingList.add(clinicBillingData);
              print(clinicBillingList);
            },
          );
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

  Future<void> addNewPatient() async {
    isLoading = true;
    ResponseItem result = await AddPatientRepo.addNewPatientStep1Step2(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        clinicBillingId: selectedClinicBillingData?.clinicBillingId.toString(),
        clinicLocationId: selectedClinicDeliveryData?.clinicId.toString(),
        dateOfBirth: dateOfBirthController.text,
        doctorId: selectedDoctorData?.doctorId.toString(),
        email: emailController.text,
        toothCaseId: selectedProduct.value?.toothCaseId ?? 0);
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          PatientModel patientModel = PatientModel.fromJson(result.toJson());
          patientData = patientModel.data;
          print(patientData);
          showAppSnackBar(LocaleKeys.addPatientRecordSuccessfully.translateText);
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

  Future<void> uploadPatientSingleImage({File? file, String? paramName}) async {
    isLoading = false;
    ResponseItem result = await AddPatientRepo.uploadPatientSingleImage(
        file: file, paramName: paramName,patientId: patientData?.patientId.toString());
    isLoading = false;
    try {
      if (result.status) {
          showAppSnackBar(result.msg);
          isLoading = false;
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
    }
    update();
  }

  Future<void> goToStep(int step) async {
    currentStep.value = step;
    pageController.jumpToPage(step);
    update();
  }
}
