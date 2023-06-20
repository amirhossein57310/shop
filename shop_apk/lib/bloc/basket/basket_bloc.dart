import 'package:bloc/bloc.dart';

import 'package:shop_apk/util/payment_handler.dart';

import '../../data/repository/basketItem_repository.dart';

import 'basket_event.dart';
import 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IproductBasketRepository _basketRepository;
  final PaymentHandler zarinpalPaymentRequestHandler;
  BasketBloc(this.zarinpalPaymentRequestHandler, this._basketRepository)
      : super(BasketIniitState()) {
    on<BasketFetchHiveEvent>((event, emit) async {
      var basketItemList = await _basketRepository.getAllBasketList();
      var totalPrice = await _basketRepository.getTotalPrice();
      emit(BasketFetchedDataState(basketItemList, totalPrice));
    });

    on<BasketPaymentInitEvent>(
      (event, emit) async {
        zarinpalPaymentRequestHandler.initPaymentRequest();
      },
    );

    on<BasketPaymentRequestEvent>(
      (event, emit) async {
        zarinpalPaymentRequestHandler.sendPaymentRequest();
      },
    );
  }
}
