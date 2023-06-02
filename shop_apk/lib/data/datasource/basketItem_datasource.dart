import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shop_apk/data/model/basket_item.dart';

abstract class IproductBasketDateSource {
  Future<void> addToBasket(BasketItem basketItem);
  Future<List<BasketItem>> getAllBasketList();

  Future<double> getTotalPrice();
}

class productBasketLocalDatasource extends IproductBasketDateSource {
  var box = Hive.box<BasketItem>('basketItem');
  @override
  Future<void> addToBasket(BasketItem basketItem) async {
    box.add(basketItem);
  }

  @override
  Future<List<BasketItem>> getAllBasketList() async {
    return box.values.toList();
  }

  @override
  Future<double> getTotalPrice() async {
    var basketItemList = box.values.toList();
    var totalPriceAmount = basketItemList.fold<double>(
        0, (accumulator, product) => accumulator + product.realPrice!);
    return totalPriceAmount;
  }
}
