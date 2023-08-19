import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_apk/bloc/banner/banner_bloc.dart';
import 'package:shop_apk/bloc/banner/banner_event.dart';
import 'package:shop_apk/bloc/banner/banner_state.dart';
import 'package:shop_apk/constants/colors.dart';
import 'package:shop_apk/data/model/banner.dart';
import 'package:shop_apk/data/model/product.dart';
import 'package:shop_apk/widgets/banner_slider.dart';
import 'package:shop_apk/widgets/horizontal_item.dart';
import 'package:shop_apk/widgets/product_item.dart';

import '../data/model/categoty.dart';
import '../widgets/loading_animation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.scaffoldColor,
      body: SafeArea(
        child: BlocBuilder<BannerBloc, BannerState>(
          builder: ((context, state) {
            return _getHomeScreenContent(state, context);
          }),
        ),
      ),
    );
  }
}

Widget _getHomeScreenContent(BannerState state, BuildContext context) {
  if (state is BannerLoadingState) {
    return Center(
      child: LoadingAnimation(),
    );
  } else if (state is BannerResponseState) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<BannerBloc>().add(BannerRequestEvent());
      },
      child: CustomScrollView(
        slivers: [
          _GetSearchBox(),
          state.response.fold((l) {
            return SliverToBoxAdapter(
              child: Text(l),
            );
          }, (r) {
            return _GetBanners(r);
          }),
          _GetCategoryListTitle(),
          state.categoryList.fold((l) {
            return SliverToBoxAdapter(
              child: Text(l),
            );
          }, (categoryList) {
            return _GetCategoryList(categoryList);
          }),
          _getBestSellerTitle(),
          state.bestSellerProductList.fold((l) {
            return SliverToBoxAdapter(
              child: Text(l),
            );
          }, (r) {
            return _GetBestSellerProducts(r);
          }),
          _GetMostViewdTitle(),
          state.hotestProductList.fold(
            (l) {
              return SliverToBoxAdapter(
                child: Text(l),
              );
            },
            (r) {
              return _GetMostViewdProduct(r);
            },
          ),
        ],
      ),
    );
  } else {
    return Center(
      child: Text('خطایی در دریافت اطلاعات به وجود آمده است!'),
    );
  }
}

class _GetMostViewdProduct extends StatelessWidget {
  final List<Product> productList;
  const _GetMostViewdProduct(
    this.productList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.only(
            right: 44,
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: ProductItem(productList[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _GetMostViewdTitle extends StatelessWidget {
  const _GetMostViewdTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 44,
          right: 44,
          bottom: 20,
          top: 32,
        ),
        child: Row(
          children: [
            const Text(
              'پر بازدید ترین ها',
              style: TextStyle(color: CustomColor.gery, fontFamily: 'SB'),
            ),
            const Spacer(),
            const Text(
              'مشاهده همه',
              style: TextStyle(color: CustomColor.blue, fontFamily: 'SB'),
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset('images/icon_left_categroy.png'),
          ],
        ),
      ),
    );
  }
}

class _GetBestSellerProducts extends StatelessWidget {
  final List<Product> productList;
  const _GetBestSellerProducts(
    this.productList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.only(
            right: 44,
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: ProductItem(productList[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _getBestSellerTitle extends StatelessWidget {
  const _getBestSellerTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 44,
          right: 44,
          bottom: 20,
        ),
        child: Row(
          children: [
            const Text(
              'پر فروش ترین ها',
              style: TextStyle(color: CustomColor.gery, fontFamily: 'SB'),
            ),
            const Spacer(),
            const Text(
              'مشاهده همه',
              style: TextStyle(color: CustomColor.blue, fontFamily: 'SB'),
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset('images/icon_left_categroy.png'),
          ],
        ),
      ),
    );
  }
}

class _GetCategoryList extends StatelessWidget {
  final List<Category> categoryList;
  const _GetCategoryList(
    this.categoryList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.only(
            right: 44,
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: HorizontalItem(categoryList[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _GetCategoryListTitle extends StatelessWidget {
  const _GetCategoryListTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 44,
          right: 44,
          bottom: 20,
          top: 32,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              'دسته بندی',
              style: TextStyle(color: CustomColor.gery, fontFamily: 'SB'),
            ),
          ],
        ),
      ),
    );
  }
}

class _GetBanners extends StatelessWidget {
  final List<Banners> list;
  const _GetBanners(
    this.list, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BannerSlider(list),
    );
  }
}

class _GetSearchBox extends StatelessWidget {
  const _GetSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 44,
          right: 44,
          bottom: 32,
          top: 20,
        ),
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Image.asset('images/icon_search.png'),
              const SizedBox(
                width: 10,
              ),
              Text(
                'جستجوی محصولات',
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: CustomColor.gery, fontFamily: 'SB', fontSize: 16),
              ),
              Spacer(),
              Image.asset('images/icon_apple_blue.png'),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
