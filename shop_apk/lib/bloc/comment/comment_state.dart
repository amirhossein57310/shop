import 'package:dartz/dartz.dart';
import 'package:shop_apk/data/model/comment.dart';

abstract class CommentState {}

class CommentLoading extends CommentState {}

class CommentResponse extends CommentState {
  Either<String, List<Comment>> commentList;

  CommentResponse(this.commentList);
}
