import 'package:dio/dio.dart';
import 'package:shop_apk/data/model/banner.dart';

import 'package:shop_apk/util/api_exception.dart';
import 'dart:async';

abstract class IBannerRemoteDatasource {
  FutureOr<List<Banners>> getBanners();
}

class BannerRemoteDatasource extends IBannerRemoteDatasource {
  final Dio _dio;
  BannerRemoteDatasource(this._dio);
  @override
  FutureOr<List<Banners>> getBanners() async {
    try {
      var response = await _dio.get('collections/banner/records');
      return response.data['items']
          .map<Banners>((jsonMapObject) => Banners.fromMapObject(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
  }
}
