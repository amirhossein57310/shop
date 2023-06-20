import 'package:dartz/dartz.dart';
import 'package:shop_apk/data/datasource/product_detail_datasource.dart';
import 'package:shop_apk/data/model/categoty.dart';
import 'package:shop_apk/data/model/product_image.dart';
import 'package:shop_apk/data/model/product_variant.dart';
import 'package:shop_apk/data/model/properties.dart';
import 'package:shop_apk/data/model/variant_type.dart';

import 'package:shop_apk/util/api_exception.dart';
import 'dart:async';

abstract class IproductDetailRepository {
  FutureOr<Either<String, List<ProductImage>>> getGallery(String productId);
  FutureOr<Either<String, List<VariantType>>> getVariantType();
  FutureOr<Either<String, List<ProductVariant>>> getProductVariant(
      String productId);
  FutureOr<Either<String, Category>> productCategory(String categoryId);
  FutureOr<Either<String, List<Properties>>> productProperties(
      String productId);
}

class ProductDetailRepository extends IproductDetailRepository {
  final IproductDetailDatasource _repository;
  ProductDetailRepository(this._repository);
  @override
  FutureOr<Either<String, List<ProductImage>>> getGallery(
      String productId) async {
    try {
      var response = await _repository.getGallery(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  FutureOr<Either<String, List<VariantType>>> getVariantType() async {
    try {
      var response = await _repository.getVariantType();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  FutureOr<Either<String, List<ProductVariant>>> getProductVariant(
      String productId) async {
    try {
      var response = await _repository.getProductVariant(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  FutureOr<Either<String, Category>> productCategory(String categoryId) async {
    try {
      var response = await _repository.productCategory(categoryId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  FutureOr<Either<String, List<Properties>>> productProperties(
      String productId) async {
    try {
      var response = await _repository.productProperties(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }
}
