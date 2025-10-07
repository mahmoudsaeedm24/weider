import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weider/core/utils/hive_prepared.dart';
import 'package:weider/features/user/data/models/user_model.dart';
import 'package:weider/features/user/data/repos/user_repo.dart';
import 'package:weider/features/user/presentation/controllers/add_new_user/add_new_user_cubit.dart';
import 'package:weider/features/user/presentation/controllers/get_all_users/get_all_users_cubit.dart';
import 'package:weider/features/user/presentation/controllers/uesr_image/user_image_cubit.dart';

import '../../features/user/data/data_sources/user_data_source.dart';

GetIt getIt = GetIt.I;

typedef UserBox = Box<UserModel>;

void initDI() {
  _initSources();
  _initDataSources();
  _initCubits();
  _initControllers();
}

void _initSources() {
  UserBox userBox = Hive.box<UserModel>(Boxes.users.name);
  getIt.registerSingleton<UserBox>(userBox);
}

void _initDataSources() {
  getIt.registerLazySingleton<UserDataSource>(
    () => UserDataSource(box: getIt<UserBox>()),
  );
}

void _initCubits() {
  getIt.registerLazySingleton<UserRepo>(
    () => UserRepo(local: getIt<UserDataSource>()),
  );
}

void _initControllers() {
  getIt.registerFactory<UserImageCubit>(() => UserImageCubit());
  getIt.registerFactory<GetUsersCubit>(
    () => GetUsersCubit(repo: getIt<UserRepo>()),
  );
  getIt.registerFactory<AddEditUserCubit>(
    () => AddEditUserCubit(getIt<UserRepo>()),
  );
}
