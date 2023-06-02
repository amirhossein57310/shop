import 'package:dartz/dartz.dart';
import 'package:shop_apk/data/datasource/product_datasource.dart';
import 'package:shop_apk/data/model/product.dart';
import 'package:shop_apk/data/model/product_category.dart';
import 'package:shop_apk/di/di.dart';
import 'package:shop_apk/util/api_exception.dart';

abstract class IProductRepository {
  Future<Either<String, List<Product>>> getProducts();
  Future<Either<String, List<Product>>> getHotest();
  Future<Either<String, List<Product>>> getBestSeller();
}

class ProductRepositories extends IProductRepository {
  final IProductDatasource _repository = locator.get();
  @override
  Future<Either<String, List<Product>>> getProducts() async {
    try {
      var response = await _repository.getProducts();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  Future<Either<String, List<Product>>> getBestSeller() async {
    try {
      var response = await _repository.getBestSeller();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  Future<Either<String, List<Product>>> getHotest() async {
    try {
      var response = await _repository.getHotest();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }
}
