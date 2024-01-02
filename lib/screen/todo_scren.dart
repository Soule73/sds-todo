import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/authentification_controller.dart';
import 'package:todo/controllers/todos_controller.dart';
import 'package:todo/screen/create_toto.dart';
import 'package:todo/layouts/scaffold_defaut.dart';
import 'package:todo/widgets/search_bar.dart';
import 'package:todo/widgets/todo_list.dart';

class TodoList extends StatelessWidget {
  TodoList({super.key});
  final userAuth = Get.put(AuthenticationController());

  final TodosController todosController = Get.put(TodosController());
  final List<String> status = ["En progres", "A faire", "Terminer"];

  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          focusColor: Colors.blue.shade300,
          hoverColor: Colors.blue.shade600,
          onPressed: () => Get.to(CreateTodo()),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 70),
            child: Column(
              children: [
                SearchBarWidget(),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        "Mes tâches",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ),
                Row(
                  children: [
                    for (int i = 0; i < status.length; i++)
                      Obx(() => SizedBox(
                            child: CategoryCard(
                              onTap: () => todosController.setIndex(i),
                              isSelected:
                                  todosController.indexSelected.value == i,
                              text: status[i],
                            ),
                          )),
                  ],
                ),
                // const StatusTodoWidget(),
                const SizedBox(height: 10),
                TodoListWidget()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  final String text;
  final bool isSelected;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
          width: 90,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey.shade300),
            color: isSelected ? Colors.blue : Theme.of(context).cardColor,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
          margin: const EdgeInsets.symmetric(horizontal: 8 * 0.5),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.grey),
          )),
    );
  }
}
