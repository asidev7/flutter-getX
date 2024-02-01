import 'package:Asidoto/models/todocheck.dart';
import 'package:get/get.dart';

class TodoCheckController extends GetxController {
  var todoList = <TodoCheck>[].obs;

  void addTodoCheck(TodoCheck newTodoCheck) {
    todoList.add(newTodoCheck);
  }

  void updateTodoCheck(TodoCheck updatedTodoCheck) {
    var index = todoList.indexWhere((todo) => todo.id == updatedTodoCheck.id);
    if (index != -1) {
      todoList[index] = updatedTodoCheck;
    }
  }

  void checkTodoCheck(int todoId, bool isChecked) {
    var index = todoList.indexWhere((todo) => todo.id == todoId);
    if (index != -1) {
      todoList[index] = todoList[index].copyWith(isCompleted: isChecked);
    }
  }

  void deleteTodoCheck(int todoId) {
    todoList.removeWhere((todo) => todo.id == todoId);
  }
}
