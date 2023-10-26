import 'package:dio/dio.dart';
import 'package:shop_apk/util/auth_manager.dart';

class DioProvider {
  static Dio createDio() {
    Dio dio = Dio(
      BaseOptions(baseUrl: 'http://startflutter.ir/api/', headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AuthManager.readAuth()}',
      }),
    );

    return dio;
  }

  static Dio createDioWithoutHeader() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: 'http://startflutter.ir/api/',
      ),
    );

    return dio;
  }
}
