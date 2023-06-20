import 'package:dio/dio.dart';

import 'package:shop_apk/data/model/product.dart';

import 'package:shop_apk/util/api_exception.dart';
import 'dart:async';

abstract class IProductDatasource {
  FutureOr<List<Product>> getProducts();
  FutureOr<List<Product>> getBestSeller();
  FutureOr<List<Product>> getHotest();
}

class ProductRemoteDtasource extends IProductDatasource {
  final Dio _dio;
  ProductRemoteDtasource(this._dio);
  @override
  FutureOr<List<Product>> getProducts() async {
    try {
      var response = await _dio.get('collections/products/records');

      return response.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(10, 'product error');
    }
  }

  @override
  FutureOr<List<Product>> getHotest() async {
    try {
      Map<String, String> qParams = {'filter': 'popularity= "Hotest"'};
      var response = await _dio.get('collections/products/records',
          queryParameters: qParams);

      return response.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(10, 'product error');
    }
  }

  @override
  FutureOr<List<Product>> getBestSeller() async {
    try {
      Map<String, String> qParams = {'filter': 'popularity= "Best Seller"'};
      var response = await _dio.get('collections/products/records',
          queryParameters: qParams);

      return response.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(10, 'product error');
    }
  }
}
