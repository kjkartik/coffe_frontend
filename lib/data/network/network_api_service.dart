import 'dart:convert';

import 'package:coffee_app_bloc/config/utils/sharePreferance/share_pref.dart';
import 'package:coffee_app_bloc/config/utils/showMessage/snack_bar.dart';
import 'package:coffee_app_bloc/data/exceptions/api_exceptions.dart';
import 'package:coffee_app_bloc/data/exceptions/app_exceptions.dart';
import 'package:coffee_app_bloc/main.dart';
import 'package:http/http.dart' as http;
import 'package:coffee_app_bloc/data/network/base_api_service.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future<dynamic> getApiService(dynamic url) async {
    try {

      var token = authManager.getData("token");
      print("url $url");
      print("token $token");
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token",

      },);
      return returnResponse(response);
    } catch (e,stack) {

      AppException.handelException(e,stack);
    }
  }

  @override
  Future<dynamic> postApiService(dynamic url, Map<dynamic, dynamic> data) async {


 await Future.delayed(Duration(seconds: 3));

 try{

   var token = authManager.getData("token");
   print("url $url");
   print("data $data");
   print("token $token");

   String jsonData = jsonEncode(data);
   var response = await http.post(Uri.parse(url), body: jsonData,  headers: {
     'Content-Type': 'application/json',
     'Authorization': "Bearer $token",

   },);
   if(jsonDecode(response.body)["status"]==1){
     MessageUtils.success(context: navigatorKey.currentState!.context, message:jsonDecode(response.body)["message"] );
   }
   return returnResponse(response);
 }catch(e,stack){
   AppException.handelException(e,stack);
 }

  }
}

dynamic returnResponse(http.Response response) {
  print("Response-> ${response.body}");
  print("Response Status-> ${response.statusCode}");
  switch (response.statusCode) {
    case 200:

      return jsonDecode(response.body);
    case  404:
      throw UserNotFound("");
    case 500:
      throw UnauthorisedException("");
    default:
      throw ErrorInCommunication("Some Thing Went Wrong");
  }
}
