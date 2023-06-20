import 'package:dartz/dartz.dart';
import 'package:shop_apk/data/datasource/category_datesource.dart';
import 'package:shop_apk/data/model/categoty.dart';

import 'package:shop_apk/util/api_exception.dart';
import 'dart:async';

abstract class IcategoryRepository {
  FutureOr<Either<String, List<Category>>> getCategories();
}

class CategoryRepository extends IcategoryRepository {
  final ICategoryRemoteDatasource _datasource;
  CategoryRepository(this._datasource);
  @override
  FutureOr<Either<String, List<Category>>> getCategories() async {
    try {
      var response = await _datasource.getCategories();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
