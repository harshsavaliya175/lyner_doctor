class SelectionItem {
  String title;
  bool requiresNote;
  bool isSelected;
  bool dentalHistory;
  bool dentalHistorySelected;
  String? note;

  SelectionItem({
    required this.title,
    this.requiresNote = false,
    this.isSelected = false,
    this.dentalHistory = false,
    this.dentalHistorySelected = false,
    this.note,
  });
}