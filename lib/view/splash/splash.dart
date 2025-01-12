import 'package:coffee_app_bloc/config/colors.dart';
import 'package:coffee_app_bloc/config/routes/app_routes.dart';
import 'package:coffee_app_bloc/config/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/components/button/submit_button.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);


    Future.microtask(() async {
    await  Future.delayed(Duration(seconds: 3));
      Navigator.pushNamed(context, AppRoutesName.onBoarding);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Image.asset(
        "assets/splash/splash.png",
        fit: BoxFit.fill,
        height: height,
      ),

    );
  }
}
