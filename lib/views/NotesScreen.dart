import 'dart:ui';

import 'package:Asidoto/views/EditScreen.dart';
import 'package:Asidoto/views/addNotes.dart';
import 'package:flutter/material.dart';
import 'package:Asidoto/controllers/homecontroller.dart';
import 'package:Asidoto/controllers/todoformcontroller.dart';
import 'package:Asidoto/models/produit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotesScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final TodoFormController formController = Get.put(TodoFormController());
String _formatDate(DateTime date) {
  return '${_getMonthAbbreviation(date.month)} ${date.day}, ${date.year}';
}

String _getMonthAbbreviation(int month) {
  switch (month) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'May';
    case 6:
      return 'Jun';
    case 7:
      return 'Jul';
    case 8:
      return 'Aug';
    case 9:
      return 'Sep';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    case 12:
      return 'Dec';
    default:
      return '';
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes taches'),
        actions: [
          IconButton(
            onPressed: () {
              _showAboutUsDialog(context);
            },
            icon: Icon(Icons.info),
          ),
        ],
      ),
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
                          SizedBox(height: 4),
                          Text('${_formatDate(todoItem.datePublished)} '),
                        ],
                      ),
                      onTap: () {
          
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => EditTodoPage(todoItem: todoItem),
    ),
  );
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
      ), 
      floatingActionButton: ClipOval(
    child: Material(
      color: Colors.blue, // button color
      child: InkWell(
        splashColor: Colors.white, // splash color
        onTap: () {
          _showAddTodoScreen(context, formController, homeController);
        },
        child: SizedBox(
          width: 56,
          height: 56,
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    ),
      )
    );
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
            child: Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              controller
                  .deleteTodo(todoItem); // Add the method to delete the todo
              Navigator.of(context).pop();
            },
            child: Text('Supprimer'),
          ),
        ],
      );
    },
  );
}
void _showAddTodoScreen(BuildContext context, TodoFormController formController, HomeController controller) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTaskScreen()),
    );
  }
}

void _showAboutUsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          title: Text('Qui suis-je ?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Créé par Asidev'),
              SizedBox(height: 8),
              Text('Suivez-nous sur Facebook pour plus d\'informations:'),
              SizedBox(height: 7),
              Text('Facebook: @Asidev'),
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
        ),
      );
    },
  );
}
