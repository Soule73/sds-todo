import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputPasswordController extends GetxController {
  RxBool isObscure = true.obs;

  setisObscure() => isObscure.value = !isObscure.value;
}

class InputPassword extends StatelessWidget {
  InputPassword({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.label,
  });

  final InputPasswordController passwordController =
      Get.put(InputPasswordController());

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
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8)),
            child: Obx(
              () => TextFormField(
                obscureText: passwordController.isObscure.value,
                decoration: InputDecoration(
                    suffix: GestureDetector(
                        onTap: () => passwordController.setisObscure(),
                        child: Icon(
                          passwordController.isObscure.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context).primaryColor,
                        )),
                    hintText: hintText,
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none),
                controller: textEditingController,
              ),
            )),
      ],
    );
  }
}
