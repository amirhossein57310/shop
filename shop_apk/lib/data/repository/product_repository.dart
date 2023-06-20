import 'package:dartz/dartz.dart';
import 'package:shop_apk/data/datasource/product_datasource.dart';
import 'package:shop_apk/data/model/product.dart';

import 'package:shop_apk/util/api_exception.dart';
import 'dart:async';

abstract class IProductRepository {
  FutureOr<Either<String, List<Product>>> getProducts();
  FutureOr<Either<String, List<Product>>> getHotest();
  FutureOr<Either<String, List<Product>>> getBestSeller();
}

class ProductRepositories extends IProductRepository {
  final IProductDatasource _repository;
  ProductRepositories(this._repository);
  @override
  FutureOr<Either<String, List<Product>>> getProducts() async {
    try {
      var response = await _repository.getProducts();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  FutureOr<Either<String, List<Product>>> getBestSeller() async {
    try {
      var response = await _repository.getBestSeller();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  FutureOr<Either<String, List<Product>>> getHotest() async {
    try {
      var response = await _repository.getHotest();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }
}
