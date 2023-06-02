import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_apk/bloc/basket/basket_bloc.dart';
import 'package:shop_apk/data/datasource/authentication_datasource.dart';
import 'package:shop_apk/data/datasource/banner_datasource.dart';
import 'package:shop_apk/data/datasource/basketItem_datasource.dart';
import 'package:shop_apk/data/datasource/category_datesource.dart';
import 'package:shop_apk/data/datasource/product_category_datasource.dart';
import 'package:shop_apk/data/datasource/product_datasource.dart';
import 'package:shop_apk/data/datasource/product_detail_datasource.dart';
import 'package:shop_apk/data/repository/authetication_repository.dart';
import 'package:shop_apk/data/repository/banner_repositories.dart';
import 'package:shop_apk/data/repository/basketItem_repository.dart';
import 'package:shop_apk/data/repository/categoty_repository.dart';
import 'package:shop_apk/data/repository/product_categoty_repository.dart';
import 'package:shop_apk/data/repository/product_detail_repository.dart';
import 'package:shop_apk/data/repository/product_repository.dart';

// var locator = GetIt.instance;
// Future<void> getItInit() async {
//   //components

//   locator.registerSingleton<Dio>(
//       Dio(BaseOptions(baseUrl: 'http://startflutter.ir/api/')));

//   locator.registerSingleton<SharedPreferences>(
//       await SharedPreferences.getInstance());

//   // datasource

//   locator.registerFactory<IauthenticationDataSource>(() {
//     return Authentication();
//   });

//   //repositories

//   locator.registerFactory<IAuthenticationRepositories>(
//       () => AuthenticationRepositories());
// }

var locator = GetIt.instance;

Future<void> getItInit() async {
  locator.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: 'http://startflutter.ir/api/')));

  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  locator.registerFactory<IauthenticationDataSource>(() {
    return Authentication();
  });

  // locator.registerFactory<IcategotyDatasource>(() {
  //   return CategoryRemoteDatasource();
  // });

  locator.registerFactory<ICategoryRemoteDatasource>(() {
    return CategoryRemoteDatasource();
  });
  locator
      .registerFactory<IBannerRemoteDatasource>(() => BannerRemoteDatasource());
  locator.registerFactory<IAuthenticationRepositories>(() {
    return AuthenticationRepositories();
  });
  locator.registerFactory<IProductDatasource>(() => ProductRemoteDtasource());
  locator.registerFactory<IproductDetailDatasource>(
      () => ProductRemoteDetailDatasource());
  locator
      .registerFactory<IproductCategoryRemote>(() => ProductCategoryRemote());
  locator.registerFactory<IproductBasketDateSource>(
      () => productBasketLocalDatasource());

  // locator.registerFactory<IcategoryRepository>(() {
  //   return CategoryRepository();
  // });

  locator.registerFactory<IcategoryRepository>(() => CategoryRepository());
  locator.registerFactory<IBannerRepositories>(() => BannerRepositories());
  locator.registerFactory<IProductRepository>(() => ProductRepositories());
  locator.registerFactory<IproductDetailRepository>(
      () => ProductDetailRepository());
  locator.registerFactory<IproductCategoryRepository>(
      () => ProductCategoryRepository());
  locator.registerFactory<IproductBasketRepository>(
      () => ProductBasketRepository());

  //bloc

  locator.registerSingleton<BasketBloc>(BasketBloc());
}
