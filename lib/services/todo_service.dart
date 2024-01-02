import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/utils/format_date.dart';
import 'package:todo/widgets/alerte.dart';

class TodoService {
// ==================================
// || Status  || Condition         ||
// ==================================
// || Prgress || startAt<now<EndAt ||
// ==================================
// || Pending || now<startAt<EndAt ||
// ==================================
// || End     || startAt<EndAt<now ||
// ==================================
//
// progress%=(total secondes beewen startAt-now/total secondes beewen startAt-endAt)*100
//

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  List<Todo> litsTodo(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> todoMaps) {
    final List<Todo> todos =
        todoMaps.map((e) => Todo.fromJson(e.data(), e.id)).toList();

    return todos;
  }

  void deleteTodo(String id) async {
    try {
      await firebaseFirestore.collection('todos').doc(id).delete();
    } catch (_) {
      alertMessage(
          "Erreur", "Une erreur est survenue", "error", () => Get.back());
    }
  }

  Future<List<Todo>> getProgress() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      Stream<List<Todo>> todo = firebaseFirestore
          .collection('todos')
          .where("userId", isEqualTo: user?.uid)
          .orderBy("startAt")
          .where("startAt", isLessThanOrEqualTo: DateTime.now().toString())
          .snapshots()
          .map((snapshot) => snapshot.docs)
          .map((docSnapshots) => docSnapshots
              .map((doc) => Todo.fromJson(doc.data(), doc.id))
              .toList())
          .map((todos) => todos
              .where((todo) =>
                  compareTwoDates(DateTime.now(), DateTime.parse(todo.endAt!)) >
                  0)
              .toList());

      // convert the stream to a future using Stream.fromFuture
      return Stream.fromFuture(todo.first).first;
    } catch (_) {
      return [];
    }
  }

  Future<List<Todo>> getPending() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore
              .collection('todos')
              .where("userId", isEqualTo: user?.uid)
              .orderBy("startAt")
              .where("startAt", isGreaterThan: DateTime.now().toString())
              .get();
      return litsTodo(querySnapshot.docs);
    } catch (error) {
      return [];
    }
  }

  Future<List<Todo>> getEnd() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore
              .collection('todos')
              .where("userId", isEqualTo: user?.uid)
              .where("endAt", isLessThan: DateTime.now().toString())
              .get();
      return litsTodo(querySnapshot.docs);
    } catch (error) {
      return [];
    }
  }

  Future<List<Todo>> getTodosByType(String type) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore
              .collection('todos')
              .where("userId", isEqualTo: user?.uid)
              .orderBy("startAt")
              .where("type", isEqualTo: type)
              .get();
      return litsTodo(querySnapshot.docs);
    } catch (error) {
      return [];
    }
  }

  Future<void> createTodo(Todo todo) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      await firebaseFirestore.collection('todos').add({
        "userId": user?.uid,
        "type": todo.type,
        "title": todo.title,
        "startAt": todo.startAt,
        "endAt": todo.endAt,
      });
    } catch (error) {
      alertMessage("Erreur", "Une erreur se produit", "error", Get.back);
    }
  }

  Future<List<Todo>> searchTodos(String text) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore
              .collection('todos')
              .where("userId", isEqualTo: user?.uid)
              .orderBy("title")
              .startAt([text]).endAt(['$text\uf8ff']).get();
      return litsTodo(querySnapshot.docs);
    } catch (error) {
      return [];
    }
  }
}
