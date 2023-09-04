import 'package:dartz/dartz.dart';
import 'package:shop_apk/data/datasource/comment_datasource.dart';
import 'package:shop_apk/data/model/comment.dart';

import '../../util/api_exception.dart';

abstract class IcommentRepository {
  Future<Either<String, List<Comment>>> getComments(String productId);
  Future<Either<String, String>> postComment(String productId, String comment);
}

class CommentRepository extends IcommentRepository {
  final IcommentDatasource _datasource;
  CommentRepository(this._datasource);
  @override
  Future<Either<String, List<Comment>>> getComments(String productId) async {
    try {
      var response = await _datasource.getcomments(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> postComment(
      String productId, String comment) async {
    try {
      await _datasource.postComment(productId, comment);
      return right('نظر شما با موفقیت ثبت شد');
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
