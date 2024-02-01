// add_todo_screen.dart

import 'package:Asidoto/controllers/todocheckController.dart';
import 'package:Asidoto/models/todocheck.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTodoScreen extends StatelessWidget {
  final TodoCheckController todoCheckController = Get.find();

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Ajouter une tâche')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Entrez une tâche'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String todoTitle = titleController.text;
                todoCheckController.addTodoCheck(
                  TodoCheck(id: DateTime.now().millisecondsSinceEpoch, title: todoTitle, isCompleted: false),
                );
                Get.back(); // Go back to the previous screen
              },
              child: Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }
}
