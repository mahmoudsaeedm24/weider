import 'package:weider/features/user/data/data_sources/user_data_source.dart';

import '../models/user_model.dart';

class UserRepo {
  final UserDataSource _local;

  UserRepo({required UserDataSource local}) : _local = local;

  Future<void> storeUser({required UserModel newUser}) async {
    _local.storeUser(newUser: newUser);
  }

  List<UserModel> getUsers() {
    final allUsers = _local.getUsers();

    allUsers.sort((a, b) => a.endDate.compareTo(b.endDate));
    return allUsers;
  }

  List<UserModel> filterUsers({required String userName}) {
    final allUsers = _local.filterUsers(userName: userName);

    allUsers.sort((a, b) => a.endDate.compareTo(b.endDate));
    return allUsers;
  }

  Future removeUser({required UserModel user}) async {
    await _local.removeUser(user: user);
  }
}
