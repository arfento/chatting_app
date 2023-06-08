import 'package:chatting_app/common/common.dart';
import 'package:chatting_app/common/widgets/elevated_button_widget.dart';
import 'package:chatting_app/common/widgets/text_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/register.controller.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Chat App',
                  style: Theme.of(context).textTheme.headline2,
                ),
                spaceVertical(20),
                TextFieldWidget(
                  textEditingController: controller.nameCtrl,
                  hintText: "Name",
                  prefixIcon: const Icon(Icons.person),
                ),
                spaceVertical(10),
                TextFieldWidget(
                  textEditingController: controller.emailCtrl,
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.mail),
                ),
                spaceVertical(10),
                Obx(() {
                  return TextFieldWidget(
                    textEditingController: controller.passwordCtrl,
                    hintText: "Password",
                    obscureText: controller.obsecurePassword.value,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.obsecurePassword.value =
                              !controller.obsecurePassword.value;
                        },
                        icon: Icon(
                          controller.obsecurePassword.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        )),
                  );
                }),
                spaceVertical(10),
                ElevatedButtonWidget(
                  onPress: () {
                    controller.registerUser();
                  },
                  title: "Sign Up",
                ),
                spaceVertical(20),
                RichText(
                  text: TextSpan(
                      text: 'Already have an account?',
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Login',
                            style: const TextStyle(
                                color: Colors.blueAccent, fontSize: 18),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.back();
                                // navigate to desired screen
                              })
                      ]),
                ),
              ]),
        ),
      ),
    );
  }
}
