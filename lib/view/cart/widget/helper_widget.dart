import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../config/colors.dart';

InkWell subtractMethod( {required VoidCallback onPress}) {
  return InkWell(
    onTap: onPress,
    child : container(child: Icon(Icons.remove,size: 13,)),
  );
}


InkWell addMethod( { required VoidCallback onPress   }) {
  return InkWell(
    onTap: onPress,
    child: container(child: const Icon(Icons.add,size: 13,)),
  );
}

Container container({required Widget child}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 2),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border:
        Border.all(width: 1.4,color: AppColors.addMark)),
    child:  Center(child: child),
  );
}

