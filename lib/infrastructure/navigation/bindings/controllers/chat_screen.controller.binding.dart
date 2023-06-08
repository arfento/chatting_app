import 'package:get/get.dart';

import '../../../../presentation/chat_screen/controllers/chat_screen.controller.dart';

class ChatScreenControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatScreenController>(
      () => ChatScreenController(),
    );
  }
}
