import 'package:flutter/material.dart';

class CastumTextFormField extends StatelessWidget {
  const CastumTextFormField({
    super.key,
    required this.textEditingController,
    required this.isObscure,
    required this.hintText,
    this.label,
  });

  final TextEditingController textEditingController;
  final bool isObscure;
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
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8)),
          child: TextFormField(
            obscureText: isObscure,
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 16,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none),
            controller: textEditingController,
          ),
        ),
      ],
    );
  }
}
