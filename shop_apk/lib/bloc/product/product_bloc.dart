import 'package:bloc/bloc.dart';
import 'package:shop_apk/bloc/product/product_event.dart';
import 'package:shop_apk/bloc/product/product_state.dart';

import 'package:shop_apk/data/model/basket_item.dart';
import 'package:shop_apk/data/repository/basketItem_repository.dart';
import 'package:shop_apk/data/repository/product_detail_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IproductDetailRepository _repository;
  final IproductBasketRepository _basketRepository;
  ProductBloc(this._repository, this._basketRepository)
      : super(InitProductState()) {
    on<ProductResponseEvent>((event, emit) async {
      emit(LoadingProductState());
      var response = await _repository.getGallery(event.productId);
      var ProductVariant = await _repository.getProductVariant(event.productId);
      var productCategory = await _repository.productCategory(event.categoryId);
      var productProperties =
          await _repository.productProperties(event.productId);

      emit(ProductResponseState(
          response, ProductVariant, productCategory, productProperties));
    });

    on<ProductBasketEvent>((event, emit) {
      var basketItem = BasketItem(
          event.product.id,
          event.product.collectionId,
          event.product.thumbnail,
          event.product.discount_Price,
          event.product.price,
          event.product.name,
          event.product.quantity,
          event.product.category);
      _basketRepository.addToBasket(basketItem);
    });
  }
}
