import 'package:Asidoto/models/produit.dart';
import 'package:flutter/material.dart';

class TaskDetailsPage extends StatelessWidget {
  final TodoList todoItem;
  static const String defaultTitle = 'Titre par défaut'; // Set your default title

  TaskDetailsPage({required this.todoItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todoItem.title.isNotEmpty ? todoItem.title : defaultTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              'Description:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              todoItem.description,
              style: TextStyle(fontSize: 16),
            ),
            // Add other fields as needed
          ],
        ),
      ),
    );
  }
}
