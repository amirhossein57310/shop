class Comment {
  String id;
  String text;
  String productId;
  String userId;
  String userThumbnailUrl;
  String username;

  Comment(this.id, this.text, this.productId, this.userId,
      this.userThumbnailUrl, this.username);

  factory Comment.fromMapJson(Map<String, dynamic> jsonMapObject) {
    return Comment(
      jsonMapObject['id'],
      jsonMapObject['text'],
      jsonMapObject['product_id'],
      jsonMapObject['user_id'],
      'http://startflutter.ir/api/files/${jsonMapObject['expand']['user_id']['collectionName']}/${jsonMapObject['expand']['user_id']['id']}/${jsonMapObject['expand']['user_id']['avatar']}',
      jsonMapObject['expand']['user_id']['name'],
    );
  }
}
