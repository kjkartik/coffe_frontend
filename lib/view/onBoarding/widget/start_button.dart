import 'package:coffee_app_bloc/config/components/button/submit_button.dart';
import 'package:coffee_app_bloc/config/routes/routes_name.dart';
import 'package:flutter/material.dart';

import '../../bottombar/bottom_bar.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SubmitButton(label: "Next", onPress: (){
     Navigator.pushNamed(context, AppRoutesName.login);
    });
  }
}
