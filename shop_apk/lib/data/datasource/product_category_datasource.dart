import 'package:dio/dio.dart';

import 'package:shop_apk/data/model/product.dart';

import 'package:shop_apk/util/api_exception.dart';
import 'dart:async';

abstract class IproductCategoryRemote {
  FutureOr<List<Product>> getProductCategory(String category);
}

class ProductCategoryRemote extends IproductCategoryRemote {
  final Dio _dio;
  ProductCategoryRemote(this._dio);

  @override
  FutureOr<List<Product>> getProductCategory(String category) async {
    try {
      Map<String, String> qParams = {'filter': 'category= "$category"'};
      Response<dynamic> responses;
      if (category == '78q8w901e6iipuk') {
        responses = await _dio.get('collections/products/records');
      } else {
        responses = await _dio.get('collections/products/records',
            queryParameters: qParams);
      }
      return responses.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(10, 'product error');
    }
  }
}
