abstract class BasketEvent {}

class BasketFetchHiveEvent extends BasketEvent {}

class BasketPaymentInitEvent extends BasketEvent {}

class BasketPaymentRequestEvent extends BasketEvent {}

class BaskketRemoveProductEvent extends BasketEvent {
  int index;
  BaskketRemoveProductEvent(this.index);
}
