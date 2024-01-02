import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/authentification_controller.dart';
import 'package:todo/layouts/auth_scaffold.dart';
import 'package:todo/screen/login_screen.dart';
import 'package:todo/widgets/alerte.dart';
import 'package:todo/widgets/input_password.dart';
import 'package:todo/widgets/input_text.dart';

class SignUpController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  RxBool isChecked = false.obs;

  setIsChecked() => isChecked.value = !isChecked.value;

  AuthenticationController authenticationController =
      Get.put(AuthenticationController());
  void signInScreen() {
    if (confirmPass.text == password.text) {
      authenticationController.signUpUser(email.text, password.text);
      email = TextEditingController(text: "");
      password = TextEditingController(text: "");
      confirmPass = TextEditingController(text: "");
    } else {
      alertMessage(
          "Erreur",
          "Le mot de passe que vous avez saisi ne correspond pas.",
          "error",
          () {});
    }
  }
}

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final SignUpController signUpController = Get.put(SignUpController());

  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return ScaffoldAuth(
        title: "Créer un compte",
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SvgPicture.asset(
                  'assets/icons/sign_up.svg',
                  fit: BoxFit.scaleDown,
                  width: MediaQuery.of(context).size.width / 2,
                ),
              ),
              InputText(
                textEditingController: signUpController.email,
                hintText: "Tapez votre e-mail",
                label: "E-mail",
              ),
              const SizedBox(height: 15),
              InputPassword(
                textEditingController: signUpController.password,
                hintText: "Votre Mot de passe",
                label: "Mot de passe",
              ),
              const SizedBox(height: 15),
              InputPassword(
                textEditingController: signUpController.confirmPass,
                hintText: "Conrmé le Mot de passe",
                label: "Confirmé",
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => signUpController.signInScreen(),
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
                      )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("Vous avez un compte? "),
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
