import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/screen/todo_scren.dart';
import 'package:todo/services/todo_service.dart';
import 'package:todo/widgets/alerte.dart';

class TodosController extends GetxController {
  @override
  void onInit() {
    getCurrentTodo();
    super.onInit();
  }

  RxInt indexSelected = 0.obs;

  void setIndex(int i) {
    indexSelected.value = i;
    getCurrentTodo();
  }

  var isLoadingTodos = false.obs;
  final TodoService todoSercive = TodoService();

  List<Todo> todosList = [];

  void setIsLoadingTodos(bool newValue) {
    isLoadingTodos.value = newValue;
  }

  Future<void> getProgress() async {
    try {
      setIsLoadingTodos(true);
      todosList = await todoSercive.getProgress();

      setIsLoadingTodos(false);
    } catch (e) {
      setIsLoadingTodos(false);
    }
  }

  Future<void> getPending() async {
    try {
      setIsLoadingTodos(true);
      todosList = await todoSercive.getPending();

      setIsLoadingTodos(false);
    } catch (e) {
      setIsLoadingTodos(false);
    }
  }

  Future<void> getEnd() async {
    try {
      setIsLoadingTodos(true);
      todosList = await todoSercive.getEnd();

      setIsLoadingTodos(false);
    } catch (e) {
      setIsLoadingTodos(false);
    }
  }

  Future<void> getCurrentTodo() async {
    if (indexSelected.value == 0) {
      await getProgress();
    } else if (indexSelected.value == 1) {
      await getPending();
    } else {
      getEnd();
    }
  }

  Future<void> createTodo(Todo todo) async {
    setIsLoadingTodos(true);
    try {
      await todoSercive.createTodo(todo);
      await getCurrentTodo();

      alertMessage("Succées", "tâche ajouté", "success", Get.back);
      Get.to(TodoList());
    } catch (e) {
      alertMessage("Erreur", "Une erreur se produit", "error", Get.back);
    }
    setIsLoadingTodos(false);
  }

  Future<void> getTodosByCategoryId(String categoryId) async {
    try {
      setIsLoadingTodos(true);
      todosList = await todoSercive.getTodosByType(categoryId);

      setIsLoadingTodos(false);
    } catch (e) {
      setIsLoadingTodos(false);
    }
  }

  void deleteTodo(String? id) {
    if (id != "") {
      Get.defaultDialog(
        titleStyle: const TextStyle(fontSize: 15),
        titlePadding: const EdgeInsets.all(18),
        title: "Es-tu certain de vouloir supprimer cette tâche?",
        content: Center(
          child: Container(
            width: 85,
            height: 85,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(50)),
            child: const Center(
              child: FaIcon(
                FontAwesomeIcons.info,
                color: Colors.grey,
                size: 40,
              ),
            ),
          ),
        ),
        cancel: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.grey.shade200,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          onPressed: () =>
              Navigator.of(Get.overlayContext!, rootNavigator: true).pop(),
          child: Text(
            "Annuler",
            style: TextStyle(color: Colors.grey.shade800),
          ),
        ),
        confirm: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.red,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          onPressed: () {
            Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
            try {
              todoSercive.deleteTodo(id!);
              alertMessage("Info", "Tâche supprimé", "info", () {});
              getCurrentTodo();
            } catch (_) {}
          },
          child: const Text(
            "ok",
            style: TextStyle(color: Colors.white),
          ),
        ),
        confirmTextColor: Colors.white,
        cancelTextColor: Colors.grey.shade800,
      );
    }
  }

  Future<void> searchTodos(String text) async {
    String search = text.trim();
    try {
      setIsLoadingTodos(true);
      if (search != "") {
        todosList = await todoSercive.searchTodos(search);
      } else {
        getCurrentTodo();
      }

      setIsLoadingTodos(false);
    } catch (e) {
      setIsLoadingTodos(false);
    }
  }
}
