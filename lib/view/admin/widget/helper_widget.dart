import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/colors.dart';

Widget buildTextField({
  required String label,
  required TextEditingController controller,
  required String hintText,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      SizedBox(height: 8),
      TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(11),borderSide: BorderSide(color: AppColors.submitColor)),
          disabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(11),borderSide: BorderSide(color: AppColors.submitColor)),

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(11),borderSide: BorderSide(color: AppColors.submitColor)),
        ),
        keyboardType: keyboardType,
      ),
      SizedBox(height: 20),
    ],
  );
}