class TodoCheck {
  final int id;
  final String title;
  final bool isCompleted;

  TodoCheck({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

 TodoCheck copyWith({
    int? id,
    String? title,
    bool? isCompleted,
  }) {
    return TodoCheck(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}