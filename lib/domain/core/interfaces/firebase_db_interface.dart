import 'package:chatting_app/domain/models/user_model.dart';

abstract class FirebaseDbInterface {
  addUser(UsersModel usersModel);
  updateUser(UsersModel usersModel);
  Future<void> deleteUser(String documentId);
  Future<List<UsersModel>> retrieveUsers();
}
