import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/authentification_controller.dart';
import 'package:todo/controllers/profile_controller.dart';
import 'package:todo/layouts/drawer.dart';
import 'package:todo/screen/login_screen.dart';
import 'package:todo/screen/profle.dart';

class ScaffoldDefault extends StatelessWidget {
  ScaffoldDefault({super.key, required this.child, this.floatingActionButton});

  final Widget child;
  final userAuth = Get.put(AuthenticationController());

  final User? user = FirebaseAuth.instance.currentUser;
  final Widget? floatingActionButton;

  // Créez une instance de FirebaseAuth
  static FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        // Vérifier l'état du flux
        if (snapshot.hasData) {
          return Scaffold(
            endDrawer: AppDrawer(),
            appBar: appBarBuilder(context),
            floatingActionButton: floatingActionButton,
            body: SafeArea(
                child:
                    Padding(padding: const EdgeInsets.all(8.0), child: child)),
          );
        } else {
          // L'utilisateur n'est pas connecté, le rediriger vers la page de connexion
          return const LoginScreen();
        }
      },
    );
  }

  AppBar appBarBuilder(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());

    return AppBar(
      leading: Builder(builder: (BuildContext context) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => profileController.imageUrl.value == ""
                  ? SvgPicture.asset(
                      'assets/icons/avatar.svg',
                      fit: BoxFit.scaleDown,
                      width: 20,
                      height: 20,
                    )
                  : GestureDetector(
                      onTap: () => Get.to(ProfleScreen()),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(profileController.imageUrl.value),
                        ),
                      ),
                    ),
            ));
      }),

      title: Transform.translate(
        offset: const Offset(-15, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 2.0),
              child: SizedBox(
                width: double.maxFinite,
                child: Text(
                  "Bonjour",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Obx(() => userAuth.user.value != null
                ? SizedBox(
                    width: double.maxFinite,
                    child: Text(
                      userAuth.user.value!.email ?? "",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ))
                : Container()),
          ],
        ),
      ),
      actions: [
        Builder(
          builder: (BuildContext context) {
            return GestureDetector(
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: Icon(
                    Icons.menu,
                    size: 35,
                  ),
                ));
          },
        ),
      ],
      // title:Text(""),
    );
  }
}
