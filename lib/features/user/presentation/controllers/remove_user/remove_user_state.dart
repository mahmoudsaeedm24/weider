part of 'remove_user_cubit.dart';

sealed class RemoveUserState {}

final class RemoveUserInitial extends RemoveUserState {}
final class RemoveUserLoading extends RemoveUserState {}
final class RemoveUserSuccess extends RemoveUserState {}
final class RemoveUserFailed extends RemoveUserState {}
