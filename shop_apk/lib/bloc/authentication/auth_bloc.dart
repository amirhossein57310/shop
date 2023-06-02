import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_apk/bloc/authentication/auth_event.dart';
import 'package:shop_apk/bloc/authentication/auth_state.dart';
import 'package:shop_apk/data/datasource/authentication_datasource.dart';
import 'package:shop_apk/data/repository/authetication_repository.dart';
import 'package:shop_apk/di/di.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final IAuthenticationRepositories _repository = locator.get();
//   AuthBloc() : super(AuthInitState()) {
//     on<AuthLoginRequest>((event, emit) async {
//       emit(AuthLoadingState());
//       var response = await _repository.login(event.username, event.password);
//       emit(AuthResponseState(response));
//     });
//   }
// }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthenticationRepositories _repository = locator.get();
  AuthBloc() : super(AuthInitState()) {
    on<AuthLoginRequest>((event, emit) async {
      emit(AuthLoadingState());
      var response = await _repository.login(event.username, event.password);
      emit(AuthResponseState(response));
    });
  }
}
