import 'package:Asidoto/controllers/homecontroller.dart';
import 'package:Asidoto/controllers/todoformcontroller.dart';
import 'package:Asidoto/models/produit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Existing imports

class AddTaskScreen extends StatelessWidget {
  final HomeController controller = Get.find();
  final TodoFormController formController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajouter une tache')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: formController.titleController,
              decoration: InputDecoration(labelText: 'Titre'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: formController.descriptionController,
              maxLines: null, // Allow multiple lines for description
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'Description',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Annuller'),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.addTodo(
                      TodoList(
                        id: controller.todo.length + 1,
                        title: formController.titleController.text,
                        description: formController.descriptionController.text,
                      ),
                    );
                    formController.clearFields();
                    Navigator.of(context).pop();
                  },
                  child: Text('Ajouter'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
