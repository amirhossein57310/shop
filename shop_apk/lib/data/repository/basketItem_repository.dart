import 'package:dartz/dartz.dart';
import 'package:shop_apk/data/datasource/basketItem_datasource.dart';

import '../model/basket_item.dart';
import 'dart:async';

abstract class IproductBasketRepository {
  FutureOr<Either<String, String>> addToBasket(BasketItem basketItem);
  FutureOr<Either<String, List<BasketItem>>> getAllBasketList();
  FutureOr<double> getTotalPrice();
}

class ProductBasketRepository extends IproductBasketRepository {
  final IproductBasketDateSource datasource;
  ProductBasketRepository(this.datasource);

  @override
  FutureOr<Either<String, String>> addToBasket(BasketItem basketItem) async {
    try {
      datasource.addToBasket(basketItem);
      return right('محصول شما به سبد خرید اضافه شد');
    } catch (e) {
      return left('افزودن محصول با خطا مواجه شد');
    }
  }

  @override
  FutureOr<Either<String, List<BasketItem>>> getAllBasketList() async {
    try {
      var basketItemList = await datasource.getAllBasketList();
      return right(basketItemList);
    } catch (e) {
      return left('افزودن محصول با خطا مواجه شد');
    }
  }

  @override
  FutureOr<double> getTotalPrice() async {
    return datasource.getTotalPrice();
  }
}
