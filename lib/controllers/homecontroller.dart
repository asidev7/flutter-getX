import 'package:Asidoto/models/produit.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController{
  var todo = <TodoList>[].obs;

  @override
  void onInit(){
  super.onInit();
  fetchTodoList();
}

void fetchTodoList() async{
  await Future.delayed(Duration(seconds: 30));

}


 void addTodo(TodoList newTodo) {
    todo.add(newTodo);
  }

  void deleteTodo(TodoList todoItem) {
    todo.remove(todoItem);
  }

  void clearTodos() {
    todo.clear();
  }
}

