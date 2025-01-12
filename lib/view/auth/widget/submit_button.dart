import 'package:coffee_app_bloc/config/colors.dart';
import 'package:coffee_app_bloc/config/routes/routes_name.dart';
import 'package:coffee_app_bloc/viewModel/auth_view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/auth_bloc.dart';
import '../../../config/components/button/submit_button.dart';
import '../../../config/utils/sharePreferance/share_pref.dart';
import '../../admin/upload_item.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          if(state.response != null){
            authManager.saveData("token", state.response["data"]["token"]);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamed(context, AppRoutesName.bottomBar);
            });
          }

        }

        return SubmitButton(
          isLoading: state is AuthLoading ,
          label: 'Submit',
          onPress: () async {
            final authBloc = context.read<AuthBloc>();
            LoginViewModel loginViewModel = LoginViewModel(authBloc);
            loginViewModel.login(emailController.text.toString(),
                passwordController.text.toString());
          },
        );
      },
    );
  }
}


class AdminLoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const AdminLoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          if(state.response != null){
            authManager.saveData("isAdmin", true);
            authManager.saveData("tokenAdmin", state.response["data"]["token"]);
            WidgetsBinding.instance.addPostFrameCallback((_) {

             Navigator.of(context).push(MaterialPageRoute(builder: (_)=>UploadItemScreen()));
            });
          }

        }

        return SubmitButton(
          isLoading: state is AuthLoading ,
          label: 'Admin Login',
          onPress: () async {
            authManager.saveData("isAdmin", false);
            final authBloc = context.read<AuthBloc>();
            LoginViewModel loginViewModel = LoginViewModel(authBloc);
            loginViewModel.adminLogin(emailController.text.toString(),
                passwordController.text.toString());
          },
        );
      },
    );
  }
}
