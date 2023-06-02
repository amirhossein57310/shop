import 'package:dartz/dartz.dart';
import 'package:shop_apk/data/datasource/banner_datasource.dart';
import 'package:shop_apk/data/model/banner.dart';
import 'package:shop_apk/di/di.dart';
import 'package:shop_apk/util/api_exception.dart';

abstract class IBannerRepositories {
  Future<Either<String, List<Banners>>> getBanners();
}

class BannerRepositories extends IBannerRepositories {
  @override
  Future<Either<String, List<Banners>>> getBanners() async {
    final IBannerRemoteDatasource _repository = locator.get();
    try {
      var response = await _repository.getBanners();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
