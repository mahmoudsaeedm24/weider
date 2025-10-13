import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weider/features/user/data/repos/user_repo.dart';

import '../../../data/models/users_state/user_state_model.dart';

part 'get_all_users_state.dart';

class GetUsersCubit extends Cubit<GetUsersState> {
  final UserRepo _repo;

  GetUsersCubit({required UserRepo repo})
    : _repo = repo,
      super(GetUsersInitial());

  void getUsers({String? userName}) {
    try {
      emit(GetUsersLoading());
     final UserStateModel  allUsers =  userName != null ? _repo.filterUsers(userName: userName) :
      _repo.getUsers();
      emit(GetUsersSuccess(users: allUsers));
    } catch (e) {
      emit(GetUsersFailed());
    }
  }
}
