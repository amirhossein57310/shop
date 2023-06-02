import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_apk/data/datasource/authentication_datasource.dart';
import 'package:shop_apk/di/di.dart';
import 'package:shop_apk/util/api_exception.dart';
import 'package:shop_apk/util/auth_manager.dart';

// abstract class IAuthenticationRepositories {
//   Future<Either<String, String>> register();
//   Future<Either<String, String>> logIn();
// }

// class AuthenticationRepositories implements IAuthenticationRepositories {
//   final IauthenticationDataSource _datasource = locator.get();
//   final SharedPreferences _sharedPref = locator.get();

//   @override
//   Future<Either<String, String>> register() async {
//     try {
//       await _datasource.register('amirho', '12345678', '12345678');

//       return right('data has recieved');
//     } on ApiException catch (ex) {
//       return left(ex.message ?? 'null');
//     }
//   }

//   @override
//   Future<Either<String, String>> logIn() async {
//     try {
//       String token = await _datasource.logIn('amirho', '12345678');
//       if (token.isNotEmpty) {
//         AuthManager.saveToken(token);
//         return right('you log in');
//       } else {
//         return left('there is an entrance error');
//       }
//     } on ApiException catch (ex) {
//       return left(ex.message!);
//     }
//   }
// }

abstract class IAuthenticationRepositories {
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm);

  Future<Either<String, String>> login(String username, String password);
}

class AuthenticationRepositories extends IAuthenticationRepositories {
  final IauthenticationDataSource _datasource = locator.get();
  final SharedPreferences _sharedPreferences = locator.get();
  @override
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm) async {
    try {
      await _datasource.register('amiramini121', '12345678', '12345678');
      return right('ثبت نام با موفقیت انجام شد');
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      String token = await _datasource.login('amiramini121', '12345678');
      if (token.isNotEmpty) {
        AuthManager.saveToken(token);
        return right('you loged in');
      } else {
        return left('در ورود خطایی رخ داده است');
      }
    } on ApiException catch (ex) {
      return left('${ex.code!}');
    }
  }
}
