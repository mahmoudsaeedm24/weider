import 'package:hive_flutter/hive_flutter.dart';
import 'package:weider/features/user/data/models/user_model/user_model.dart';

class UserDataSource {
  final Box<UserModel> _box;

  UserDataSource({required Box<UserModel> box}) : _box = box;

  Future<void> storeUser({required UserModel newUser}) async {
    await _box.put(newUser.id, newUser);
  }

  List<UserModel> getUsers() {
    return _box.values.toList();
  }

  List<UserModel> filterUsers({required String userName}) {
    return _box.values.where((user) => user.name.contains(userName)).toList();
  }

  Future removeUser({required UserModel user}) async {
    await _box.delete(user.id);
  }
}
