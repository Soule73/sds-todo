import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:todo/controllers/todos_controller.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/utils/format_date.dart';

class TodoItemWidget extends StatelessWidget {
  TodoItemWidget({
    super.key,
    required this.todo,
  });

  final Todo todo;
  final TodosController todosController = Get.put(TodosController());
  @override
  Widget build(BuildContext context) {
    final double progress = progressTodo(
        DateTime.parse(todo.startAt!), DateTime.parse(todo.endAt!));
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: Colors.grey.shade300)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    todo.type!.capitalize!,
                    style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // IconButton(
                //   onPressed: () {},
                //   icon: SvgPicture.asset('assets/icons/ellipsis-horizontal.svg',
                //       fit: BoxFit.scaleDown),
                // )
                MenuAnchor(
                  builder: (BuildContext context, MenuController controller,
                      Widget? child) {
                    return IconButton(
                      onPressed: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                      icon: const Icon(Icons.more_horiz),
                      tooltip: 'Show menu',
                    );
                  },
                  menuChildren: List<MenuItemButton>.generate(
                    1,
                    (int index) => MenuItemButton(
                      onPressed: () => todosController.deleteTodo(todo.id!),
                      child: const Text('Supprimer'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  todo.title!.capitalize!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            compareTwoDates(DateTime.parse(todo.startAt!), DateTime.now()) >=
                        0 &&
                    compareTwoDates(
                          DateTime.parse(todo.endAt!),
                          DateTime.now(),
                        ) <=
                        0
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                            width: double.maxFinite,
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text("Progress"),
                            )),
                        LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width / 5 * 3,
                          animation: true,
                          barRadius: const Radius.circular(20),
                          animationDuration: 3000,
                          lineHeight: 5.0,
                          // leading: const Text("left content"),
                          trailing:
                              Text("${(progress * 100).toStringAsFixed(2)}%"),
                          percent: progress,
                          // center: const Text("20.0%"),

                          progressColor: Colors.blue,
                        ),
                      ],
                    ),
                  )
                : compareTwoDates(
                          DateTime.now(),
                          DateTime.parse(todo.endAt!),
                        ) <=
                        0
                    ? const StatusWidget(status: "Terminé")
                    : const StatusWidget(status: "En attente"),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  DateFormatWidget(
                    date: dateFormat(DateTime.parse(todo.startAt!)),
                    icon: Icons.date_range_outlined,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  DateFormatWidget(
                    date: dateFormat(DateTime.parse(todo.endAt!)),
                    icon: Icons.flag_outlined,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        Container(
          width: 100,
          decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              status,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ]),
    );
  }
}

class DateFormatWidget extends StatelessWidget {
  const DateFormatWidget({
    super.key,
    required this.date,
    required this.icon,
  });

  final String date;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.blue,
            size: 12,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            date,
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
