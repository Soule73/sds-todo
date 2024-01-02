import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/todos_controller.dart';
import 'package:todo/widgets/todo_item.dart';

class TodoListWidget extends StatelessWidget {
  TodoListWidget({super.key});

  final TodosController todosController = Get.put(TodosController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => todosController.isLoadingTodos.value
        ? const Padding(
            padding: EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 30, height: 30, child: CircularProgressIndicator()),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "En cours",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                ),
              ],
            ),
          )
        : todosController.todosList.isNotEmpty
            ? Column(
                children: [
                  for (int i = 0; i < todosController.todosList.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: TodoItemWidget(todo: todosController.todosList[i]),
                    )
                ],
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height / 5 * 3,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        todosController.indexSelected.value == 0
                            ? 'assets/icons/progress.svg'
                            : todosController.indexSelected.value == 1
                                ? 'assets/icons/pending.svg'
                                : 'assets/icons/awesome.svg',
                        fit: BoxFit.scaleDown,
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        todosController.indexSelected.value == 0
                            ? "Pas de tâche en cours"
                            : todosController.indexSelected.value == 1
                                ? "Pas de tâche à faire"
                                : "Aucune tâche achevée",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        todosController.indexSelected.value == 0
                            ? "Ici, vous pouvez voir les tâches qui sont en cours"
                            : todosController.indexSelected.value == 1
                                ? "Les tâches en attente sont affichées ici"
                                : "Ici, vous pouvez consulter les tâches qui sont terminées",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                )),
              ));
  }
}
