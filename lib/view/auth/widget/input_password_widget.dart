import 'package:coffee_app_bloc/config/colors.dart';
import 'package:flutter/material.dart';

class InputPasswordWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;

  const InputPasswordWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      obscuringCharacter: "*",
      obscureText: true,
      decoration: InputDecoration(
          hintText: "Please Enter The Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        label: Text(
          label,
          style: TextStyle(
              color: AppColors.submitColor,
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ),
        fillColor: Colors.grey[200],
        filled: true,

      ),
    );
  }
}
