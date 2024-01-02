import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BasicDateTimeField extends StatelessWidget {
  final format = DateFormat("d MMM yyyy à HH:mm");
  final TextEditingController? controller;

  BasicDateTimeField({super.key, this.label, this.controller, this.onChanged});
  final String? label;
  final Function? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      label != ""
          ? Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  label ?? "",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            )
          : Container(),
      Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: DateTimeField(
          onChanged: (DateTime? time) => onChanged!(time),
          style: const TextStyle(fontSize: 13),
          controller: controller,
          decoration: const InputDecoration(
              fillColor: Colors.transparent,
              border: OutlineInputBorder(borderSide: BorderSide.none)),
          format: format,
          onShowPicker: (context, currentValue) async {
            return await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100),
            ).then((DateTime? date) async {
              if (date != null) {
                final time = await showTimePicker(
                  context: context,
                  initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );
                return DateTimeField.combine(date, time);
              } else {
                return currentValue;
              }
            });
          },
        ),
      ),
    ]);
  }
}
