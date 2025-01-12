

import '../../data/network/base_api_service.dart';
import '../../data/network/network_api_service.dart';
import 'item_repo.dart';

class GetItemHttpApiRepository extends ItemRepo{
  final BaseApiService baseApiService = NetworkApiService();
  @override
  Future<void> getItems(url) async {
    var jsonReturn = await baseApiService.getApiService(url);
    return jsonReturn;
  }
}