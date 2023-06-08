import 'package:chatting_app/common/widgets/elevated_button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "asdasd",
              // 'Welcome ${FirebaseAuth.instance.currentUser!.displayName!.split(' ').first}',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButtonWidget(
                onPress: () {
                  controller.logoutUser();
                },
                title: "Logout"),
          ],
        ),
      ),
    );
  }
}
