import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

void alertMessage(String title, String message, String type, Function onTap,
    {String btnText = "Fermé",
    SnackPosition? snackPosition = SnackPosition.TOP}) {
  Map<String, Color> colors = {
    "info": Colors.blue,
    "success": Colors.green,
    "warning": Colors.amber,
    "error": Colors.red
  };
  Map<String, IconData> icons = {
    "success": FontAwesomeIcons.check,
    "info": FontAwesomeIcons.info,
    "warning": FontAwesomeIcons.exclamation,
    "error": FontAwesomeIcons.xmark
  };

  Get.snackbar(
      title, // Ajoutez un titre
      message,
      colorText: Colors.white,
      snackPosition: snackPosition,
      duration: const Duration(seconds: 5),
      backgroundColor: colors[type] ?? Get.context?.theme.primaryColor,
      mainButton: TextButton(onPressed: () => onTap(), child: Text(btnText)),
      icon: FaIcon(icons[type] ?? FontAwesomeIcons.info,
          color: colors[type]!) // Ajoutez une icône
      );
}
