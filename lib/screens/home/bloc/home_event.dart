part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeStarted extends HomeEvent {}

class AddUserButtonClicked extends HomeEvent {
  final Users user;
  AddUserButtonClicked(this.user);
}
