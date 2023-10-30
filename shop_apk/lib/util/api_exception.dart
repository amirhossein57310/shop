import 'package:dio/dio.dart';

class ApiException implements Exception {
  int? code;
  String? message;
  Response<dynamic>? response;
  ApiException(this.code, this.message, {this.response}) {
    if (message == 'Failed to authenticate.') {
      message = 'نام کاربری یا رمز عبور اشتباه است';
    }
    if (message == 'Failed to create record.') {
      if (response?.data['data']['passwordConfirm'] != null) {
        if (response?.data['data']['passwordConfirm']['code'] ==
            'validation_values_mismatch') {
          message = 'رمزعبور با تکرار آن هم‌خوانی ندارد';
        }
      }
      if (response?.data['data']['username'] != null) {
        if (response?.data['data']['username']['message'] ==
            'The username is invalid or already in use.') {
          message = 'کاربر قبلا ثبت نام کرده است';
        }
      }
    }
  }
}
