import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/controllers/profile_controller.dart';

class UploadProfileImage extends StatelessWidget {
  UploadProfileImage({super.key});

  final ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.photo_library),
              onPressed: () async {
                // choisir une image à partir de la galerie
                XFile? pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);

                // Vérifier si l'utilisateur a choisi une image
                if (pickedFile != null) {
                  //appeler la fonctin pour mettre à jour l'image
                  profileController.uploadImage(File(pickedFile.path));
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: () async {
                // choisir une image à partir de la caméra
                XFile? pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.camera);

                // Vérifier si l'utilisateur a choisi une image
                if (pickedFile != null) {
                  //appeler la fonctin pour mettre à jour l'image
                  profileController.uploadImage(File(pickedFile.path));
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
