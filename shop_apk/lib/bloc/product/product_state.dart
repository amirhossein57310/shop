import 'package:dartz/dartz.dart';
import 'package:shop_apk/data/model/categoty.dart';
import 'package:shop_apk/data/model/product.dart';
import 'package:shop_apk/data/model/product_category.dart';
import 'package:shop_apk/data/model/product_image.dart';
import 'package:shop_apk/data/model/product_variant.dart';
import 'package:shop_apk/data/model/properties.dart';
import 'package:shop_apk/data/model/variant.dart';
import 'package:shop_apk/data/model/variant_type.dart';

abstract class ProductState {}

class InitProductState extends ProductState {}

class LoadingProductState extends ProductState {}

class ProductResponseState extends ProductState {
  Either<String, List<ProductImage>> listProductImage;
  Either<String, List<ProductVariant>> productVariant;
  Either<String, Category> productCategory;
  Either<String, List<Properties>> productProperties;

  ProductResponseState(this.listProductImage, this.productVariant,
      this.productCategory, this.productProperties);
}
