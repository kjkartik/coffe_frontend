

import 'package:coffee_app_bloc/blocs/get_items.dart';

class ItemViewModel {
  final  ItemBloc itemBloc;

  ItemViewModel(this.itemBloc);

  Future<void> getAllItem()async {
    itemBloc.add(GetItemsRequestEvent());

  }
  Future<void> getAllAdminItem()async {
    itemBloc.add(GetAdminItemsRequestEvent());

  }
}