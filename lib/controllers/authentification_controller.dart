import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:todo/screen/todo_scren.dart';
import 'package:todo/services/authentication.dart';

class AuthenticationController extends GetxController {
  final AuthService authService = AuthService();

  Rx<User?> user = Rx<User?>(null);
  final RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(auth.currentUser);

    ever(user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (auth.currentUser != null) {
      Get.offAll(() => TodoList());
    }
  }

  Future<void> signUpUser(String email, String password) async {
    isLoading.value = true;
    try {
      user.value = await authService.signUpUser(email, password);
      if (user.value != null) {
        Get.to(() => TodoList());
      }
    } catch (_) {}

    isLoading.value = false;
  }

  Future<void> signInUser(String email, String password) async {
    isLoading.value = true;
    try {
      user.value = await authService.signInUser(email, password);
      if (user.value != null) {
        Get.to(() => TodoList());
      }
    } catch (_) {}
    isLoading.value = false;
  }

  Future<void> signOutUser() async {
    isLoading.value = true;
    try {
      await authService.signOutUser();
      user.value = null;
    } catch (_) {}
    isLoading.value = false;
  }
}
