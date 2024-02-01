import 'package:Asidoto/controllers/homecontroller.dart';
import 'package:Asidoto/controllers/menuController.dart';
import 'package:Asidoto/views/NotesScreen.dart';
import 'package:Asidoto/views/TodosScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class Home extends StatelessWidget {
  final MenusController menuController = Get.put(MenusController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
      body: Obx(() {
        Widget currentScreen;
        switch (menuController.selectedIndex.value) {
          case 0:
            currentScreen = NotesScreen();
            break;
          case 1:
            currentScreen = TodoScreen();
            break;
          default:
            currentScreen = Container(); // Add a default case or widget
            break;
        }
        return currentScreen;
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: menuController.selectedIndex.value,
        onTap: menuController.selectIndex,
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.description), label: 'Notes'),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: 'To-dos'),
        ],
      ),
    );
  }
}

