import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/add_patient_repo/add_patient_repo.dart';
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
  var patientTechniquesItems = <SelectionItem>[
    SelectionItem(title: 'Recommandé par Lyner'),
    SelectionItem(title: 'IPR (stripping)'),
    SelectionItem(title: 'Taquets'),
    SelectionItem(title: 'Pas de taquets sur les dents', requiresNote: true),
    SelectionItem(title: 'Elastiques'),
    SelectionItem(title: 'Boutons à coller'),
    SelectionItem(title: 'Extractions requises : dents n°', requiresNote: true),
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
    SelectionItem(title: 'Rien de particulier'),
    SelectionItem(title: 'Dents mobiles', requiresNote: true),
    SelectionItem(title: 'Traumat', requiresNote: true),
    SelectionItem(title: 'Implant', requiresNote: true),
    SelectionItem(title: 'Bridge', requiresNote: true),
    SelectionItem(
        title: 'Problème d’ATM',
        dentalHistory: true,
        dentalHistorySelected: true),
    SelectionItem(title: 'Apnée du sommeil'),
    SelectionItem(title: 'Autres informations pertinentes', requiresNote: true),
  ];
  var middleMaxillaryItems = <SelectionItem>[
    SelectionItem(title: 'Centré'),
    SelectionItem(title: 'Décalé vers la droite'),
    SelectionItem(title: 'Décalé vers la gauche'),
  ];
  var incisorCoveringItems = <SelectionItem>[
    SelectionItem(title: 'Recommandé par Lyner'),
    SelectionItem(
        title:
            'Augmentation de la dimension verticale (égression molaires et prémolaires)'),
    SelectionItem(title: 'Ingression des incisives maxillaire'),
    SelectionItem(title: 'Ingression des incisives mandibulaires'),
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
  }

  void selectProduct(ProductListData product) {
    selectedProduct.value = product;
    isSelectedProductPlan = selectedProduct.value == product;
    stepErrors[0] = false;
    update();
  }

  void fetchProducts() async {
    try {
      // isLoading(true);
      ProductListModel productList =
          await AddPatientRepo.instance.getProductsFromAssets();
      products = productList.data;
      update();
      print(products);
    } finally {
      // isLoading(false);
    }
  }

  void goToStep(int step) {
    currentStep.value = step;
    pageController.jumpToPage(step);
    update();
  }
}
