part of 'get_all_users_cubit.dart';

sealed class GetUsersState {}

final class GetUsersInitial extends GetUsersState {}

final class GetUsersLoading extends GetUsersState {}

final class GetUsersSuccess extends GetUsersState {
  final List<UserModel> users;

  GetUsersSuccess({required this.users});
}

final class GetUsersFailed extends GetUsersState {}
