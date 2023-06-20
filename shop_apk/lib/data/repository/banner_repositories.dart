import 'package:dartz/dartz.dart';
import 'package:shop_apk/data/datasource/banner_datasource.dart';
import 'package:shop_apk/data/model/banner.dart';

import 'package:shop_apk/util/api_exception.dart';
import 'dart:async';

abstract class IBannerRepositories {
  FutureOr<Either<String, List<Banners>>> getBanners();
}

class BannerRepositories extends IBannerRepositories {
  final IBannerRemoteDatasource _repository;
  BannerRepositories(this._repository);
  @override
  FutureOr<Either<String, List<Banners>>> getBanners() async {
    try {
      var response = await _repository.getBanners();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
