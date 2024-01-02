import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/authentification_controller.dart';
import 'package:todo/controllers/profile_controller.dart';
import 'package:todo/screen/login_screen.dart';
import 'package:todo/screen/profle.dart';
import 'package:todo/screen/todo_scren.dart';

class DrawerController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void onItemTapped(int index) => selectedIndex.value = index;
}

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  static final AuthenticationController authenticationController =
      Get.put(AuthenticationController());
  final DrawerController drawerController = Get.put(DrawerController());

  static final List<MenuItem> other = [
    MenuItem("/TodoList", 'Mes Tâche', () => Get.to(() => TodoList())),
  ];
  final List<MenuItem> drawerItemGeust = [
    other[0],
    MenuItem("/LoginScreen", 'Se connecter', () {
      Get.to(() => const LoginScreen());
    }),
  ];
  final List<MenuItem> drawerItemAuth = [
    other[0],
    MenuItem("/ProfleScreen", 'Profile', () => Get.to(() => ProfleScreen())),
    MenuItem("/SignOut", 'Se déconnecter',
        () => authenticationController.signOutUser()),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Obx(() => DrawerListItem(
              drawerItem: authenticationController.user.value != null
                  ? drawerItemAuth
                  : drawerItemGeust,
            )));
  }
}

class DrawerListItem extends StatelessWidget {
  final List<MenuItem> drawerItem;
  final DrawerController drawerController = Get.put(DrawerController());
  final ProfileController _profileController = Get.put(ProfileController());

  DrawerListItem({super.key, required this.drawerItem});

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
                width: 150,
                height: 150,
                child: Obx(
                  () => _profileController.imageUrl.value == ""
                      ? CircleAvatar(
                          child: ClipOval(
                            child: SvgPicture.asset(
                              'assets/icons/avatar.svg',
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        )
                      : CircleAvatar(
                          backgroundImage:
                              NetworkImage(_profileController.imageUrl.value),
                        ),
                )),
          )),
        ),
        for (int i = 0; i < drawerItem.length; i++)
          DrawerItem(
            isSelected: Get.currentRoute == drawerItem[i].id,
            onTap: () {
              drawerItem[i].action();
            },
            title: drawerItem[i].text,
          ),
      ],
    );
  }
}

class DrawerItem extends StatelessWidget {
  final bool isSelected;
  final String title;
  final Function onTap;
  const DrawerItem(
      {super.key,
      required this.isSelected,
      required this.onTap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: isSelected ? Colors.blue : null,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Theme.of(context).primaryColor,
          ),
        ),
        selected: isSelected,
        onTap: () => onTap(),
      ),
    );
  }
}

class MenuItem {
  final String id;
  final String text;
  final Function action;

  MenuItem(this.id, this.text, this.action);
}
