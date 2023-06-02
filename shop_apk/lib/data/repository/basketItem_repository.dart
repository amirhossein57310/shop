import 'package:dartz/dartz.dart';
import 'package:shop_apk/data/datasource/basketItem_datasource.dart';
import 'package:shop_apk/di/di.dart';

import '../model/basket_item.dart';

abstract class IproductBasketRepository {
  Future<Either<String, String>> addToBasket(BasketItem basketItem);
  Future<Either<String, List<BasketItem>>> getAllBasketList();
  Future<double> getTotalPrice();
}

class ProductBasketRepository extends IproductBasketRepository {
  final IproductBasketDateSource datasource = locator.get();
  @override
  Future<Either<String, String>> addToBasket(BasketItem basketItem) async {
    try {
      datasource.addToBasket(basketItem);
      return right('محصول شما به سبد خرید اضافه شد');
    } catch (e) {
      return left('افزودن محصول با خطا مواجه شد');
    }
  }

  @override
  Future<Either<String, List<BasketItem>>> getAllBasketList() async {
    try {
      var basketItemList = await datasource.getAllBasketList();
      return right(basketItemList);
    } catch (e) {
      return left('افزودن محصول با خطا مواجه شد');
    }
  }

  @override
  Future<double> getTotalPrice() async {
    return datasource.getTotalPrice();
  }
}
