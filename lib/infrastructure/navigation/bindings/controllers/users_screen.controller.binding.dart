import 'package:get/get.dart';

import '../../../../presentation/users_screen/controllers/users_screen.controller.dart';

class UsersScreenControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UsersScreenController>(
      () => UsersScreenController(),
    );
  }
}
