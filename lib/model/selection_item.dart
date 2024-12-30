import 'package:flutter/cupertino.dart';

class SelectionItem {
  String title;
  bool requiresNote;
  bool isSelected;
  bool dentalHistory;
  bool dentalHistorySelected;
  TextEditingController? noteController;
  String? note;

  SelectionItem({
    required this.title,
    this.requiresNote = false,
    this.isSelected = false,
    this.dentalHistory = false,
    this.dentalHistorySelected = false,
    this.noteController,
    this.note,
  }) {
    noteController = TextEditingController(text: note);
  }
}
