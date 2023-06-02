import 'package:dio/dio.dart';
import 'package:shop_apk/data/model/categoty.dart';
import 'package:shop_apk/di/di.dart';
import 'package:shop_apk/util/api_exception.dart';

// abstract class IcategotyDatasource {
//   Future<List<Categoty>> getCategories();
// }

// class CategoryRemoteDatasource extends IcategotyDatasource {
//   @override
//   Future<List<Categoty>> getCategories() async {
//     final Dio _dio = locator.get();
//     try {
//       var response = await _dio.get('collections/category/records');
//       return response.data['items']
//           .map<Categoty>((jsonObject) => Categoty.fromMapJson(jsonObject))
//           .toList();
//     } on DioError catch (ex) {
//       throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
//     } catch (ex) {
//       throw ApiException(0, 'unknown');
//     }
//   }
// }

abstract class ICategoryRemoteDatasource {
  Future<List<Category>> getCategories();
}

class CategoryRemoteDatasource extends ICategoryRemoteDatasource {
  @override
  Future<List<Category>> getCategories() async {
    final Dio _dio = locator.get();
    try {
      var response = await _dio.get('collections/category/records');
      return response.data['items']
          .map<Category>((jsonMapObject) => Category.fromMapJson(jsonMapObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, 'error');
    }
  }
}
