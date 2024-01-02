import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:todo/controllers/authentification_controller.dart';
import 'package:todo/controllers/profile_controller.dart';
import 'package:todo/layouts/scaffold_defaut.dart';
import 'package:todo/widgets/file_upload.dart';

class ProfleScreen extends StatelessWidget {
  final ProfileController _profileController = Get.put(ProfileController());
  final AuthenticationController authenticationController =
      Get.put(AuthenticationController());

  ProfleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Center(
              child: Column(
            children: [
              Obx(() => _profileController.isSetUserProfile.value
                  ? SizedBox(
                      height: 150.0,
                      child: Stack(
                        children: <Widget>[
                          const Center(
                            child: SizedBox(
                              width: 120,
                              height: 120,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          Center(
                              child: Obx(() => Text(
                                  _profileController.progressState.value))),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: _profileController.imageUrl.value == ""
                            ? CircleAvatar(
                                child: ClipOval(
                                  child: SvgPicture.asset(
                                    'assets/icons/avatar.svg',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage: NetworkImage(
                                    _profileController.imageUrl.value),
                              ),
                      ),
                    )),
              UploadProfileImage(),
              Text(
                authenticationController.user.value!.email ?? "",
                style: const TextStyle(fontSize: 20),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
