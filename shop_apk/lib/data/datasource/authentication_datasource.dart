import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:shop_apk/di/di.dart';
import 'package:shop_apk/util/api_exception.dart';

// abstract class IauthenticationDataSource {
//   Future<void> register(
//       String username, String password, String passwordConfirm);

//   Future<String> logIn(String username, String password);
// }

// class Authentication implements IauthenticationDataSource {
//   final Dio _dio = locator.get();

//   @override
//   Future<void> register(
//       String username, String password, String passwordConfirm) async {
//     try {
//       var response = await _dio.post('collections/users/records', data: {
//         'username': username,
//         'password': password,
//         'passwordConfirm': passwordConfirm
//       });
//     } on DioError catch (ex) {
//       // print(ex.message);
//       // print(ex.response?.statusCode);
//       // print(ex.response?.data['message']);
//       throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
//     } catch (ex) {
//       throw ApiException(0, 'unknown error');
//     }
//   }

//   @override
//   Future<String> logIn(String username, String password) async {
//     try {
//       var response =
//           await _dio.post('collections/users/auth-with-password', data: {
//         'identity': username,
//         'password': password,
//       });
//       if (response.statusCode == 200) {
//         return response.data?['token'];
//       }
//     } on DioError catch (ex) {
//       throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
//     } catch (ex) {
//       throw ApiException(0, 'unknown error');
//     }
//     return '';
//   }
// }

abstract class IauthenticationDataSource {
  Future<void> register(
      String username, String password, String passwordConfirm);

  Future<String> login(String username, String password);
}

class Authentication extends IauthenticationDataSource {
  final Dio _dio = locator.get();

  @override
  Future<void> register(
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
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
  }

  @override
  Future<String> login(String username, String password) async {
    var response;
    try {
      var response =
          await _dio.post('collections/users/auth-with-password', data: {
        'identity': username,
        'password': password,
      });
      if (response.statusCode == 200) {
        return response.data['token'];
      }
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
    return '';
  }
}
