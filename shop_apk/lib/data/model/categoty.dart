class Category {
  String collectionId;
  String id;
  String thumbnail;
  String title;
  String color;
  String icon;
  Category(this.collectionId, this.id, this.thumbnail, this.title, this.color,
      this.icon);
// http://127.0.0.1:8090/api/files/COLLECTION_ID_OR_NAME/RECORD_ID/FILENAME?thumb=100x300
  factory Category.fromMapJson(Map<String, dynamic> jsonMapObject) {
    return Category(
      jsonMapObject['collectionId'],
      jsonMapObject['id'],
      'http://startflutter.ir/api/files/${jsonMapObject['collectionId']}/${jsonMapObject['id']}/${jsonMapObject['thumbnail']}',
      jsonMapObject['title'],
      jsonMapObject['color'],
      'http://startflutter.ir/api/files/${jsonMapObject['collectionId']}/${jsonMapObject['id']}/${jsonMapObject['icon']}',
    );
  }
}
