import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/todos_controller.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({
    super.key,
  });

  final TodosController todosController = Get.put(TodosController());
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SearchBar(
        controller: controller,
        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        )),
        shadowColor:
            MaterialStateProperty.all(Colors.transparent), // remove the shadow
        backgroundColor: MaterialStateProperty.all(Colors.grey.shade100),
        onChanged: (_) => todosController.searchTodos(controller.text),
        hintText: 'Taper le nom d’une tâche',
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/search.svg',
              fit: BoxFit.scaleDown),
          onPressed: () {},
        ));
  }
}
