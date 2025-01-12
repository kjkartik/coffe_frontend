import 'dart:async';

import 'package:coffee_app_bloc/blocs/auth_bloc.dart';

class LoginViewModel {
  final AuthBloc authBloc;

  LoginViewModel(this.authBloc);

  Future<dynamic> login(String email, String password) async {
    authBloc.add(LoginRequest(data: {"id": email, "password": password}));

  }

  Future<dynamic> adminLogin(String email, String password) async {
    authBloc.add(AdminLoginRequest(data: {"id": email, "password": password}));
  }
}
