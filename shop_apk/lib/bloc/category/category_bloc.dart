import 'package:bloc/bloc.dart';
import 'package:shop_apk/bloc/category/category_event.dart';
import 'package:shop_apk/bloc/category/category_state.dart';
import 'package:shop_apk/data/repository/categoty_repository.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final IcategoryRepository _repository;
  CategoryBloc(this._repository) : super(CategoryInitState()) {
    on<CategoryResposneReuestEvent>((event, emit) async {
      emit(CategoryLoadingState());
      var response = await _repository.getCategories();
      emit(CategoryResponseState(response));
    });
  }
}
