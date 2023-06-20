import 'package:bloc/bloc.dart';
import 'package:shop_apk/bloc/banner/banner_event.dart';
import 'package:shop_apk/bloc/banner/banner_state.dart';
import 'package:shop_apk/data/repository/banner_repositories.dart';
import 'package:shop_apk/data/repository/categoty_repository.dart';
import 'package:shop_apk/data/repository/product_repository.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final IBannerRepositories _repository;
  final IcategoryRepository _categortRepository;
  final IProductRepository _productRepository;
  BannerBloc(
      this._repository, this._categortRepository, this._productRepository)
      : super(BannerInitState()) {
    on<BannerRequestEvent>((event, emit) async {
      emit(BannerLoadingState());
      var response = await _repository.getBanners();
      var categoryList = await _categortRepository.getCategories();
      var productList = await _productRepository.getProducts();
      var bestSellerProductList = await _productRepository.getBestSeller();
      var hotestProductList = await _productRepository.getHotest();
      emit(BannerResponseState(response, categoryList, productList,
          bestSellerProductList, hotestProductList));
    });
  }
}
