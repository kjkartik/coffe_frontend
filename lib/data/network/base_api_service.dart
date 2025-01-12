abstract  class BaseApiService{
  Future<dynamic> getApiService(dynamic url);
  Future<dynamic> postApiService(dynamic url, Map<dynamic, dynamic> data);
}
