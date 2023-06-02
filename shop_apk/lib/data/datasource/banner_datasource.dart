import 'package:dio/dio.dart';
import 'package:shop_apk/data/model/banner.dart';
import 'package:shop_apk/di/di.dart';
import 'package:shop_apk/util/api_exception.dart';

abstract class IBannerRemoteDatasource {
  Future<List<Banners>> getBanners();
}

class BannerRemoteDatasource extends IBannerRemoteDatasource {
  @override
  Future<List<Banners>> getBanners() async {
    final Dio _dio = locator.get();
    try {
      var response = await _dio.get('collections/banner/records');
      return response.data['items']
          .map<Banners>((jsonMapObject) => Banners.fromMapObject(jsonMapObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
  }
}
