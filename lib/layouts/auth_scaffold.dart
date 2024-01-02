import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/screen/todo_scren.dart';

class ScaffoldAuth extends StatelessWidget {
  const ScaffoldAuth({super.key, required this.title, required this.body});

  // Créez une instance de FirebaseAuth
  static FirebaseAuth auth = FirebaseAuth.instance;

  final String title;
  final Widget body;
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
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Center(
                    child: Text(
                  title,
                  style: const TextStyle(fontSize: 18),
                )),
              ),
              body: SingleChildScrollView(child: body));
        }
      },
    );
  }
}
