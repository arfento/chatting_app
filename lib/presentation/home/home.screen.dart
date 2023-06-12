import 'package:chatting_app/presentation/screens.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "asdasd",
          ),
          // 'Welcome ${FirebaseAuth.instance.currentUser!.displayName!.split(' ').first == null ? "" : FirebaseAuth.instance.currentUser!.displayName!.split(' ').first}'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  controller.logoutUser();
                },
                icon: const Icon(Icons.power_settings_new_outlined))
          ],
        ),
        body: const UsersScreenScreen());
  }
}
