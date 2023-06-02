import 'package:dartz/dartz.dart';
import 'package:shop_apk/data/model/product.dart';
import 'package:shop_apk/data/model/product_category.dart';

abstract class ProductCategoryState {}

class InitProductCategoryState extends ProductCategoryState {}

class LoadingProductCategoryState extends ProductCategoryState {}

class ResponseProductCategoryState extends ProductCategoryState {
  Either<String, List<Product>> productList;

  ResponseProductCategoryState(this.productList);
}
