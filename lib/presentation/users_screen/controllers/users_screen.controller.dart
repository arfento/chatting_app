import 'package:chatting_app/domain/models/user_model.dart';
import 'package:chatting_app/infrastructure/dal/services/firebase_db_mange.dart';
import 'package:chatting_app/presentation/message_screen/message_screen.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UsersScreenController extends GetxController with FirebaseUserMange {
  var data = <UsersModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<List<UsersModel>> getAllUsers() async {
    List<UsersModel> userData = await retrieveUsers();
    data.clear();
    for (var element in userData) {
      if (element.uid != FirebaseAuth.instance.currentUser!.uid) {
        data.value.add(element);
      }
    }
    return data.value;
  }

  void startChat({required UsersModel user}) {
    Get.to(() => MessageScreenScreen(user: user));
  }
}
