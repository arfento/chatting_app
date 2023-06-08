import 'package:chatting_app/common/common.dart';
import 'package:chatting_app/infrastructure/navigation/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  RxBool obsecurePassword = true.obs;
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  Future<void> registerUser() async {
    if (nameCtrl.text.trim().isEmpty) {
      showToast(context: Get.context!, message: "Please Enter your name");
      return;
    }
    if (emailCtrl.text.trim().isEmpty) {
      showToast(context: Get.context!, message: "Please Enter your email");
      return;
    }
    if (!emailCtrl.text.trim().isEmail) {
      showToast(context: Get.context!, message: "Please Enter valid email");
      return;
    }
    if (passwordCtrl.text.trim().isEmpty) {
      showToast(context: Get.context!, message: "Please Enter your password");
      return;
    }
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailCtrl.text.trim(),
        password: passwordCtrl.text.trim(),
      );

      if (credential.user != null) {
        FirebaseAuth.instance.currentUser!
            .updateDisplayName(nameCtrl.text.trim());
        addUser(
          uid: FirebaseAuth.instance.currentUser!.uid,
          name: nameCtrl.text.trim(),
          email: emailCtrl.text.trim(),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast(
            context: Get.context!,
            message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showToast(
            context: Get.context!,
            message: 'The account already exists for that email.');
      } else {
        showToast(context: Get.context!, message: e.message!);
      }
    } catch (e) {
      showToast(context: Get.context!, message: "Something went wrong");
    }
  }

  Future<void> addUser({
    required String uid,
    required String name,
    required String email,
  }) async {
    var path = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    try {
      await path.set({"uid": uid, "name": name, "email": email});
      showToast(context: Get.context!, message: "User updated");
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      showToast(context: Get.context!, message: "Something went wrong!");
    }
  }
}
