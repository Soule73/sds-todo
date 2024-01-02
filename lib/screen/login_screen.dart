import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/authentification_controller.dart';
import 'package:todo/layouts/auth_scaffold.dart';
import 'package:todo/screen/reset_password_screen.dart';
import 'package:todo/screen/sign_up_screen.dart';
import 'package:todo/screen/todo_scren.dart';
import 'package:todo/widgets/checkbox.dart';
import 'package:todo/widgets/input_password.dart';
import 'package:todo/widgets/input_text.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool isChecked = false.obs;

  setIsChecked() => isChecked.value = !isChecked.value;

  AuthenticationController authenticationController =
      Get.put(AuthenticationController());
  void signInScreen() {
    authenticationController.signInUser(email.text, password.text);
    email = TextEditingController(text: "");
    password = TextEditingController(text: "");
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // Créez une instance de FirebaseAuth
  static FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        // Vérifier l'état du flux
        if (snapshot.hasData) {
          return TodoList();
        } else {
          // L'utilisateur n'est pas connecté, le rediriger vers la page de connexion
          return LogIn();
        }
      },
    );
  }
}

class LogIn extends StatelessWidget {
  LogIn({
    super.key,
  });

  final LoginController loginController = Get.put(LoginController());

  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return ScaffoldAuth(
        title: "Connexion",
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SvgPicture.asset(
                  'assets/icons/sign_in.svg',
                  fit: BoxFit.scaleDown,
                  width: MediaQuery.of(context).size.width / 2 * 1.5,
                ),
              ),
              InputText(
                textEditingController: loginController.email,
                hintText: "Tapez votre e-mail",
                label: "E-mail",
              ),
              const SizedBox(height: 15),
              InputPassword(
                textEditingController: loginController.password,
                hintText: "Votre Mot de passe",
                label: "Mot de passe",
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(() => InputCheckbox(
                          isChecked: loginController.isChecked.value,
                          onChanged: () => loginController.setIsChecked())),
                      const Text("Se souvenir de moi"),
                    ],
                  ),
                  InkWell(
                    onTap: () => Get.to(ResetPasswordScreen()),
                    child: Text(
                      "Mot de passe oublié?",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () => loginController.signInScreen(),
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
                  child: Obx(() => _authenticationController.isLoading.value
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
                          "Se connecté",
                          style: TextStyle(
                              color: Colors.grey[100],
                              fontWeight: FontWeight.w800,
                              fontSize: 20),
                        ))),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("Pas de compte?"),
                  TextButton(
                      onPressed: () => Get.to(SignUpScreen()),
                      child: const Text("Créer un compte")),
                ],
              ),
            ],
          ),
        ));
  }
}
