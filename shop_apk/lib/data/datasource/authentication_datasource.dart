import 'dart:async';
import 'package:dio/dio.dart';

import 'package:shop_apk/util/api_exception.dart';
import 'package:shop_apk/util/auth_manager.dart';
import 'package:shop_apk/util/dio_provider.dart';

abstract class IauthenticationDataSource {
  FutureOr<void> register(
      String username, String password, String passwordConfirm);

  FutureOr<String> login(String username, String password);
}

class Authentication extends IauthenticationDataSource {
  final Dio _dio = DioProvider.createDioWithoutHeader();
  Authentication();

  @override
  FutureOr<void> register(
      String username, String password, String passwordConfirm) async {
    try {
      var response = await _dio.post(
        'collections/users/records',
        data: {
          'username': username,
          'password': password,
          'passwordConfirm': passwordConfirm,
        },
      );
      if (response.statusCode == 200) {
        AuthManager.saveId(response.data['id']);
      }
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
        AuthManager.saveId(response.data['record']['id']);
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
