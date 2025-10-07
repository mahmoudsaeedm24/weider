part of 'add_new_user_cubit.dart';

sealed class AddEditUserState {}

final class AddEditUserInitial extends AddEditUserState {}

final class AddEditUserLoading extends AddEditUserState {}

final class AddEditUserSuccess extends AddEditUserState {}

final class AddEditUserFailed extends AddEditUserState {}
