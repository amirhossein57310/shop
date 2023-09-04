import 'package:dio/dio.dart';
import 'package:shop_apk/data/model/comment.dart';

import '../../util/api_exception.dart';

abstract class IcommentDatasource {
  Future<List<Comment>> getcomments(String productId);
  Future<void> postComment(String productId, String comment);
}

class CommentRemoteDatasource extends IcommentDatasource {
  final Dio _dio;
  CommentRemoteDatasource(this._dio);

  @override
  Future<List<Comment>> getcomments(String productId) async {
    Map<String, String> qParams = {
      'filter': 'product_id = "$productId"',
      'expand': 'user_id'
    };
    try {
      var response = await _dio.get('collections/comment/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Comment>((jsonMapObject) => Comment.fromMapJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, 'error');
    }
  }

  @override
  Future<void> postComment(String productId, String comment) async {
    try {
      await _dio.post('collections/comment/records', data: {
        'text': comment,
        'user_id': 'lkg8xc50i07oedn',
        'product_id': productId
      });
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, 'error');
    }
  }
}
