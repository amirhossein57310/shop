import 'package:shop_apk/data/model/categoty.dart';
import 'package:shop_apk/data/model/product.dart';

class ProductCategory {
  Category category;
  List<Product> productList;
  ProductCategory(this.category, this.productList);
}
