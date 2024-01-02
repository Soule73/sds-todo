import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/profile_controller.dart';
import 'package:todo/widgets/alerte.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// create user
  Future<User?> signUpUser(
    String email,
    String password,
  ) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;

        DocumentReference ref =
            firestore.collection('users').doc(firebaseUser.uid);

        await ref.set({"photoUrl": ""});

        return firebaseUser;
      }
    } on FirebaseAuthException catch (e) {
      // Gérer les exceptions Firebase Auth
      if (e.code == 'email-already-in-use') {
        // L'email est déjà utilisé par un autre compte
        alertMessage(
            "Erreur",
            "L'adresse e-mail est déjà utilisée par un autre compte",
            "error",
            Get.back);
      } else if (e.code == 'invalid-email') {
        // L'email n'est pas valide
        alertMessage(
            "Erreur", "L'adresse e-mail n'est pas valide", "error", Get.back);
      } else if (e.code == 'weak-password') {
        // Le mot de passe est trop faible
        alertMessage(
            "Erreur", "Le mot de passe est trop faible", "error", Get.back);
      } else {
        // Autre erreur
        alertMessage("Erreur", "Une erreur est survenue", "error", Get.back);
      }
    } catch (e) {
      // Autre erreur
      alertMessage("Erreur", "Une erreur est survenue", "error", Get.back);
    }
    return null;
  }

  Future<User?> signInUser(String email, String password) async {
    ProfileController profileController = Get.put(ProfileController());

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        profileController.getUser();

        return firebaseUser;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // L'utilisateur n'existe pas
        alertMessage(
            "Erreur",
            'Il n\'y a pas d\'utilisateur correspondant à cet identifiant',
            "error",
            Get.back);
      } else if (e.code == 'wrong-password') {
        // Le mot de passe est incorrect
        alertMessage(
            "Erreur", "Le mot de passe est incorrect", "error", Get.back);
      } else if (e.code == 'invalid-email') {
        // L'email n'est pas valide
        alertMessage(
            "Erreur", 'L\'adresse e-mail n\'est pas valide', "error", Get.back);
      } else {
        // Autre erreur
        alertMessage("Erreur", "Une erreur est survenue", "error", Get.back);
      }
    } catch (e) {
      alertMessage("Erreur", "Une erreur est survenue", "error", Get.back);
    }
    return null;
  }

  Future<void> signOutUser() async {
    ProfileController profileController = Get.put(ProfileController());
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseAuth.instance.signOut();
    }
    profileController.setImageUrl("");
  }

  Future<void> resetUserPassword({required String email}) async {
    final auth = FirebaseAuth.instance;
    dynamic status;
    await auth
        .sendPasswordResetEmail(email: email)
        .then((value) {})
        .catchError((e) {});
    return status;
  }
}
