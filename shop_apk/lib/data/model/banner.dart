class Banners {
  String id;
  String collectionId;
  String thumbnail;
  String categoryId;
  Banners(this.id, this.collectionId, this.thumbnail, this.categoryId);

  factory Banners.fromMapObject(Map<String, dynamic> jsonMapObject) {
    return Banners(
      jsonMapObject['id'],
      jsonMapObject['collectionId'],
      'http://startflutter.ir/api/files/${jsonMapObject['collectionId']}/${jsonMapObject['id']}/${jsonMapObject['thumbnail']}',
      jsonMapObject['categoryId'],
    );
  }
}
