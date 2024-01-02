import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  const InputText({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.label,
  });

  final TextEditingController textEditingController;
  final String hintText;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              // border: Border.all(width: 1, color: Colors.grey[500]!),
              borderRadius: BorderRadius.circular(5)),
          child: TextFormField(
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
                border: InputBorder.none,
                focusedBorder: InputBorder.none),
            controller: textEditingController,
          ),
        ),
      ],
    );
  }
}
