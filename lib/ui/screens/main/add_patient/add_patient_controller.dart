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
  bool firstNameError = false;
  bool emailError = false;
  bool lastNameError = false;
  // bool isArcadeTraiter = false;
  var isArcadeTraiter = 0;
  var isObjectTraitement = 0;
  var patientTechniquesItems = <SelectionItem>[
    SelectionItem(title: 'Recommandé par Lyner'),
    SelectionItem(title: 'IPR (stripping)'),
    SelectionItem(title: 'Taquets'),
    SelectionItem(title: 'Pas de taquets sur les dents', requiresNote: false),
    SelectionItem(title: 'Elastiques'),
    SelectionItem(title: 'Boutons à coller'),
    SelectionItem(title: 'Extractions requises : dents n°', requiresNote: false),
  ];

  void toggleSelection(int index) {
    patientTechniquesItems[index].requiresNote = !patientTechniquesItems[index].requiresNote;
    update();
  }

  void updateNote(int index, String note) {
    patientTechniquesItems[index].note = note;
    update();
  }

  void changeArcadeValue(int value) {
    isArcadeTraiter = value;
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
    update();
  }

  void fetchProducts() async {
    try {
      // isLoading(true);
      ProductListModel productList = await AddPatientRepo.instance.getProductsFromAssets();
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
