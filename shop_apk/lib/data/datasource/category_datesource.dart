import 'package:dio/dio.dart';
import 'package:shop_apk/data/model/categoty.dart';

import 'package:shop_apk/util/api_exception.dart';
import 'dart:async';

abstract class ICategoryRemoteDatasource {
  FutureOr<List<Category>> getCategories();
}

class CategoryRemoteDatasource extends ICategoryRemoteDatasource {
  final Dio _dio;
  CategoryRemoteDatasource(this._dio);
  @override
  FutureOr<List<Category>> getCategories() async {
    try {
      var response = await _dio.get('collections/category/records');
      return response.data['items']
          .map<Category>((jsonMapObject) => Category.fromMapJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, 'error');
    }
  }
}
