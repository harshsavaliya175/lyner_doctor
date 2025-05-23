import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lynerdoctor/api/add_patient_repo/add_patient_repo.dart';
import 'package:lynerdoctor/api/patients_repo/patients_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/model/clinic_billing_model.dart';
import 'package:lynerdoctor/model/clinic_location_model.dart';
import 'package:lynerdoctor/model/doctor_model.dart';
import 'package:lynerdoctor/model/patient_model.dart';
import 'package:lynerdoctor/model/prescription_model.dart';
import 'package:lynerdoctor/model/productListModel.dart';
import 'package:lynerdoctor/model/refinement_model.dart';
import 'package:lynerdoctor/model/selection_item.dart';
import 'package:lynerdoctor/ui/screens/main/patients/patients_controller.dart';
import 'package:uuid/uuid.dart';

class AddPatientController extends GetxController {
  int currentStep = 0;
  late PageController pageController;
  bool isClick = false;
  List<File> smileImg = [];
  List<ProductListData> products = [];
  ProductListData? selectedProduct;
  bool isSelectedProductPlan = false;
  bool firstNameError = false;
  bool emailError = false;
  bool lastNameError = false;
  GlobalKey<FormState> patientInformationFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController doctorController = TextEditingController();
  TextEditingController billingAddressController = TextEditingController();
  TextEditingController deliveryAddressController = TextEditingController();
  TextEditingController objectifsTraitementDeliveryAddressCtrl =
      TextEditingController();
  TextEditingController techniquesPatientsNoteCtrl = TextEditingController();
  TextEditingController classesDentalNoteCtrl = TextEditingController();
  TextEditingController maxillaireNoteCtrl = TextEditingController();
  TextEditingController autresRecommandationNoteCtrl = TextEditingController();
  TextEditingController incisorCoveringNoteCtrl = TextEditingController();
  TextEditingController dentalHistoryNoteCtrl = TextEditingController();
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
  File? upperJawImageFile;
  TextEditingController upperJawImageFileTextCtrl = TextEditingController();
  TextEditingController lowerJawImageFileTextCtrl = TextEditingController();
  File? lowerJawImageFile;
  File? dicomFile;

  // bool isArcadeTraiter = false;
  var isArcadeTraiter = 0;
  String arcadeTratierText = '';
  String classesDentalText = '';
  var isClassesDental = 0;
  var isObjectTraitement = 0;
  String isObjectTraitementText = '';
  bool isUploadStl = false;
  bool isLoading = false;
  bool isDcomFileLoading = false;
  double uploadProgress = 0.0;
  String? uploadId;
  DateTime? pickedDate;
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
  RefinementData? refinementData;
  RefinementData? retentionData;
  TextEditingController patientTechniquesDetailsNote = TextEditingController();

  var patientId, refinementNumber;

  String dicomFileName = LocaleKeys.uploadDICOMFile.translateText;

  bool isRefinement = false;
  bool isRetention = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    pageController = PageController(initialPage: currentStep);
    if (Get.arguments != null) {
      isRefinement = Get.arguments[isRefinementString];
      isRetention = Get.arguments[isRetentionString] ?? false;
      patientId = Get.arguments[patientIdString];
      refinementNumber = Get.arguments[refinementIdString];
    }
    print("isRefinement : $isRefinement");
    print("isRetention : $isRetention");
    print("patientId : $patientId");
    print("refinement_number : $refinementNumber");
    //patientId = Get.arguments;
    if (patientId != null) {
      isLoading = true;
      if (isRefinement) {
        await getPatientRefinementImage();
        if (refinementData != null) {
          dicomFileName = getFileName(refinementData?.dicomFileName, 20);
        }
      } else if (isRetention) {
        await getPatientRetentionImage();
        if (retentionData != null) {
          dicomFileName = getFileName(retentionData?.dicomFileName, 20);
        }
      } else {
        await getPatientInformationDetails();
        if (patientData?.patientPhoto?.dcomFileName != null &&
            patientData!.patientPhoto!.dcomFileName!.isNotEmpty) {
          dicomFileName =
              getFileName(patientData!.patientPhoto!.dcomFileName, 20);
        }
        if (patientData?.draftViewPage == "patient_info_page") {
          isLoading = true;
          await goToStep(1);
        } else if (patientData?.draftViewPage == "upload_photo_page") {
          isLoading = true;
          await goToStep(2);
        } else if (patientData?.draftViewPage == "patient_prescription_page") {
          isLoading = true;
          await goToStep(3);
        }
        await getPatientPrescriptionDetails();
      }
    }
    if (!isRefinement && !isRetention) {
      await fetchProducts();
      getDoctorList();
      getClinicLocationList();
      getClinicBillingList();
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  String getFileName(String? filePath, int length) {
    if (filePath == null || filePath.isEmpty)
      return LocaleKeys.uploadDICOMFile.translateText;
    return filePath.length > length
        ? filePath.substring(filePath.length - length)
        : filePath;
  }

  List<SelectionItem> patientTechniquesItems = <SelectionItem>[
    SelectionItem(title: LocaleKeys.recommandeLyner.translateText),
    SelectionItem(title: LocaleKeys.iprStripping.translateText),
    SelectionItem(title: LocaleKeys.taquets.translateText),
    SelectionItem(
        title: LocaleKeys.pasDeTaquetSurLesDents.translateText,
        requiresNote: true),
    SelectionItem(title: LocaleKeys.elastiques.translateText),
    SelectionItem(title: LocaleKeys.boutonsaColler.translateText),
    SelectionItem(
        title: LocaleKeys.extractionsRequisesDents.translateText,
        requiresNote: true),
  ];

  bool validateUploadPhotoFiles() {
    if (profileImageFile == null &&
        (patientData?.patientPhoto?.gauche == null ||
            patientData?.patientPhoto?.gauche == '')) return false;
    if (faceImageFile == null &&
        (patientData?.patientPhoto?.face == null ||
            patientData?.patientPhoto?.face == '')) return false;
    if (smileImageFile == null &&
        (patientData?.patientPhoto?.sourire == null ||
            patientData?.patientPhoto?.sourire == '')) return false;
    if (intraMaxImageFile == null &&
        (patientData?.patientPhoto?.interMax == null ||
            patientData?.patientPhoto?.interMax == '')) return false;
    if (intraMandImageFile == null &&
        (patientData?.patientPhoto?.interMandi == null ||
            patientData?.patientPhoto?.interMandi == '')) return false;
    if (intraRightImageFile == null &&
        (patientData?.patientPhoto?.interDroite == null ||
            patientData?.patientPhoto?.interDroite == '')) return false;
    if (intraLeftImageFile == null &&
        (patientData?.patientPhoto?.interGauche == null ||
            patientData?.patientPhoto?.interGauche == '')) return false;
    if (intraFaceImageFile == null &&
        (patientData?.patientPhoto?.interFace == null ||
            patientData?.patientPhoto?.interFace == '')) return false;
    // if (radiosFirstImageFile == null &&
    //     (patientData?.patientPhoto?.paramiqueRadio == null ||
    //         patientData?.patientPhoto?.paramiqueRadio == '')) return false;
    // if (radiosSecondImageFile == null &&
    //     (patientData?.patientPhoto?.cephalRadio == null ||
    //         patientData?.patientPhoto?.cephalRadio == '')) return false;
    if (isUploadStl) {
      if (upperJawImageFile == null &&
          (patientData?.patientPhoto?.upperJawStlFile == null ||
              patientData?.patientPhoto?.upperJawStlFile == '')) return false;
      if (lowerJawImageFile == null &&
          (patientData?.patientPhoto?.lowerJawStlFile == null ||
              patientData?.patientPhoto?.lowerJawStlFile == '')) return false;
    }
    return true;
  }

  bool validateUploadPhotoRefinementFiles() {
    if (profileImageFile == null &&
        (refinementData?.profile == null || refinementData?.profile == '')) {
      showAppSnackBar(LocaleKeys.pleaseSelectAllRequiredPhotos.translateText);
      return false;
    }
    if (faceImageFile == null &&
        (refinementData?.face == null || refinementData?.face == '')) {
      showAppSnackBar(LocaleKeys.pleaseSelectAllRequiredPhotos.translateText);
      return false;
    }
    if (smileImageFile == null &&
        (refinementData?.smile == null || refinementData?.smile == '')) {
      showAppSnackBar(LocaleKeys.pleaseSelectAllRequiredPhotos.translateText);
      return false;
    }
    if (intraMaxImageFile == null &&
        (refinementData?.intraMax == null || refinementData?.intraMax == '')) {
      showAppSnackBar(LocaleKeys.pleaseSelectAllRequiredPhotos.translateText);
      return false;
    }
    if (intraMandImageFile == null &&
        (refinementData?.intraMand == null ||
            refinementData?.intraMand == '')) {
      showAppSnackBar(LocaleKeys.pleaseSelectAllRequiredPhotos.translateText);
      return false;
    }
    if (intraRightImageFile == null &&
        (refinementData?.interRight == null ||
            refinementData?.interRight == '')) {
      showAppSnackBar(LocaleKeys.pleaseSelectAllRequiredPhotos.translateText);
      return false;
    }
    if (intraLeftImageFile == null &&
        (refinementData?.interLeft == null ||
            refinementData?.interLeft == '')) {
      showAppSnackBar(LocaleKeys.pleaseSelectAllRequiredPhotos.translateText);
      return false;
    }
    if (intraFaceImageFile == null &&
        (refinementData?.face == null || refinementData?.face == '')) {
      showAppSnackBar(LocaleKeys.pleaseSelectAllRequiredPhotos.translateText);
      return false;
    }
    // if (radiosFirstImageFile == null &&
    //     (patientData?.patientPhoto?.paramiqueRadio == null ||
    //         patientData?.patientPhoto?.paramiqueRadio == '')) return false;
    // if (radiosSecondImageFile == null &&
    //     (patientData?.patientPhoto?.cephalRadio == null ||
    //         patientData?.patientPhoto?.cephalRadio == '')) return false;
    if (isUploadStl) {
      if (upperJawImageFile == null &&
          (refinementData?.upperJawStlFile == null ||
              refinementData?.upperJawStlFile == '')) {
        showAppSnackBar(LocaleKeys.pleaseSelectAllRequiredPhotos.translateText);
        return false;
      }
      if (lowerJawImageFile == null &&
          (refinementData?.lowerJawStlFile == null ||
              refinementData?.lowerJawStlFile == '')) {
        showAppSnackBar(LocaleKeys.pleaseSelectAllRequiredPhotos.translateText);
        return false;
      }
    }
    // if (dicomFile == null &&
    //     (refinementData?.dicomFileName == null ||
    //         refinementData?.dicomFileName == '')) {
    //   showAppSnackBar(LocaleKeys.pleaseSelectAllRequiredPhotos.translateText);
    //   return false;
    // }
    if (isArcadeTraiter == 0 &&
        (refinementData?.arcadeOption == null ||
            refinementData?.arcadeOption == '')) {
      showAppSnackBar(LocaleKeys.pleaseSelectArcadeTraiter.translateText);
      return false;
    }
    if (commentController.text == "" || commentController.text.isEmpty) {
      showAppSnackBar(LocaleKeys.pleaseEnterComment.translateText);
      return false;
    }
    return true;
  }

  bool validateDentalHistoryFields() {
    for (var item in dentalHistoryItems) {
      if (item.isSelected) {
        return true; // At least one item is selected
      }
    }
    return false; // None of the items are selected
  }

  bool validateTechniquesAcceptPatientFields() {
    for (SelectionItem item in patientTechniquesItems) {
      if (item.isSelected) {
        return true;
      }
    }
    return false;
  }

  bool validateMiddleMaxillaryFields() {
    for (SelectionItem item in middleMaxillaryItems) {
      if (item.isSelected) {
        return true;
      }
    }
    return false;
  }

  bool validateIncisorCoveringFields() {
    for (SelectionItem item in incisorCoveringItems) {
      if (item.isSelected) {
        return true;
      }
    }
    return false;
  }

  bool validateArcadeFields() {
    if (isArcadeTraiter == 0) return false;
    if (isClassesDental == 0) return false;
    if (isObjectTraitement == 0) return false;
    if (!validateDentalHistoryFields()) return false;
    if (!validateTechniquesAcceptPatientFields()) return false;
    if (!validateMiddleMaxillaryFields()) return false;
    if (!validateIncisorCoveringFields()) return false;
    return true;
  }

  List<SelectionItem> dentalHistoryItems = <SelectionItem>[
    SelectionItem(title: LocaleKeys.rienDeParticulier.translateText),
    SelectionItem(
        title: LocaleKeys.dentsMobiles.translateText, requiresNote: true),
    SelectionItem(title: LocaleKeys.traumat.translateText, requiresNote: true),
    SelectionItem(title: LocaleKeys.implant.translateText, requiresNote: true),
    SelectionItem(title: LocaleKeys.bridge.translateText, requiresNote: true),
    SelectionItem(
        title: LocaleKeys.problemAtm.translateText,
        dentalHistory: true,
        dentalHistorySelected: true),
    SelectionItem(title: LocaleKeys.apneduSomeil.translateText),
    SelectionItem(
        title: LocaleKeys.autresInformationsPertinentes.translateText,
        requiresNote: true),
  ];

  List<SelectionItem> middleMaxillaryItems = <SelectionItem>[
    SelectionItem(title: LocaleKeys.centre.translateText),
    SelectionItem(title: LocaleKeys.decaleVersLaDroite.translateText),
    SelectionItem(title: LocaleKeys.decaleVersLaGauche.translateText),
  ];

  List<SelectionItem> incisorCoveringItems = <SelectionItem>[
    SelectionItem(title: LocaleKeys.recommandeLyner.translateText),
    SelectionItem(title: LocaleKeys.augmentationDimension.translateText),
    SelectionItem(
        title: LocaleKeys.ingressionDesIncisivesMaxillaire.translateText),
    SelectionItem(
        title: LocaleKeys.ingressionDesIncisivesMandibulaires.translateText),
  ];

  Map<int, bool> stepErrors = <int, bool>{};

  void checkStepErrors() {
    if (currentStep == 0) {
      if (patientInformationFormKey.currentState != null) {
        if (patientInformationFormKey.currentState!.validate()) {
          stepErrors[1] = false;
          stepErrors.remove(0);
        }
      }
      update();
    }
    if (currentStep == 1) {
      if (!isSelectedProductPlan) {
        stepErrors[1] = true;
      } else {
        stepErrors.remove(1);
      }
      update();
    }

    if (currentStep == 2) {
      if (!validateUploadPhotoFiles()) {
        stepErrors.remove(2);
      } else {
        stepErrors.remove(2);
      }
      update();
    }
    if (currentStep == 3) {
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

  void changePatientNoteText(int index, String value) {
    patientTechniquesItems[index].note = value;
    update();
  }

  void changeDentalHistoryNoteText(int index, String value) {
    dentalHistoryItems[index].note = value;
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

  void toggleDentalSelection(int index) {
    dentalHistoryItems[index].isSelected =
        !dentalHistoryItems[index].isSelected;
    update();
  }

  void toggleProblemSelection(int index) {
    dentalHistoryItems[index].dentalHistorySelected =
        !dentalHistoryItems[index].dentalHistorySelected;
    if (dentalHistoryItems[index].dentalHistorySelected) {
      dentalHistoryItems[index].note = LocaleKeys.yes.translateText;
    } else {
      dentalHistoryItems[index].note = LocaleKeys.no.translateText;
    }
    update();
  }

  void changeArcadeValue(int value) {
    if (isArcadeTraiter == value) {
      isArcadeTraiter = 0;
      arcadeTratierText = '';
    } else {
      isArcadeTraiter = value;
      if (isArcadeTraiter == 1) {
        arcadeTratierText = LocaleKeys.lesDeux.translateText;
      } else if (isArcadeTraiter == 2) {
        arcadeTratierText = LocaleKeys.maxillaire.translateText;
      } else if (isArcadeTraiter == 3) {
        arcadeTratierText = LocaleKeys.mandibulaire.translateText;
      }
    }
    print(arcadeTratierText);
    update();
  }

  void changeClassesDentalValue(int value) {
    if (isClassesDental == value) {
      isClassesDental = 0;
      classesDentalText = '';
    } else {
      isClassesDental = value;
      if (isClassesDental == 1) {
        classesDentalText = LocaleKeys.maintenir.translateText;
      } else if (isClassesDental == 2) {
        classesDentalText = LocaleKeys.ameliorerClasses.translateText;
      }
    }
    print(classesDentalText);
    update();
  }

  void changeObjectValue(int value) {
    if (isObjectTraitement == value) {
      isObjectTraitement = 0;
    } else {
      isObjectTraitement = value;
      if (isObjectTraitement == 1) {
        isObjectTraitementText = LocaleKeys.alignementEsthetique.translateText;
      } else if (isObjectTraitement == 2) {
        isObjectTraitementText =
            LocaleKeys.alignementEsthetiqueCorrection.translateText;
      }
    }
    print(isObjectTraitementText);
    update();
  }

  void selectProduct(ProductListData product) {
    selectedProduct = product;
    isSelectedProductPlan = selectedProduct == product;
    stepErrors[0] = false;
    update();
  }

  Future<void> fetchProducts() async {
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
    if (pickedDate != null) {
      dateTextField = DateFormat(
        'yyyy-MM-dd',
        (preferences.getString(SharedPreference.LANGUAGE_CODE) ?? '').isNotEmpty
            ? preferences.getString(SharedPreference.LANGUAGE_CODE)
            : 'fr',
      ).format(pickedDate!);
    } else {
      dateTextField = "";
    }
    ResponseItem result = await AddPatientRepo.addNewPatientStep1Step2(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        clinicBillingId: selectedClinicBillingData?.clinicBillingId.toString(),
        clinicLocationId:
            selectedClinicDeliveryData?.clinicLocationId.toString(),
        dateOfBirth: dateTextField,
        doctorId: selectedDoctorData?.doctorId.toString(),
        email: emailController.text,
        toothCaseId: selectedProduct?.toothCaseId ?? 0);
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          PatientModel patientModel = PatientModel.fromJson(result.toJson());
          patientData = patientModel.data;
          print(patientData);
          showAppSnackBar(
              LocaleKeys.addPatientRecordSuccessfully.translateText);
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

  Future<void> addUpdatePatientDetails(
      {bool isFromFinishStep = false, String? draftViewPage}) async {
    if (!isFromFinishStep) {
      if (dateOfBirthController.text.isEmpty ||
          (doctorController.text.isEmpty &&
              preferences.getString(SharedPreference.LOGIN_TYPE) ==
                  SharedPreference.LOGIN_TYPE_CLINIC) ||
          deliveryAddressController.text.isEmpty ||
          billingAddressController.text.isEmpty) {
        goToStep(1);
      } else if (!validateUploadPhotoFiles()) {
        showAppSnackBar(
            LocaleKeys.pleaseUploadRequiredPhotograph.translateText);
        goToStep(2);
      } else if (!validateArcadeFields()) {
        showAppSnackBar(LocaleKeys.pleaseSelectAllRequiredFields.translateText);
      } else {
        callAddUpdatePatientDetails(isFromFinishStep: false, draftViewPage: '');
      }
    } else {
      callAddUpdatePatientDetails(
          isFromFinishStep: isFromFinishStep, draftViewPage: draftViewPage);
    }
  }

  Future<void> uploadPatientSingleImage({File? file, String? paramName}) async {
    isLoading = false;
    ResponseItem result = await AddPatientRepo.uploadPatientSingleImage(
      file: file,
      paramName: paramName,
      patientId: patientData?.patientId.toString(),
    );
    isLoading = false;
    try {
      if (result.status) {
        // showAppSnackBar(result.msg);
        isLoading = false;
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
    }
    update();
  }

  Future<void> editPatientRefinementDetails({
    File? file,
    String? paramName,
    bool? isBack,
    int isDraft = 0,
  }) async {
    isLoading = false;
    final Map<String, dynamic> params = {
      "patient_id": patientId,
      "is_3shape": !isUploadStl ? 1 : 0,
      "arcade_option": arcadeTratierText,
      "arcade_comment": commentController.text,
      "refinement_number": refinementNumber,
      "is_draft": isDraft,
      "refine_guideline": commentController.text,
    };

    ResponseItem result = await AddPatientRepo.editPatientRefinementDetails(
      file: file,
      paramName: paramName,
      patientId: patientId.toString(),
      params: params,
    );
    isLoading = false;
    try {
      if (result.status) {
        // showAppSnackBar(result.msg);
        isLoading = false;
        if (isBack != null && isBack) {
          Get.back();
        }
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
    }
    update();
  }

  Future<void> editPatientRetentionDetails({
    File? file,
    String? paramName,
    bool? isBack,
    int isDraft = 0,
  }) async {
    isLoading = false;
    final Map<String, dynamic> params = {
      "patient_id": patientId,
      "is_3shape": !isUploadStl ? 1 : 0,
      "arcade_option": arcadeTratierText,
      "arcade_comment": commentController.text,
      "is_draft": isDraft,
      "containment_guideline": commentController.text,
    };

    ResponseItem result = await AddPatientRepo.editPatientContainmentDetails(
      file: file,
      paramName: paramName,
      patientId: patientId.toString(),
      params: params,
    );
    isLoading = false;
    try {
      if (result.status) {
        // showAppSnackBar(result.msg);
        isLoading = false;
        if (isBack != null && isBack) {
          Get.back();
        }
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
    }
    update();
  }

  Future<void> uploadRefinementMultipleImage({
    required List<File> files,
  }) async {
    isLoading = false;
    ResponseItem result = await AddPatientRepo.uploadRefinementMultipleImage(
      imageList: files,
      patientId: patientId.toString(),
      refinementNumber: refinementNumber,
    );
    isLoading = false;
    try {
      if (result.status) {
        // showAppSnackBar(result.msg);
        isLoading = false;
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
    }
    update();
  }

  Future<void> uploadRetentionMultipleImage({
    required List<File> files,
  }) async {
    isLoading = false;
    ResponseItem result = await AddPatientRepo.uploadRetentionMultipleImage(
      imageList: files,
      patientId: patientId.toString(),
    );
    isLoading = false;
    try {
      if (result.status) {
        // showAppSnackBar(result.msg);
        isLoading = false;
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
    }
    update();
  }

  Future<void> uploadPatientMultipleImage({
    required List<File> files,
  }) async {
    isLoading = false;
    ResponseItem result = await AddPatientRepo.uploadPatientMultipleImage(
        imageList: files, patientId: patientData?.patientId.toString());
    isLoading = false;
    try {
      if (result.status) {
        // showAppSnackBar(result.msg);
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
    currentStep = step;
    pageController.jumpToPage(step);
    update();
  }

  Future<void> callAddUpdatePatientDetails(
      {bool isFromFinishStep = false, String? draftViewPage}) async {
    isLoading = true;
    List<String> acceptedTechniquesList;
    acceptedTechniquesList = patientTechniquesItems
        .where((SelectionItem item) => item.isSelected)
        .map((SelectionItem item) =>
            item.note != null ? "${item.title}:${item.note}" : item.title)
        .toList();
    print(acceptedTechniquesList.join(', '));

    List<String> dentalHistoryList;
    dentalHistoryList = dentalHistoryItems
        .where((SelectionItem item) => item.isSelected)
        .map((SelectionItem item) =>
            item.note != null ? "${item.title}:${item.note}" : item.title)
        .toList();
    print(dentalHistoryList.join(', '));

    List<String> middleMaxillaryList;
    middleMaxillaryList = middleMaxillaryItems
        .where((SelectionItem item) => item.isSelected)
        .map((SelectionItem item) => item.title)
        .toList();
    print(middleMaxillaryList.join(', '));

    List<String> incisorCoveringList;
    incisorCoveringList = incisorCoveringItems
        .where((SelectionItem item) => item.isSelected)
        .map((SelectionItem item) => item.title)
        .toList();
    print(incisorCoveringList.join(', '));
    if (pickedDate != null) {
      dateTextField = DateFormat(
        'yyyy-MM-dd',
        (preferences.getString(SharedPreference.LANGUAGE_CODE) ?? '').isNotEmpty
            ? preferences.getString(SharedPreference.LANGUAGE_CODE)
            : 'fr',
      ).format(pickedDate!);
    } else if (patientData?.dateOfBirth != null) {
      dateTextField = DateFormat(
        'yyyy-MM-dd',
        (preferences.getString(SharedPreference.LANGUAGE_CODE) ?? '').isNotEmpty
            ? preferences.getString(SharedPreference.LANGUAGE_CODE)
            : 'fr',
      ).format(patientData!.dateOfBirth!);
      // dateOfBirthController.text = dateTextField!;
    } else {
      dateTextField = "";
    }
    ResponseItem result = await AddPatientRepo.addUpdatePatientDetails(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      clinicBillingId: selectedClinicBillingData?.clinicBillingId.toString(),
      clinicLocationId: selectedClinicDeliveryData?.clinicLocationId.toString(),
      dateOfBirth: dateTextField,
      doctorId: selectedDoctorData?.doctorId.toString(),
      email: emailController.text,
      toothCaseId: selectedProduct?.toothCaseId ?? 0,
      patientId: patientData?.patientId ?? 0,
      is3shape: !isUploadStl ? 1 : 0,
      arcadeToBeTreated: arcadeTratierText,
      treatmentObjectives: isObjectTraitementText,
      acceptedTechniques: acceptedTechniquesList.join(', '),
      dentalHistory: dentalHistoryList.join(', '),
      dentalClass: classesDentalText,
      maxillaryIncisalMiddle: middleMaxillaryList.join(', '),
      incisiveCovering: incisorCoveringList.join(', '),
      treatmentNotes: objectifsTraitementDeliveryAddressCtrl.text,
      dentalNote: classesDentalNoteCtrl.text,
      dentalHistoryNote: dentalHistoryNoteCtrl.text,
      acceptedTechniqueNote: techniquesPatientsNoteCtrl.text,
      incisiveCoveringNote: incisorCoveringNoteCtrl.text,
      maxillaryIncisalNote: maxillaireNoteCtrl.text,
      otherRecommendations: autresRecommandationNoteCtrl.text,
      draftViewPage: draftViewPage ?? '',
      saveAsDraft: isFromFinishStep ? 1 : 0,
    );
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          PatientModel patientModel = PatientModel.fromJson(result.toJson());
          patientData = patientModel.data;
          print(patientData);
          Get.back();
          if (!isFromFinishStep) {
            Get.find<PatientsController>().getClinicListBySearchOrFilter();
          }
          showAppSnackBar(
              LocaleKeys.addPatientRecordSuccessfully.translateText);
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

  Future<void> getPatientInformationDetails() async {
    ResponseItem result =
        await AddPatientRepo.getPatientInformationDetails(patientId);
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          PatientModel patientModel = PatientModel.fromJson(result.toJson());
          patientData = patientModel.data;
          selectedProduct = ProductListData(
            toothCaseId: patientData?.toothCase?.toothCaseId?.toInt() ?? 0,
            caseDesc: patientData?.toothCase?.caseDesc?.toString() ?? "",
            caseName: patientData?.toothCase?.caseName?.toString() ?? "",
            casePrice: patientData?.toothCase?.casePrice?.toString() ?? '',
            caseSteps: patientData?.toothCase?.caseSteps?.toString() ?? '',
          );
          if (selectedProduct != null) {
            isSelectedProductPlan = true;
          }
          firstNameController.text = patientData?.firstName ?? '';
          lastNameController.text = patientData?.lastName ?? '';
          emailController.text = patientData?.email ?? '';

          if (patientData?.dateOfBirth != null) {
            dateTextField = DateFormat(
              'dd/MM/yyyy',
              (preferences.getString(SharedPreference.LANGUAGE_CODE) ?? '')
                      .isNotEmpty
                  ? preferences.getString(SharedPreference.LANGUAGE_CODE)
                  : 'fr',
            ).format(patientData!.dateOfBirth!);
            dateOfBirthController.text = dateTextField!;
          } else {
            dateOfBirthController.text = '';
          }

          selectedClinicDeliveryData = ClinicLocation(
              clinicLocationId: patientData?.clinicLoc?.clinicLocationId ?? 0,
              clinicId: patientData?.clinicLoc?.clinicId ?? 0,
              contactName: patientData?.clinicLoc?.contactName ?? "",
              contactNumber: patientData?.clinicLoc?.contactNumber ?? "",
              address: patientData?.clinicLoc?.address ?? "",
              latitude: patientData?.clinicLoc?.latitude ?? "",
              longitude: patientData?.clinicLoc?.longitude ?? "");
          deliveryAddressController.text =
              selectedClinicDeliveryData?.address ?? '';
          selectedClinicBillingData = ClinicBillingData(
            clinicBillingId: patientData?.clinicBill?.clinicBillingId ?? 0,
            clinicId: patientData?.clinicBill?.clinicId ?? 0,
            billingName: patientData?.clinicBill?.billingName ?? "",
            billingAddress: patientData?.clinicBill?.billingAddress ?? "",
            billingLatitude: patientData?.clinicBill?.billingLatitude ?? "",
            billingLongitude: patientData?.clinicBill?.billingLongitude ?? "",
            billingMail: patientData?.clinicBill?.billingMail ?? "",
            billingVat: patientData?.clinicBill?.billingVat ?? "",
          );
          billingAddressController.text =
              selectedClinicBillingData?.billingAddress ?? '';
          selectedDoctorData = DoctorData(
            doctorId: patientData?.doctor?.doctorId ?? 0,
            doctorUniqueId: patientData?.doctor?.doctorUniqueId ?? "",
            firstName: patientData?.doctor?.firstName ?? "",
            lastName: patientData?.doctor?.lastName ?? "",
            email: patientData?.doctor?.email ?? "",
            mobileNumber: patientData?.doctor?.mobileNumber ?? "",
            doctorProfile: patientData?.doctor?.doctorProfile ?? "",
            country: patientData?.doctor?.country ?? "",
            language: patientData?.doctor?.language ?? "",
            clinicId: patientData?.doctor?.clinicId ?? 0,
          );
          doctorController.text = (selectedDoctorData?.firstName ?? '') +
              (selectedDoctorData?.lastName ?? '');
          upperJawImageFileTextCtrl.text =
              patientData?.patientPhoto?.upperJawStlFile ?? '';
          lowerJawImageFileTextCtrl.text =
              patientData?.patientPhoto?.lowerJawStlFile ?? '';
          isUploadStl = patientData?.patientPhoto?.is3Shape == 1 ? true : false;
          print(isUploadStl);
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

  Future<void> getPatientRefinementImage() async {
    ResponseItem result = await AddPatientRepo.getPatientRefinementImage(
        patientId, refinementNumber);
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          RefinementModel patientModel =
              RefinementModel.fromJson(result.toJson());
          refinementData = patientModel.data;

          /// ARCADE
          getArcadeTraiter(patientModel.data.arcadeOption);
          commentController.text = refinementData?.arcadeComment ?? '';
          upperJawImageFileTextCtrl.text =
              refinementData?.upperJawStlFile ?? '';
          lowerJawImageFileTextCtrl.text =
              refinementData?.lowerJawStlFile ?? '';
          isUploadStl = refinementData?.is3Shape == 1
              ? true
              : false; //!isUploadStl ? 1 : 0
          print(isUploadStl);
          isLoading = false;
          update();
        }
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
    }
    update();
  }

  Future<void> getPatientRetentionImage() async {
    ResponseItem result =
        await AddPatientRepo.getPatientRetentionImage(patientId);
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          RefinementModel patientModel =
              RefinementModel.fromJson(result.toJson());
          retentionData = patientModel.data;

          /// ARCADE
          getArcadeTraiter(patientModel.data.arcadeOption);
          commentController.text = retentionData?.arcadeComment ?? '';
          upperJawImageFileTextCtrl.text = retentionData?.upperJawStlFile ?? '';
          lowerJawImageFileTextCtrl.text = retentionData?.lowerJawStlFile ?? '';
          isUploadStl = retentionData?.is3Shape == 1
              ? true
              : false; //!isUploadStl ? 1 : 0
          print(isUploadStl);
          isLoading = false;
          update();
        }
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
    }
    update();
  }

  Future<void> getPatientPrescriptionDetails() async {
    ResponseItem result =
        await AddPatientRepo.getPatientPrescriptionDetails(patientId);
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          PrescriptionModel prescriptionModel =
              PrescriptionModel.fromJson(result.toJson());
          print(prescriptionModel.data);

          /// ARCADE
          getArcadeTraiter(prescriptionModel.data?.arcadeToBeTreated ?? '');

          /// OBJECT TREATMENT
          getObjectTreatement(prescriptionModel.data);

          /// PATIENT TECHNIQUES
          getUpdateMultipleSelectionItems(
              prescriptionModel.data?.acceptedTechniques ?? '',
              patientTechniquesItems,
              false);
          techniquesPatientsNoteCtrl.text =
              prescriptionModel.data?.acceptedTechniqueNote ?? '';

          /// DENTAL HISTORY
          getUpdateMultipleSelectionItems(
              prescriptionModel.data?.dentalHistory ?? '',
              dentalHistoryItems,
              true);
          dentalHistoryNoteCtrl.text =
              prescriptionModel.data?.dentalHistoryNote ?? '';

          /// DENTAL CLASS
          getDentalClass(prescriptionModel.data);
          classesDentalNoteCtrl.text = prescriptionModel.data?.dentalNote ?? '';

          /// MIDDLE MAXILLARY
          getUpdateMultipleSelectionItems(
              prescriptionModel.data?.maxillaryIncisalMiddle ?? '',
              middleMaxillaryItems,
              false);
          maxillaireNoteCtrl.text =
              prescriptionModel.data?.maxillaryIncisalNote ?? '';

          ///INCISOR COVERING
          getUpdateMultipleSelectionItems(
              prescriptionModel.data?.incisiveCovering ?? '',
              incisorCoveringItems,
              false);
          incisorCoveringNoteCtrl.text =
              prescriptionModel.data?.incisiveCoveringNote ?? '';

          ///Other Notes
          autresRecommandationNoteCtrl.text =
              prescriptionModel.data?.otherRecommendations ?? '';

          isLoading = false;
        }
        update();
      } else {
        isLoading = false;
        update();
      }
    } catch (e) {
      isLoading = false;
      update();
    }
  }

  void getArcadeTraiter(String data) {
    if (data == LocaleKeys.lesDeux.translateText) {
      isArcadeTraiter = 1;
      arcadeTratierText = LocaleKeys.lesDeux.translateText;
    } else if (data == LocaleKeys.maxillaire.translateText) {
      isArcadeTraiter = 2;
      arcadeTratierText = LocaleKeys.maxillaire.translateText;
    } else if (data == LocaleKeys.mandibulaire.translateText) {
      isArcadeTraiter = 3;
      arcadeTratierText = LocaleKeys.mandibulaire.translateText;
    } else {
      isArcadeTraiter = 0;
      arcadeTratierText = "";
    }
  }

  void getObjectTreatement(PrescriptionData? data) {
    if (data?.treatmentObjectives ==
        LocaleKeys.alignementEsthetique.translateText) {
      isObjectTraitement = 1;
      isObjectTraitementText = LocaleKeys.alignementEsthetique.translateText;
    } else if (data?.treatmentObjectives ==
        LocaleKeys.alignementEsthetiqueCorrection.translateText) {
      isObjectTraitement = 2;
      isObjectTraitementText =
          LocaleKeys.alignementEsthetiqueCorrection.translateText;
    } else {
      isObjectTraitement = 0;
      isObjectTraitementText = "";
    }
    objectifsTraitementDeliveryAddressCtrl.text = data?.treatmentNotes ?? '';
  }

  void getDentalClass(PrescriptionData? data) {
    if (data?.dentalClass == LocaleKeys.maintenir.translateText) {
      isClassesDental = 1;
      classesDentalText = LocaleKeys.maintenir.translateText;
    } else if (data?.dentalClass == LocaleKeys.ameliorerClasses.translateText) {
      isClassesDental = 2;
      classesDentalText = LocaleKeys.ameliorerClasses.translateText;
    } else {
      isClassesDental = 0;
      classesDentalText = "";
    }
  }

  void getUpdateMultipleSelectionItems(String receivedData,
      List<SelectionItem> techniquesItems, bool isOptionalValue) {
    List<String> dataItems = receivedData.split(", ");

    for (var dataItem in dataItems) {
      String itemTitle = dataItem;
      String? note = null;

      if (dataItem.contains(":")) {
        var parts = dataItem.split(":");
        itemTitle = parts[0].trim();
        note = parts[1].trim();
      }

      for (var item in techniquesItems) {
        if (item.title == itemTitle) {
          item.isSelected = true;
          if (note != null) {
            item.requiresNote = true;
            item.note = note;
            item.noteController?.text = note;
          }

          // Handle optional Yes/No values for dentalHistory
          if (isOptionalValue && item.dentalHistory) {
            if (note?.toLowerCase() == 'yes') {
              item.dentalHistorySelected = true;
              item.requiresNote = false;
            } else if (note?.toLowerCase() == 'no') {
              item.dentalHistorySelected = false;
              item.requiresNote = false;
            }
          }
        }
      }
    }
  }

  /*Future<void> uploadDicomFile(File file, var patientId) async {
    isLoading = true;
    update();

    // Generate unique upload ID if not already set
    if(uploadId==null){
      uploadId = generateUploadId();
    }


    // Determine file extension
    String fileExtension = getFileExtension(file);

    // Split file into chunks
    int chunkSize = 1 * 1024 * 1024; // 1 MB chunks
    int totalChunks = (file.lengthSync() / chunkSize).ceil();

    RandomAccessFile raf = await file.open();

    try {
      for (int i = 0; i < totalChunks; i++) {
        int start = i * chunkSize;
        int end = start + chunkSize;
        if (end > file.lengthSync()) {
          end = file.lengthSync();
        }

        raf.setPositionSync(start);
        List<int> chunkBytes = raf.readSync(end - start);

        // Write chunk to temporary file
        File chunkFile = File('${file.path}_chunk_$i');
        await chunkFile.writeAsBytes(chunkBytes);

        ResponseItem result = await AddPatientRepo.uploadPatientDcomFile(
          file: chunkFile,
          chunkIndex: '$i',
          extension: fileExtension,
          totalChunks: '$totalChunks',
          uploadId: uploadId,
          patientId: patientData?.patientId.toString(),
        );

        if (!result.status) {
          // Handle failure
          showAppSnackBar('Chunk $i upload failed: ${result.msg}');
          isLoading = false;
          update();
          return;
        }

        // Delete temporary chunk file
        await chunkFile.delete();
      }
    } catch (e) {
      // Handle exceptions
      showAppSnackBar('File upload failed: $e');
      isLoading = false;
    } finally {
      await raf.close();
    }
    // All chunks uploaded successfully
    showAppSnackBar('File uploaded successfully');
    isLoading = false;
    uploadId = null; // Reset uploadId for next upload
    update();
  }*/
  Future<void> uploadDicomFile(File file, String forWhat) async {
    isDcomFileLoading = true;
    uploadProgress = 0.0;
    update();
    // Generate unique upload ID if not already set
    if (uploadId == null) {
      uploadId = generateUploadId();
    }
    // Determine file extension
    String fileExtension = getFileExtension(file);
    // Split file into chunks
    int chunkSize = 10 * 1024 * 1024; // 1 MB chunks
    int totalChunks = (file.lengthSync() / chunkSize).ceil();

    RandomAccessFile raf = await file.open();
    bool allChunksUploaded = true; // Track overall success

    try {
      for (int i = 0; i < totalChunks; i++) {
        int start = i * chunkSize;
        int end = start + chunkSize;
        if (end > file.lengthSync()) {
          end = file.lengthSync();
        }

        raf.setPositionSync(start);
        List<int> chunkBytes = raf.readSync(end - start);

        // Write chunk to temporary file
        File chunkFile = File('${file.path}_chunk_$i');
        await chunkFile.writeAsBytes(chunkBytes);
        for (int j = 0; j < 100; j++) {
          await Future.delayed(Duration(milliseconds: 10));
          uploadProgress = (i + j / 100) / totalChunks;
          update();
        }
        ResponseItem result = await AddPatientRepo.uploadPatientDcomFile(
          file: chunkFile,
          chunkIndex: '$i',
          extension: fileExtension,
          totalChunks: '$totalChunks',
          uploadId: uploadId,
          patientId: patientData?.patientId.toString() ?? patientId.toString(),
          forWhat: forWhat,
          // isForRefinements: isRefinement ? 1 : 0,
          refinementNumber: refinementNumber,
        );
        if (!result.status) {
          // Handle failure
          showAppSnackBar('Chunk $i upload failed: ${result.msg}');
          allChunksUploaded = false; // Set overall success to false
          break; // Exit loop on failure
        }
        uploadProgress = (i + 1) / totalChunks;
        update();
        // Delete temporary chunk file
        await chunkFile.delete();
      }
      uploadProgress = 1.0;
      update();
    } catch (e) {
      // Handle exceptions
      showAppSnackBar('File upload failed: $e');
      allChunksUploaded = false; // Set overall success to false
    } finally {
      await raf.close();
      // Reset uploadId for next upload
      uploadId = null;
      isDcomFileLoading = false;
      update();
      // Show final success or failure message
      if (allChunksUploaded) {
        showAppSnackBar(LocaleKeys.fileUploadedSuccessfully.translateText);
      } else {
        showAppSnackBar(LocaleKeys.fileUploadFailed.translateText);
      }
    }
  }

  String getFileExtension(File file) {
    String fileName = file.path;
    int dotIndex = fileName.lastIndexOf('.');
    return (dotIndex != -1) ? fileName.substring(dotIndex + 1) : '';
  }

  String generateUploadId() {
    var uuid = Uuid();
    return uuid.v4();
  }
}
