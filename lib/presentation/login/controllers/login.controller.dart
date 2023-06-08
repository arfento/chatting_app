import 'package:chatting_app/common/common.dart';
import 'package:chatting_app/infrastructure/dal/services/auth_social_services.dart';
import 'package:chatting_app/infrastructure/navigation/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool obsecurePassword = true.obs;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  AuthSocialServices authSocialServices = AuthSocialServices();

  Future<void> loginUser() async {
    if (emailCtrl.text.trim().isEmpty) {
      showToast(context: Get.context!, message: "Please Enter your email");
    }
    if (!emailCtrl.text.trim().isEmail) {
      showToast(context: Get.context!, message: "Please Enter valid email");
    }
    if (passwordCtrl.text.trim().isEmpty) {
      showToast(context: Get.context!, message: "Please Enter your password");
    }

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailCtrl.text.trim(), password: passwordCtrl.text.trim())
          .catchError((err) {
        Get.back();
        Get.snackbar("Error", err.toString());
      });
      if (credential.user != null) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar("Error", "Email belum terdaftar");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast(
            context: Get.context!, message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showToast(
            context: Get.context!,
            message: 'Wrong password provided for that user.');
      } else {
        showToast(
            context: Get.context!, message: "Error : ${e.message.toString()}");
      }
    } catch (e) {
      showToast(context: Get.context!, message: "Something went wrong");
    }
  }

  handleGoogleLogin() async {
    authSocialServices.signInWithGoogle();
  }
}
