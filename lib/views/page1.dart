import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp1/controllers/homecontroller.dart';
import 'package:myapp1/controllers/todoformcontroller.dart';
import 'package:myapp1/models/produit.dart';

class Home extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final TodoFormController formController = TodoFormController();
  final MenuController menuController = Get.put(MenuController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes taches'),
      ),
      body: GetX<HomeController>(
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.todo.length,
            itemBuilder: (context, index) {
              TodoList todoItem = controller.todo[index];
            return Card(
  elevation: 5, // Adjust the elevation as needed
  child: Dismissible(
    key: UniqueKey(), // Unique key for each card
    background: Container(
      color: Colors.red, // Background color when swiping
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20),
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    ),
    onDismissed: (direction) {
      if (direction == DismissDirection.endToStart) {
        _showDeleteConfirmationDialog(context, controller, todoItem);
      }
    },
    child: ListTile(
      title: Text(todoItem.title),
      subtitle: Text(todoItem.description),
      trailing: Icon(
        Icons.delete,
        color: Colors.red,
      ),
    ),
  ),
);

            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoDialog(context, formController, homeController);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context, TodoFormController formController, HomeController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter une tache'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: formController.titleController,
                decoration: InputDecoration(labelText: 'Titre'),
              ),
              TextField(
                controller: formController.descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annueller'),
            ),
            TextButton(
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
        );
      },
    );
  }
}


void _showDeleteConfirmationDialog(BuildContext context, HomeController controller, TodoList todoItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Todo'),
          content: Text('Are you sure you want to delete this todo?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                controller.deleteTodo(todoItem); // Add the method to delete the todo
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
