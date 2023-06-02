import 'package:dio/dio.dart';
import 'package:shop_apk/data/model/categoty.dart';
import 'package:shop_apk/data/model/product.dart';
import 'package:shop_apk/data/model/product_image.dart';
import 'package:shop_apk/data/model/product_variant.dart';
import 'package:shop_apk/data/model/properties.dart';
import 'package:shop_apk/data/model/variant.dart';
import 'package:shop_apk/data/model/variant_type.dart';
import 'package:shop_apk/di/di.dart';
import 'package:shop_apk/util/api_exception.dart';

abstract class IproductDetailDatasource {
  Future<List<ProductImage>> getGallery(String productId);
  Future<List<VariantType>> getVariantType();
  Future<List<Variant>> getVariant(String productId);
  Future<List<ProductVariant>> getProductVariant(String productId);
  Future<Category> productCategory(String categoryId);
  Future<List<Properties>> productProperties(String productId);
}

class ProductRemoteDetailDatasource extends IproductDetailDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<ProductImage>> getGallery(productId) async {
    try {
      Map<String, String> qParams = {'filter': 'product_id= "$productId"'};
      var response = await _dio.get('collections/gallery/records',
          queryParameters: qParams);

      return response.data['items']
          .map<ProductImage>((jsonObject) => ProductImage.fromJson(jsonObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(10, 'product error');
    }
  }

  @override
  Future<List<VariantType>> getVariantType() async {
    try {
      var response = await _dio.get(
        'collections/variants_type/records',
      );

      return response.data['items']
          .map<VariantType>((jsonObject) => VariantType.fromJson(jsonObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(10, 'product error');
    }
  }

  @override
  Future<List<Variant>> getVariant(String productId) async {
    try {
      Map<String, String> qParams = {'filter': 'product_id= "$productId"'};
      var response = await _dio.get('collections/variants/records',
          queryParameters: qParams);

      return response.data['items']
          .map<Variant>((jsonObject) => Variant.fromJson(jsonObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(10, 'product error');
    }
  }

  @override
  Future<List<ProductVariant>> getProductVariant(String productId) async {
    var variantTypeList = await getVariantType();
    var variantList = await getVariant(productId);

    List<ProductVariant> productVariantList = [];

    for (var variantType in variantTypeList) {
      var variant = variantList
          .where((element) => element.type_id == variantType.id)
          .toList();
      productVariantList.add(ProductVariant(variantType, variant));
    }
    return productVariantList;
  }

  @override
  Future<Category> productCategory(String categoryId) async {
    try {
      Map<String, String> qParams = {'filter': 'id= "$categoryId"'};
      var response = await _dio.get('collections/category/records',
          queryParameters: qParams);
      return Category.fromMapJson(response.data['items'][0]);
    } on DioError catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(10, 'product error');
    }
  }

  @override
  Future<List<Properties>> productProperties(String productId) async {
    try {
      Map<String, String> qParams = {'filter': 'product_id= "$productId"'};
      var response = await _dio.get('collections/properties/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Properties>((jsonObjct) => Properties.fromJson(jsonObjct))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(10, 'product error');
    }
  }
}
