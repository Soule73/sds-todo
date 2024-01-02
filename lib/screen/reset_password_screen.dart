import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:todo/layouts/auth_scaffold.dart';
import 'package:todo/screen/login_screen.dart';
import 'package:todo/services/authentication.dart';

import 'package:todo/widgets/input_text.dart';

class ResetPasswordController extends GetxController {
  final AuthService authService = AuthService();
  RxBool isLoad = false.obs;
  TextEditingController email = TextEditingController();

  void signInScreen() {
    isLoad.value = true;
    authService.resetUserPassword(email: email.text);
    email.text = "";
    isLoad.value = false;

    Get.snackbar(
      "Succès", // Ajoutez un titre
      "Nous avons envoyé un lien de réinitialisation à votre adresse",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 8),
      backgroundColor: Colors.green,
      icon: const Icon(Icons.check, color: Colors.grey), // Ajoutez une icône
      mainButton: TextButton(
          onPressed: () {}, child: const Text("OK")), // Ajoutez un bouton
    );
    Get.to(const LoginScreen());
  }
}

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  // Créez une instance de FirebaseAuth
  static FirebaseAuth auth = FirebaseAuth.instance;

  final ResetPasswordController resetPasswordController =
      Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    return ScaffoldAuth(
        title: "Reinitialiser le mot de passe",
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: SvgPicture.asset(
                  'assets/icons/forgot_password.svg',
                  fit: BoxFit.scaleDown,
                  width: MediaQuery.of(context).size.width / 2 * 1.5,
                ),
              ),
              InputText(
                textEditingController: resetPasswordController.email,
                hintText: "Tapez votre e-mail",
                label: "E-mail",
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () => resetPasswordController.signInScreen(),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.blue.shade700,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(double.infinity, 50),
                    ),
                  ),
                  child: Obx(() => resetPasswordController.isLoad.value
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 30,
                              height: 30,
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: Colors.white,
                              )),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "En cours...",
                              style: TextStyle(
                                  color: Colors.grey[100],
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20),
                            ),
                          ],
                        )
                      : Text(
                          "Reinitialiser",
                          style: TextStyle(
                              color: Colors.grey[100],
                              fontWeight: FontWeight.w800,
                              fontSize: 20),
                        ))),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("Vous vous souvez?"),
                  TextButton(
                      onPressed: () => Get.to(const LoginScreen()),
                      child: const Text("Se connecté")),
                ],
              ),
            ],
          ),
        ));
  }
}
