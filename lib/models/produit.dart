class TodoList {
  final int id;
  final String title; // Updated to camelCase
  final String description; // Updated to camelCase
  final DateTime datePublished; // New field for date published

  TodoList({
    required this.id,
    required this.title,
    required this.description,
  }) : datePublished = DateTime.now(); // Automatically set to current date and time
}
