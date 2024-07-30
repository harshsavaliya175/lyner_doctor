class SelectionItem {
  String title;
  bool requiresNote;
  String? note;

  SelectionItem({
    required this.title,
    this.requiresNote = false,
    this.note,
  });
}