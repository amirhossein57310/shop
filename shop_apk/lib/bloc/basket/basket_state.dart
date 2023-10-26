import 'package:dartz/dartz.dart';
import 'package:shop_apk/data/model/basket_item.dart';

abstract class BasketState {}

class BasketIniitState extends BasketState {}

class BasketFetchedDataState extends BasketState {
  Either<String, List<BasketItem>> getAllBasketItem;
  int getTotalPrice;

  BasketFetchedDataState(this.getAllBasketItem, this.getTotalPrice);
}
