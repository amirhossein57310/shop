import 'dart:async';

import 'package:dartz/dartz.dart';

import 'package:shop_apk/data/datasource/authentication_datasource.dart';

import 'package:shop_apk/util/api_exception.dart';
import 'package:shop_apk/util/auth_manager.dart';

abstract class IAuthenticationRepositories {
  FutureOr<Either<String, String>> register(
      String username, String password, String passwordConfirm);

  FutureOr<Either<String, String>> login(String username, String password);
}

class AuthenticationRepositories extends IAuthenticationRepositories {
  final IauthenticationDataSource _datasource;
  AuthenticationRepositories(this._datasource);

  @override
  FutureOr<Either<String, String>> register(
      String username, String password, String passwordConfirm) async {
    try {
      await _datasource.register('amiramini121', '12345678', '12345678');
      return right('ثبت نام با موفقیت انجام شد');
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  FutureOr<Either<String, String>> login(
      String username, String password) async {
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
