class Product {
  String id;
  String collectionId;
  String thumbnail;
  String description;
  int discount_Price;
  int price;
  String popularity;
  String name;
  int quantity;
  String category;
  int? realPrice;
  num? percent;

  Product(
    this.id,
    this.collectionId,
    this.thumbnail,
    this.description,
    this.discount_Price,
    this.price,
    this.popularity,
    this.name,
    this.quantity,
    this.category,
  ) {
    realPrice = price + discount_Price;
    percent = ((price - realPrice!) / price) * 100;
  }

  factory Product.fromJson(Map<String, dynamic> jsonObject) {
    return Product(
        jsonObject['id'],
        jsonObject['collectionId'],
        'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
        jsonObject['description'],
        jsonObject['discount_price'],
        jsonObject['price'],
        jsonObject['popularity'],
        jsonObject['name'],
        jsonObject['quantity'],
        jsonObject['category']);
  }
}
