import 'package:coffee_app_bloc/config/colors.dart';
import 'package:coffee_app_bloc/config/images.dart';
import 'package:coffee_app_bloc/view/auth/widget/submit_button.dart';
import 'package:flutter/material.dart';
import '../../config/components/button/submit_button.dart';
import '../../config/routes/routes_name.dart';
import 'widget/input_email_widget.dart';
import 'widget/input_password_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController =
      TextEditingController(text: "Kartik@gmail.com");

  TextEditingController passwordController =
      TextEditingController(text: "Kartik@123");

  var emailFocus = FocusNode();

  var passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.planeimageLogin),
                  fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 21,
                    ),
                    SizedBox(
                      height: height / 11,
                    ),
                    Center(
                      child: Text(
                        "Find The best \nCoffee to your taste",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white),
                      ),
                    ),
                    SizedBox(
                      height: height / 11,
                    ),
                    Text(
                      "Login ✌✌",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white),
                    ),
                    SizedBox(
                      height: height / 31,
                    ),
                    InputEmailWidget(
                      label: "Email",
                      controller: emailController,
                      focusNode: emailFocus,
                    ),
                    SizedBox(
                      height: height / 31,
                    ),
                    InputPasswordWidget(
                        label: "Password",
                        controller: passwordController,
                        focusNode: passwordFocus),
                    SizedBox(
                      height: height / 31,
                    ),
                    Center(
                      child: LoginButton(
                        emailController: emailController,
                        passwordController: passwordController,
                      ),
                    ),
                    SizedBox(
                      height: height / 31,
                    ),

                    // SubmitButton(label: 'Admin', onPress: () {
                    //   Navigator.pushNamed(context, AppRoutesName.adminLogin);
                    // },)


                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
