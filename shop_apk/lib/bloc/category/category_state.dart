import 'package:dartz/dartz.dart';
import 'package:shop_apk/data/model/categoty.dart';

// abstract class CategoryState {}

// class CategoryInitState extends CategoryState {}

// class CategoryLoadingState extends CategoryState {}

// class CategoryResponseState extends CategoryState {
//   Either<String, List<Categoty>> response;
//   CategoryResponseState(this.response);
// }

abstract class CategoryState {}

class CategoryInitState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryResponseState extends CategoryState {
  Either<String, List<Category>> response;

  CategoryResponseState(this.response);
}
