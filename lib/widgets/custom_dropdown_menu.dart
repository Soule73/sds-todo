import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatelessWidget {
  const CustomDropdownMenu(
      {super.key,
      this.selectedValue,
      this.width,
      required this.list,
      required this.controller,
      required this.label});

  final double? width;
  final String label;
  final String? selectedValue;
  final List<String> list;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: SizedBox(
            width: double.maxFinite,
            child: Text(
              "Type",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ),
        DropdownMenu<String>(
          controller: controller,
          width: width ?? MediaQuery.of(context).size.width / 5 * 4.6,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5), // The rounded border
                borderSide: BorderSide.none),
            filled: true, // To fill the button with a color
            fillColor: Colors.grey.shade200, // The blue fill color
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 16,
            ), // The white hint style
            iconColor: Colors.grey.shade500, // The white icon color
          ),
          menuStyle: MenuStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey.shade100),
              // The menu style

              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5)), // The rounded border
                side: BorderSide.none, // The blue border
              ))),
          initialSelection: selectedValue,
          hintText: "Type de tâche",
          dropdownMenuEntries:
              list.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(value: value, label: value);
          }).toList(),
        ),
      ],
    );
  }
}
