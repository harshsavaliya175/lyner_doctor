import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/model/selection_item.dart';

class AddNewPatientController extends GetxController{
  TextEditingController searchController = TextEditingController();
  var patientList = <SelectionItem>[
    SelectionItem(title: "Lyner patient 1"),
    SelectionItem(title: "Lyner patient 2"),
    SelectionItem(title: "Lyner patient 3"),
    SelectionItem(title: "Lyner patient 4"),
    SelectionItem(title: "Lyner patient 5"),
    SelectionItem(title: "Lyner patient 6"),
    SelectionItem(title: "Lyner patient 7"),
    SelectionItem(title: "Lyner patient 2"),
    SelectionItem(title: "Lyner patient 3"),
    SelectionItem(title: "Lyner patient 4"),
    SelectionItem(title: "Lyner patient 5"),
    SelectionItem(title: "Lyner patient 6"),
    SelectionItem(title: "Lyner patient 7"),
  ];
  var selectedIndex = (-1).obs;  // Use -1 to indicate no selection

  void togglePatientSelection(int index) {
    if (selectedIndex.value == index) {
      selectedIndex.value = -1;  // Deselect if already selected
    } else {
      selectedIndex.value = index;  // Select the new index
    }
    update();
  }

}