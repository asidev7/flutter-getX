import 'package:flutter/material.dart';
import 'package:Asidoto/controllers/homecontroller.dart';
import 'package:Asidoto/controllers/todoformcontroller.dart';
import 'package:Asidoto/models/produit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotesScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final TodoFormController formController = TodoFormController();
  String _formatDate(DateTime date) {
  // Format the date as needed
  return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: GetX<HomeController>(
        builder: (controller) {
          if (controller.todo.isEmpty) {
            // Show a centered message when the todo list is empty
            return Center(
              child: Text(
                'Aucune tâche pour le moment.',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            // Show the list when there are todos
            return ListView.builder(
              itemCount: controller.todo.length,
              itemBuilder: (context, index) {
                TodoList todoItem = controller.todo[index];
                return Card(
                  elevation: 5,
                  child: Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        _showDeleteConfirmationDialog(
                            context, controller, todoItem);
                      }
                    },
                    child: ListTile(
                      title: Text(todoItem.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(todoItem.description),
                          SizedBox(height: 4),
                          Text('Date: ${_formatDate(todoItem.datePublished)}'),
                        ],
                      ),
                      onTap: () {
                        _showTaskDetailsDialog(context, todoItem);
                      },
                      leading: Icon(
                        Icons.info,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),  floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoDialog(context, formController, homeController);
        },

        child: Icon(Icons.add),backgroundColor:Colors.blue,foregroundColor: Colors.white,
        
      ),
    );
  }



void _showTaskDetailsDialog(BuildContext context, TodoList todoItem) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Détails de la tâche'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Titre : ${todoItem.title}'),
            SizedBox(height: 8),
            Text('Description : ${todoItem.description}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Fermer'),
          ),
        ],
      );
    },
  );
}
  void _showAddTodoDialog(BuildContext context,
      TodoFormController formController, HomeController controller) {
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
              child: Text('Annuller'),
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

void _showDeleteConfirmationDialog(
    BuildContext context, HomeController controller, TodoList todoItem) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Supprimer la tache tache'),
          content: Text('Êtes-vous sûr de vouloir supprimer cette tâche ?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              controller
                  .deleteTodo(todoItem); // Add the method to delete the todo
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
        ],
      );
    },
  );
}
