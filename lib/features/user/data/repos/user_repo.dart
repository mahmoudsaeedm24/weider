import 'dart:developer';

import 'package:weider/core/services/notification_prepared.dart';
import 'package:weider/core/utils/rest_days.dart';
import 'package:weider/features/user/data/data_sources/user_data_source.dart';
import 'package:weider/features/user/data/models/users_state/user_state_model.dart';

import '../models/user_model/user_model.dart';

class UserRepo {
  final UserDataSource _local;

  UserRepo({required UserDataSource local}) : _local = local;

  Future<void> storeUser({required UserModel newUser}) async {
    await _local.storeUser(newUser: newUser);
    await NotificationPrepared.showScheduleNotification(user: newUser).then((value) {
      log("Notification scheduled");
    });
  }

  ///* return {activeList, deactiveList}
  UserStateModel getUsers() {
    final allUsers = _local.getUsers();
    return _seperateUsersState(allUsers);
  }

  UserStateModel filterUsers({required String userName}) {
    final allUsers = _local.filterUsers(userName: userName);

    return _seperateUsersState(allUsers);
  }

  Future removeUser({required UserModel user}) async {
    await _local.removeUser(user: user);
  }

  UserStateModel _seperateUsersState(List<UserModel> allUsers) {
    List<UserModel> active = [];
    List<UserModel> deactive = [];

    for (UserModel user in allUsers) {
      if (restDays(user.endDate) > 0) {
        active.add(user);
      } else {
        deactive.add(user);
      }
    }
    active.sort((a, b) {
      return a.endDate.compareTo(b.endDate);
    });
    return UserStateModel(active: active, deactive: deactive);
  }
}
