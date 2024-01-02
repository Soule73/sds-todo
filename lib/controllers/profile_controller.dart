import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var imageUrl = "".obs;
  RxBool isSetUserProfile = false.obs;

  RxString progressState = "En cours...".obs;

  setProgress(String val) => progressState.value = val;

  setImageUrl(String url) {
    imageUrl.value = url;
  }

  setIsSetUserProfile(bool val) {
    isSetUserProfile.value = val;
  }

  Future<void> getUser() async {
    if (imageUrl.value == "") {
      setIsSetUserProfile(true);

      // Déclarer une variable pour stocker l'instance de Firestore
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      // Déclarer une variable pour stocker l'instance de Firebase Auth
      final FirebaseAuth auth = FirebaseAuth.instance;
      if (auth.currentUser != null) {
        final String uid = auth.currentUser!.uid;
        // Utiliser la méthode update de l'instance de Firestore pour mettre à jour le document de l'utilisateur dans la collection users
        DocumentSnapshot user =
            await firestore.collection('users').doc(uid).get();
        imageUrl.value = user["photoUrl"];
        setIsSetUserProfile(false);
      }
    }
  }

  Future<void> uploadImage(File file) async {
    String uid = _auth.currentUser!.uid;

    setIsSetUserProfile(true);

    try {
      Reference refExist =
          FirebaseStorage.instance.ref().child('profile_images/$uid');

      // supprimer le fichier de Firebase Storage s'il existe
      refExist.delete();
    } catch (_) {}

    try {
      //une référence de stockage avec le id du l'utisateur pour l'identifiant de l'image
      Reference ref = _storage.ref().child('profile_images/$uid');

      // télécharger l'image vers Firebase Storage
      UploadTask uploadTask = ref.putFile(file);
      uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
        switch (taskSnapshot.state) {
          case TaskState.running:
            var progress = 100.0 *
                (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            setProgress("${progress.toStringAsFixed(2)}% terminé.");
            break;
          case TaskState.paused:
            setProgress("Le téléchargement est suspendu.");
            break;
          case TaskState.canceled:
            setProgress("Le téléchargement a été annulé");
            break;
          case TaskState.error:
            {
              setProgress("Erreur");
              setIsSetUserProfile(true);
            }
            break;
          case TaskState.success:
            {
              setProgress("Complète");

              break;
            }
        }
      });
      // Attendre la fin du téléchargement et récupérer l'URL de l'image téléchargée
      String url = await (await uploadTask).ref.getDownloadURL();

      // Mettre à jour l'état du widget avec l'URL de l'image téléchargée
      await updateUser(url);
    } catch (_) {
      setIsSetUserProfile(true);
    }
  }

  // une fonction updateUser qui prend en paramètre l'URL de l'image téléchargée
  Future<void> updateUser(String imageUrl) async {
    // Récupérer l'identifiant de l'utilisateur connecté
    String uid = _auth.currentUser!.uid;

    // mettre à jour le document de l'utilisateur dans la collection users
    await _firestore.collection('users').doc(uid).update({
      'photoUrl': imageUrl,
    });

    // reinitialiser url de l'image
    setImageUrl("");

    // pour mettre à jour l'image du profile dans le widget
    getUser();

    // alerte de confirmation
    Get.snackbar(
        'Succés', // Titre du snackbar
        'Votre photo de profil a été mise à jour avec succès !', // Message du snackbar
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.grey[100]!,
        boxShadows: [
          BoxShadow(
              offset: const Offset(4, 0),
              blurRadius: 16,
              color: Colors.grey[300]!)
        ]);
  }
}
