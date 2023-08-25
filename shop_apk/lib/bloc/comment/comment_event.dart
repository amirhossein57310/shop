abstract class CommentEvent {}

class CommentInitEvent extends CommentEvent {
  String productId;
  CommentInitEvent(this.productId);
}
