
import 'package:coffee_app_bloc/data/network/base_api_service.dart';
import 'package:coffee_app_bloc/data/network/network_api_service.dart';
import 'package:coffee_app_bloc/repostory/authRepo/auth_repo.dart';

class AuthHttpApiRepository extends AuthRepo{
  final BaseApiService baseApiService = NetworkApiService();

  AuthHttpApiRepository();

  @override
  Future<dynamic> login(data,url) async {

    var jsonReturn = await baseApiService.postApiService(url, data);

    return jsonReturn;

  }

  Future<dynamic> adminlogin(data,url) async {

    var jsonReturn = await baseApiService.postApiService(url, data);

    return jsonReturn;

  }

  @override
  Future<dynamic> register(Map data, url) {
    // TODO: implement register
    throw UnimplementedError();
  }
}