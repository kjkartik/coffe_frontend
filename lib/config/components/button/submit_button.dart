import 'package:coffee_app_bloc/config/colors.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatefulWidget {
  final String label;
  final VoidCallback onPress;
  final bool isLoading;

  const SubmitButton(
      {super.key,
      required this.label,
      required this.onPress,
      this.isLoading = false});

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return InkWell(
   onTap:!widget.isLoading? widget.onPress:(){},
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.submitColor,
              borderRadius: BorderRadius.circular(11)),
          height: height / 17,
          width: width / 1.2,
          child: widget.isLoading
              ?  Center(child: CircularProgressIndicator(color: AppColors.white,strokeWidth: 3,))
              : Center(
                  child: Text(
                  widget.label,
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                )),
        ),
      ),
    );
  }
}
