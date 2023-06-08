import 'package:chatting_app/domain/core/interfaces/auth_social_interface.dart';
import 'package:chatting_app/infrastructure/navigation/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthSocialServices implements AuthSocialInterface {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  void signInWithApple() {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  void signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  void signInWithGoogle() async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    _firebaseAuth
        .signInWithProvider(GoogleAuthProvider())
        .catchError((onError) {
      Get.back();
      Get.snackbar("Error", onError.toString());
    }).then((value) {
      Get.back();
      Get.offAllNamed(Routes.HOME);
    });

    // return userAuth.user!;
  }
}
