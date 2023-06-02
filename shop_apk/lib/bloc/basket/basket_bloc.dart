import 'package:bloc/bloc.dart';

import '../../data/repository/basketItem_repository.dart';
import '../../di/di.dart';
import 'basket_event.dart';
import 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IproductBasketRepository _basketRepository = locator.get();
  BasketBloc() : super(BasketIniitState()) {
    on<BasketFetchHiveEvent>((event, emit) async {
      var basketItemList = await _basketRepository.getAllBasketList();
      var totalPrice = await _basketRepository.getTotalPrice();
      emit(BasketFetchedDataState(basketItemList, totalPrice));
    });
  }
}
