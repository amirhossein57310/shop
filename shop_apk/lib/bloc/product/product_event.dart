import 'package:shop_apk/data/model/product.dart';

abstract class ProductEvent {}

class ProductResponseEvent extends ProductEvent {
  String productId;
  String categoryId;

  ProductResponseEvent(this.productId, this.categoryId);
}

class ProductBasketEvent extends ProductEvent {
  Product product;
  ProductBasketEvent(this.product);
}
