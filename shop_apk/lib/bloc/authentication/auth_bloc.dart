import 'package:bloc/bloc.dart';

import 'package:shop_apk/bloc/authentication/auth_event.dart';
import 'package:shop_apk/bloc/authentication/auth_state.dart';

import 'package:shop_apk/data/repository/authetication_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthenticationRepositories _repository;
  AuthBloc(this._repository) : super(AuthInitState()) {
    on<AuthLoginRequest>((event, emit) async {
      emit(AuthLoadingState());
      var response = await _repository.login(event.username, event.password);
      emit(AuthResponseState(response));
    });
  }
}
