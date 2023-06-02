import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_apk/data/datasource/category_datesource.dart';
import 'package:shop_apk/data/model/categoty.dart';
import 'package:shop_apk/di/di.dart';
import 'package:shop_apk/util/api_exception.dart';

// abstract class IcategoryRepository {
//   Future<Either<String, List<Categoty>>>? getCategories();
// }

// class CategoryRepository extends IcategoryRepository {
//   final IcategotyDatasource _datasource = locator.get();
//   @override
//   Future<Either<String, List<Categoty>>> getCategories() async {
//     try {
//       var response = await _datasource.getCategories();
//       return right(response);
//     } on ApiException catch (ex) {
//       return left(ex.message ?? 'خطا مجتوای متنی ندارد');
//     }
//   }
// }

abstract class IcategoryRepository {
  Future<Either<String, List<Category>>> getCategories();
}

class CategoryRepository extends IcategoryRepository {
  final ICategoryRemoteDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<Category>>> getCategories() async {
    try {
      var response = await _datasource.getCategories();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
