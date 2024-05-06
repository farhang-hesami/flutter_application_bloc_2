part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

final class HomeInitial extends HomeState {}

class GetUsersSuccess extends HomeState {
  final List<Users> users;
  GetUsersSuccess(this.users);
}

class GetUsersError extends HomeState {
  final String error;
  GetUsersError(this.error);
}

class GetUsersLoading extends HomeState {}

//////////////////////////////
class AddUserSuccess extends HomeState {
  final Users user;
  AddUserSuccess(this.user);
}

class AddUserError extends HomeState {
  final String error;
  AddUserError(this.error);
}

class AddUserLoading extends HomeState {}
