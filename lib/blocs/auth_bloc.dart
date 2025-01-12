import 'dart:async';

import 'package:coffee_app_bloc/config/app_url.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repostory/authRepo/auth_http_api_repository.dart';

abstract class AuthEvent {}

class LoginRequest extends AuthEvent {
  final Map data;


  LoginRequest({ required this.data});
}
class AdminLoginRequest extends AuthEvent {
  final Map data;


  AdminLoginRequest({ required this.data});
}

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  dynamic response;

  AuthSuccess({this.response});
}

class AuthFailure extends AuthState {
  dynamic error;

  AuthFailure(this.error);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthHttpApiRepository login;

  AuthBloc(this.login) : super(AuthInitialState()) {

    on<LoginRequest>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await login.login(event.data, AppUrl.login);

        emit(AuthSuccess(response: response));
      } catch (error) {
        emit(AuthFailure(error));
      }
    });


    on<AdminLoginRequest>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await login.adminlogin(event.data, AppUrl.adminLogin);

        emit(AuthSuccess(response: response));
      } catch (error) {
        emit(AuthFailure(error));
      }
    });
  }


}
