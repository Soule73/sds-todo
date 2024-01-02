import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:todo/controllers/todos_controller.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/utils/format_date.dart';
import 'package:todo/widgets/alerte.dart';
import 'package:todo/widgets/custom_dropdown_menu.dart';
import 'package:todo/widgets/datetime_picker.dart';
import 'package:todo/widgets/input_text.dart';
import 'package:todo/layouts/scaffold_defaut.dart';

class CreateTodoController extends GetxController {
  static List<String> listType = <String>['Scollaire', 'Personnelle'];
  TodosController todosController = Get.put(TodosController());
  TextEditingController type = TextEditingController();
  TextEditingController title = TextEditingController();

  DateTime? startAt = DateTime.now();
  DateTime? endAt = DateTime.now();

  setStartAt(DateTime? dateTime) => startAt = dateTime;
  setEndtAt(DateTime? dateTime) => endAt = dateTime;

  RxString selectedType = listType.first.obs;

  // String dropdownValue = list.first;
  void createTodo() async {
    if (compareTwoDates(startAt!, endAt!) > 0) {
      await todosController
          .createTodo(Todo(
        type: type.text.toLowerCase(),
        title: title.text.toLowerCase(),
        startAt: startAt.toString(),
        endAt: endAt.toString(),
      ))
          .then((_) {
        type.value = const TextEditingValue(text: "");
        title.value = const TextEditingValue(text: "");
        setStartAt(DateTime.now());
        setEndtAt(DateTime.now());
      });
    } else {
      alertMessage(
          "Erreur",
          "La date de fin doit être supérieure à la date de début",
          "info",
          Get.back);
    }
  }
}

class CreateTodo extends StatelessWidget {
  CreateTodo({super.key});
  final TodosController todosController = Get.put(TodosController());

  final CreateTodoController createTodoController =
      Get.put(CreateTodoController());
  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
        child: SingleChildScrollView(
            child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: SizedBox(
                width: double.maxFinite,
                child: Text(
                  "Creer une nouvelle tâche",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/icons/todo.svg',
              fit: BoxFit.scaleDown,
              width: MediaQuery.of(context).size.width / 2 * 1.5,
            ),
            CustomDropdownMenu(
              controller: createTodoController.type,
              label: "Type",
              width: MediaQuery.of(context).size.width / 5 * 4.6,
              list: CreateTodoController.listType,
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 5 * 4.6,
              child: Column(
                children: [
                  InputText(
                    textEditingController: createTodoController.title,
                    hintText: "Titre de votre tâche",
                    label: "Titre",
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: BasicDateTimeField(
                          onChanged: createTodoController.setStartAt,
                          label: "Date de début",
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: BasicDateTimeField(
                          onChanged: createTodoController.setEndtAt,
                          label: "Date de fin",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () => createTodoController.createTodo(),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.blue.shade700,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                  const Size(double.infinity, 50),
                ),
              ),
              child: Obx(() => todosController.isLoadingTodos.value
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "En cours",
                          style: TextStyle(
                              color: Colors.grey[100],
                              fontWeight: FontWeight.w800,
                              fontSize: 20),
                        ),
                      ],
                    )
                  : Text(
                      "Creer une tâche",
                      style: TextStyle(
                          color: Colors.grey[100],
                          fontWeight: FontWeight.w800,
                          fontSize: 20),
                    )),
            )
          ],
        ),
      ),
    )));
  }
}
