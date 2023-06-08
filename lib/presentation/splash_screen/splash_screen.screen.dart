import 'package:chatting_app/infrastructure/navigation/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SplashScreenScreen extends StatefulWidget {
  const SplashScreenScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreenScreen> createState() => _SplashScreenScreenState();
}

class _SplashScreenScreenState extends State<SplashScreenScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      print("user : ${user}");
      if (user != null) {
        Get.offNamed(Routes.HOME);
        return;
      }
      Get.offNamed(Routes.LOGIN);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Chat App",
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}
