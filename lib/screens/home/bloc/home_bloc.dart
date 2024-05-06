import 'package:bloc/bloc.dart';
import 'package:flutter_application_bloc_2/data/api_service.dart';
import 'package:flutter_application_bloc_2/models/users.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    ApiServise apiServise = ApiServise();

    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted) {
        emit(GetUsersLoading());

        try {
          var response = await apiServise.getusers();
          emit(GetUsersSuccess(response));
        } catch (e) {
          emit(GetUsersError('Error...!'));
        }
      }
      if (event is AddUserButtonClicked) {
        emit(AddUserLoading());
        try {
          var response = await apiServise.addUser(event.user);
          emit(AddUserSuccess(response));
        } catch (e) {
          emit(AddUserError('Error...!'));
        }
      }
    });
  }
}
