import 'package:hive/hive.dart';
part 'basket_item.g.dart';

@HiveType(typeId: 0)
class BasketItem {
  @HiveField(0)
  String id;
  @HiveField(1)
  String collectionId;
  @HiveField(2)
  String thumbnail;
  @HiveField(3)
  int discount_Price;
  @HiveField(4)
  int price;
  @HiveField(5)
  String name;
  @HiveField(6)
  int quantity;
  @HiveField(7)
  String category;
  @HiveField(8)
  int? realPrice;
  @HiveField(9)
  num? percent;

  BasketItem(
    this.id,
    this.collectionId,
    // this.thumbnail =  'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}'
    this.thumbnail,
    this.discount_Price,
    this.price,
    this.name,
    this.quantity,
    this.category,
  ) {
    realPrice = price + discount_Price;

    percent = ((price - realPrice!) / price) * 100;
  }
}
