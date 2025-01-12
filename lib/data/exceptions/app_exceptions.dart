import 'dart:async';
import 'dart:io';

import 'package:coffee_app_bloc/config/utils/showMessage/snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../main.dart';



class AppException {
static  dynamic handelException(Object exception,[StackTrace? stackTrace]) {
    if (exception is SocketException) {
      return socketException(exception);
    } else if (exception is FormatException) {
      return formatException(exception);
    } else if (exception is HttpException) {
      return  httpException(exception);
    } else if (exception is TimeoutException) {
      return timerOutException(exception);
    } else if (exception is RangeError) {}else{
      return   apiException(exception);
    }

  }

  static String formatException(FormatException  exception){
    final message = 'FormatException: ${exception.message}';
    _showSnackBar(message);
    return message;
  }

  static String socketException(SocketException exception ){
    final message = "Error With Internet: ${exception.message}";
    _showSnackBar(message);
    return message;

  }
  static String httpException(HttpException exception ){
    final message = "Error With Internet: ${exception.message}";
    _showSnackBar(message);
    return message;

  }

  static String timerOutException(TimeoutException exception){
    final message = "timeOut Error: ${exception.message}";
    _showSnackBar(message);
    return message;
  }

  static String   apiException(exception){
    var message = exception.toString();
    _showSnackBar(message);
    return message;
  }





  static void _showSnackBar(String message) {
    final scaffoldMessenger = scaffoldMessengerKey.currentState;
    if (scaffoldMessenger != null) {

      MessageUtils.error(context: navigatorKey.currentState!.context, message: message);
      // scaffoldMessenger.showSnackBar(
      //   SnackBar(
      //     content: Text(message),
      //     behavior: SnackBarBehavior.floating,
      //     duration: const Duration(seconds: 3),
      //   ),
      // );
    } else {
      if (kDebugMode) {
        print('ScaffoldMessengerState is not ready to show SnackBars');
      }
    }
  }

}

