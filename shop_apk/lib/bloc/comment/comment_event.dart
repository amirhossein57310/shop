abstract class CommentEvent {}

class CommentInitEvent extends CommentEvent {
  String productId;
  CommentInitEvent(this.productId);
}

class CommentPostEvent extends CommentEvent {
  String productId;
  String commnet;
  CommentPostEvent(this.productId, this.commnet);
}
