import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_apk/bloc/basket/basket_bloc.dart';
import 'package:shop_apk/data/datasource/authentication_datasource.dart';
import 'package:shop_apk/data/datasource/banner_datasource.dart';
import 'package:shop_apk/data/datasource/basketItem_datasource.dart';
import 'package:shop_apk/data/datasource/category_datesource.dart';
import 'package:shop_apk/data/datasource/comment_datasource.dart';
import 'package:shop_apk/data/datasource/product_category_datasource.dart';
import 'package:shop_apk/data/datasource/product_datasource.dart';
import 'package:shop_apk/data/datasource/product_detail_datasource.dart';
import 'package:shop_apk/data/repository/authetication_repository.dart';
import 'package:shop_apk/data/repository/banner_repositories.dart';
import 'package:shop_apk/data/repository/basketItem_repository.dart';
import 'package:shop_apk/data/repository/categoty_repository.dart';
import 'package:shop_apk/data/repository/comment_repository.dart';
import 'package:shop_apk/data/repository/product_categoty_repository.dart';
import 'package:shop_apk/data/repository/product_detail_repository.dart';
import 'package:shop_apk/data/repository/product_repository.dart';
import 'dart:async';

import 'package:shop_apk/util/payment_handler.dart';
import 'package:shop_apk/util/url_payment.dart';
import 'package:zarinpal/zarinpal.dart';

var locator = GetIt.instance;

FutureOr<void> getItInit() async {
  await _initComponents();
  _initDatasources();
  _initRepositories();
  locator
      .registerSingleton<BasketBloc>(BasketBloc(locator.get(), locator.get()));
}

void _initRepositories() {
  locator.registerFactory<IcategoryRepository>(
      () => CategoryRepository(locator.get()));
  locator.registerFactory<IBannerRepositories>(
      () => BannerRepositories(locator.get()));
  locator.registerFactory<IProductRepository>(
      () => ProductRepositories(locator.get()));
  locator.registerFactory<IproductDetailRepository>(
      () => ProductDetailRepository(locator.get()));
  locator.registerFactory<IproductCategoryRepository>(
      () => ProductCategoryRepository(locator.get()));
  locator.registerFactory<IproductBasketRepository>(
      () => ProductBasketRepository(locator.get()));
  locator.registerFactory<IBannerRemoteDatasource>(
      () => BannerRemoteDatasource(locator.get()));
  locator.registerSingleton<IAuthenticationRepositories>(
      AuthenticationRepositories(locator.get()));
  locator
      .registerSingleton<IcommentRepository>(CommentRepository(locator.get()));
}

void _initDatasources() {
  locator.registerFactory<ICategoryRemoteDatasource>(() {
    return CategoryRemoteDatasource(locator.get());
  });

  locator.registerFactory<IProductDatasource>(
      () => ProductRemoteDtasource(locator.get()));
  locator.registerFactory<IproductDetailDatasource>(
      () => ProductRemoteDetailDatasource(locator.get()));
  locator.registerFactory<IproductCategoryRemote>(
      () => ProductCategoryRemote(locator.get()));
  locator.registerFactory<IproductBasketDateSource>(
      () => ProductBasketLocalDatasource());
  locator.registerFactory<IauthenticationDataSource>(() {
    return Authentication(locator.get());
  });
  locator.registerFactory<IcommentDatasource>(() {
    return CommentRemoteDatasource(locator.get());
  });
}

Future<void> _initComponents() async {
  locator.registerSingleton<PaymentRequest>(PaymentRequest());

  locator.registerSingleton<UrlHandler>(UrlPayment());

  locator.registerSingleton<PaymentHandler>(
      ZarinpalPaymentHandler(locator.get(), locator.get()));

  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  locator.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: 'http://startflutter.ir/api/')));
}
