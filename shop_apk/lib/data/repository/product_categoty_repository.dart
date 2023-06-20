import 'package:dartz/dartz.dart';
import 'package:shop_apk/data/datasource/product_category_datasource.dart';
import 'package:shop_apk/data/model/product.dart';

import 'package:shop_apk/util/api_exception.dart';
import 'dart:async';

abstract class IproductCategoryRepository {
  FutureOr<Either<String, List<Product>>> getProductCategory(String category);
}

class ProductCategoryRepository extends IproductCategoryRepository {
  final IproductCategoryRemote _repository;
  ProductCategoryRepository(this._repository);

  @override
  FutureOr<Either<String, List<Product>>> getProductCategory(
      String category) async {
    try {
      var response = await _repository.getProductCategory(category);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }
}
