import 'package:flutter/material.dart';

import '../../../config/colors.dart';

InkWell iconBackground(
    {required BuildContext context,
    required IconData icon,
        Color?  color,
    required VoidCallback onPress}) {
  return InkWell(
    onTap: onPress,
    child: Container(
      height: 35,
      width: 35,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(41)),
      child: Center(
        child: Icon(
          color:color ??null,
          icon,
          size: 19,
        ),
      ),
    ),
  );
}

InkWell widgetCircleBackground(
    {required BuildContext context,
    required Widget child,
      required Color  color,
    required VoidCallback onPress}) {
  return InkWell(
    onTap: onPress,
    child: Container(
      height: 35,
      width: 35,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(41)),
      child: Center(
        child: child,
      ),
    ),
  );
}
