import 'package:dartz/dartz.dart';
import 'package:shop_apk/data/datasource/product_detail_datasource.dart';
import 'package:shop_apk/data/model/categoty.dart';
import 'package:shop_apk/data/model/product.dart';
import 'package:shop_apk/data/model/product_image.dart';
import 'package:shop_apk/data/model/product_variant.dart';
import 'package:shop_apk/data/model/properties.dart';
import 'package:shop_apk/data/model/variant.dart';
import 'package:shop_apk/data/model/variant_type.dart';
import 'package:shop_apk/di/di.dart';
import 'package:shop_apk/util/api_exception.dart';

abstract class IproductDetailRepository {
  Future<Either<String, List<ProductImage>>> getGallery(String productId);
  Future<Either<String, List<VariantType>>> getVariantType();
  Future<Either<String, List<ProductVariant>>> getProductVariant(
      String productId);
  Future<Either<String, Category>> productCategory(String categoryId);
  Future<Either<String, List<Properties>>> productProperties(String productId);
}

class ProductDetailRepository extends IproductDetailRepository {
  final IproductDetailDatasource _repository = locator.get();
  @override
  Future<Either<String, List<ProductImage>>> getGallery(
      String productId) async {
    try {
      var response = await _repository.getGallery(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  Future<Either<String, List<VariantType>>> getVariantType() async {
    try {
      var response = await _repository.getVariantType();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  Future<Either<String, List<ProductVariant>>> getProductVariant(
      String productId) async {
    try {
      var response = await _repository.getProductVariant(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  Future<Either<String, Category>> productCategory(String categoryId) async {
    try {
      var response = await _repository.productCategory(categoryId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  Future<Either<String, List<Properties>>> productProperties(
      String productId) async {
    try {
      var response = await _repository.productProperties(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }
}
