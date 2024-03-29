import 'dart:async';

import 'package:dartz/dartz.dart';

import 'package:shop_apk/data/datasource/authentication_datasource.dart';

import 'package:shop_apk/util/api_exception.dart';

abstract class IAuthenticationRepositories {
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm);

  Future<Either<String, String>> login(String username, String password);
}

class AuthenticationRepositories extends IAuthenticationRepositories {
  final IauthenticationDataSource _datasource;
  AuthenticationRepositories(this._datasource);

  @override
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm) async {
    try {
      await _datasource.register(username, password, passwordConfirm);
      return right('ثبت نام با موفقیت انجام شد');
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      String token = await _datasource.login(username, password);
      if (token.isNotEmpty) {
        return right('شما وارد شده اید');
      } else {
        return left('در ورود خطایی رخ داده است');
      }
    } on ApiException catch (ex) {
      return left('${ex.message!}');
    }
  }
}
