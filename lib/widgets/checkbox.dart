import 'package:flutter/material.dart';

class InputCheckbox extends StatelessWidget {
  const InputCheckbox({
    super.key,
    required this.isChecked,
    required this.onChanged,
  });
  final bool isChecked;
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      if (isChecked) {
        return Colors.blue;
      }
      return Colors.grey.shade100;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) => onChanged(),
    );
  }
}
