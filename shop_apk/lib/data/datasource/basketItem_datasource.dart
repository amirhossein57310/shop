import 'package:hive_flutter/adapters.dart';
import 'package:shop_apk/data/model/basket_item.dart';
import 'dart:async';

abstract class IproductBasketDateSource {
  FutureOr<void> addToBasket(BasketItem basketItem);
  FutureOr<List<BasketItem>> getAllBasketList();

  FutureOr<int> getTotalPrice();

  Future<void> removeProduct(int index);
}

class ProductBasketLocalDatasource extends IproductBasketDateSource {
  var box = Hive.box<BasketItem>('basketItem');
  @override
  FutureOr<void> addToBasket(BasketItem basketItem) async {
    box.add(basketItem);
  }

  @override
  FutureOr<List<BasketItem>> getAllBasketList() async {
    return box.values.toList();
  }

  @override
  FutureOr<int> getTotalPrice() async {
    var basketItemList = box.values.toList();
    var totalPriceAmount = basketItemList.fold<int>(
        0, (accumulator, product) => accumulator + product.realPrice!);
    return totalPriceAmount;
  }

  @override
  Future<void> removeProduct(int index) async {
    box.deleteAt(index);
  }
}
