import 'dart:async';
import 'package:dio/dio.dart';

import 'package:shop_apk/util/api_exception.dart';

abstract class IauthenticationDataSource {
  FutureOr<void> register(
      String username, String password, String passwordConfirm);

  FutureOr<String> login(String username, String password);
}

class Authentication extends IauthenticationDataSource {
  final Dio _dio;
  Authentication(this._dio);

  @override
  FutureOr<void> register(
      String username, String password, String passwordConfirm) async {
    try {
      await _dio.post(
        'collections/users/records',
        data: {
          'username': username,
          'password': password,
          'passwordConfirm': passwordConfirm,
        },
      );
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
  }

  @override
  FutureOr<String> login(String username, String password) async {
    try {
      var response =
          await _dio.post('collections/users/auth-with-password', data: {
        'identity': username,
        'password': password,
      });
      if (response.statusCode == 200) {
        return response.data['token'];
      }
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
    return '';
  }
}
