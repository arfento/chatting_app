import 'package:chatting_app/common/common.dart';
import 'package:chatting_app/common/utils/app_font.dart';
import 'package:chatting_app/common/utils/img_string.dart';
import 'package:chatting_app/common/widgets/elevated_button_widget.dart';
import 'package:chatting_app/common/widgets/text_field_widget.dart';
import 'package:chatting_app/infrastructure/navigation/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import 'controllers/login.controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Chat App',
                style: Theme.of(context).textTheme.headline2,
              ),
              spaceVertical(20),
              TextFieldWidget(
                textEditingController: controller.emailCtrl,
                hintText: "Email",
                prefixIcon: const Icon(Icons.mail),
              ),
              spaceVertical(20),
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
                    controller.loginUser();
                  },
                  title: "Login"),
              spaceVertical(20),
              RichText(
                text: TextSpan(
                  text: "Dont have an account?",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  children: [
                    TextSpan(
                        text: " Sign up",
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 18),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(Routes.REGISTER);
                          }),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    "Or Login with",
                    style: AppFont.input.copyWith(fontSize: 18),
                  ),
                  spaceVertical(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: controller.handleGoogleLogin,
                          child: SvgPicture.asset(ImgString.googleLogo,
                              width: 40, height: 40)),
                      spaceHorizontal(32),
                      // 37.widthBox,
                      GestureDetector(
                          onTap: () {},
                          // onTap: controller.handleAppleLogin,
                          child: SvgPicture.asset(ImgString.appleLogo,
                              width: 40, height: 40)),
                      spaceHorizontal(32),
                      GestureDetector(
                        onTap: () {},
                        // onTap: controller.handleFacebookLogin,
                        child: SvgPicture.asset(ImgString.facebookLogo,
                            width: 40, height: 40),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
