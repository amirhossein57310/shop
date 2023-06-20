import 'package:dartz/dartz.dart';

import 'package:shop_apk/data/model/categoty.dart';
import 'package:shop_apk/data/model/product.dart';

import '../../data/model/banner.dart';

abstract class BannerState {}

class BannerInitState extends BannerState {}

class BannerLoadingState extends BannerState {}

class BannerResponseState extends BannerState {
  Either<String, List<Banners>> response;
  Either<String, List<Category>> categoryList;
  Either<String, List<Product>> productList;
  Either<String, List<Product>> hotestProductList;
  Either<String, List<Product>> bestSellerProductList;
  BannerResponseState(this.response, this.categoryList, this.productList,
      this.hotestProductList, this.bestSellerProductList);
}
