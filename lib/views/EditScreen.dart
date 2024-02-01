import 'package:flutter/material.dart';
import 'package:Asidoto/models/produit.dart';

class EditTodoPage extends StatefulWidget {
  final TodoList todoItem;

  EditTodoPage({required this.todoItem});

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.todoItem.title);
    descriptionController = TextEditingController(text: widget.todoItem.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modification de note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Ajouter un titre...',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: descriptionController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Entrez une description...',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _saveChanges();
              },
              child: Text('Enregister les modifications'),
            ),
          ],
        ),
      ),
    );
  }
void _saveChanges() {
  // Create a copy of the TodoList item with updated values
  TodoList updatedTodoItem = TodoList(
    id: widget.todoItem.id,
    title: titleController.text,
    description: descriptionController.text,
  );

  // Save changes (you might want to save to a database or another storage)
  // For simplicity, you can update the data in your GetX controller
  // For example:
  // Get.find<HomeController>().updateTodoItem(updatedTodoItem);

  Navigator.of(context).pop(); // Close the edit screen
}
}
