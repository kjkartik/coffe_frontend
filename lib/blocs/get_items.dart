import 'package:coffee_app_bloc/config/app_url.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../repostory/getItem/item_repo.dart';

// Events
abstract class ItemEvent {}

class GetItemsRequestEvent extends ItemEvent {}
class GetAdminItemsRequestEvent extends ItemEvent {}

// States
abstract class ItemState {}

class ItemInitialState extends ItemState {}

class ItemLoadingState extends ItemState {}

class ItemSuccessState extends ItemState {
  final dynamic response;

  ItemSuccessState({required this.response});
}

class ItemFailureState extends ItemState {
  final String error;

  ItemFailureState({required this.error});
}

// Bloc
class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRepo itemRepo;

  ItemBloc(this.itemRepo) : super(ItemInitialState()) {
    on<GetItemsRequestEvent>(_onGetItemsRequest);
    on<GetAdminItemsRequestEvent>(_onGetAdminItemsRequestEvent);
  }

  Future<void> _onGetItemsRequest(GetItemsRequestEvent event, Emitter<ItemState> emit) async {
    emit(ItemLoadingState());
    try {
      final response = await itemRepo.getItems(AppUrl.getItem);
      emit(ItemSuccessState(response: response));
    } catch (e) {
      emit(ItemFailureState(error: e.toString()));
    }
  }

  Future<void> _onGetAdminItemsRequestEvent(GetAdminItemsRequestEvent event, Emitter<ItemState> emit) async {
    emit(ItemLoadingState());
    try {
      final response = await itemRepo.getItems(AppUrl.getAdminItem);
      emit(ItemSuccessState(response: response));
    } catch (e) {
      emit(ItemFailureState(error: e.toString()));
    }
  }

}

