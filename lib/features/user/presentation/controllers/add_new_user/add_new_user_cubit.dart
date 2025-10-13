import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weider/features/user/data/repos/user_repo.dart';

import '../../../data/models/user_model/user_model.dart';

part 'add_new_user_state.dart';

class AddEditUserCubit extends Cubit<AddEditUserState> {
  AddEditUserCubit(this._repo) : super(AddEditUserInitial());

  final UserRepo _repo;

  Future<void> addEditUser({required UserModel newUser}) async {
    emit(AddEditUserLoading());
    try {
      await _repo.storeUser(newUser: newUser);
      emit(AddEditUserSuccess());
    } catch (e) {
      emit(AddEditUserFailed());
    }
  }
}
