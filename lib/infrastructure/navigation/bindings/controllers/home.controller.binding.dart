import 'package:chatting_app/presentation/chat_screen/controllers/chat_screen.controller.dart';
import 'package:chatting_app/presentation/users_screen/controllers/users_screen.controller.dart';
import 'package:get/get.dart';

import '../../../../presentation/home/controllers/home.controller.dart';

class HomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<UsersScreenController>(
      () => UsersScreenController(),
    );

    Get.lazyPut<ChatScreenController>(
      () => ChatScreenController(),
    );
  }
}
