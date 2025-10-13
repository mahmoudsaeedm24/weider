import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weider/features/user/data/repos/user_repo.dart';

import '../../../data/models/user_model/user_model.dart';

part 'remove_user_state.dart';

class RemoveUserCubit extends Cubit<RemoveUserState> {
  final UserRepo _repo;

  RemoveUserCubit({required UserRepo repo})
    : _repo = repo,
      super(RemoveUserInitial());

  Future<void> removeUser({required UserModel user})async {
    emit(RemoveUserLoading());
    try {
     await _repo.removeUser(user: user);
      emit(RemoveUserSuccess());
    } catch (e) {
      emit(RemoveUserFailed());
    }
  }
}
