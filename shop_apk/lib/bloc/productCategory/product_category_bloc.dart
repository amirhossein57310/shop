import 'package:bloc/bloc.dart';
import 'package:shop_apk/bloc/productCategory/product_category_event.dart';
import 'package:shop_apk/bloc/productCategory/product_category_state.dart';
import 'package:shop_apk/data/repository/product_categoty_repository.dart';

class ProductCategoryBloc
    extends Bloc<ProductCategoryEvent, ProductCategoryState> {
  final IproductCategoryRepository _repository;
  ProductCategoryBloc(this._repository) : super(InitProductCategoryState()) {
    on<ProductCategoryResponseEvent>((event, emit) async {
      emit(LoadingProductCategoryState());
      var productList = await _repository.getProductCategory(event.id);
      emit(ResponseProductCategoryState(productList));
    });
  }
}
