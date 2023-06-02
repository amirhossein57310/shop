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

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<BannerBloc>(context).add(BannerRequestEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.scaffoldColor,
      body: SafeArea(
        child: BlocBuilder<BannerBloc, BannerState>(
          builder: ((context, state) {
            return CustomScrollView(
              slivers: [
                _getSearchBox(),
                if (state is BannerLoadingState) ...{
                  SliverToBoxAdapter(
                    child: Column(
                      children: const [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  ),
                } else ...{
                  if (state is BannerResponseState) ...[
                    state.response.fold((l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    }, (r) {
                      return _getBanners(r);
                    })
                  ],
                  _getCategoryListTitle(),
                  if (state is BannerResponseState) ...[
                    state.categoryList.fold((l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    }, (categoryList) {
                      return _getCategoryList(categoryList);
                    })
                  ],
                  _getBestSellerTitle(),
                  if (state is BannerResponseState) ...[
                    state.bestSellerProductList.fold((l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    }, (r) {
                      return _getBestSellerProducts(r);
                    })
                  ],
                  _getMostViewdTitle(),
                  if (state is BannerResponseState) ...[
                    state.hotestProductList.fold(
                      (l) {
                        return SliverToBoxAdapter(
                          child: Text(l),
                        );
                      },
                      (r) {
                        return _getMostViewdProduct(r);
                      },
                    ),
                  ],
                },
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _getMostViewdProduct extends StatelessWidget {
  List<Product> productList;
  _getMostViewdProduct(
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

class _getMostViewdTitle extends StatelessWidget {
  const _getMostViewdTitle({
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

class _getBestSellerProducts extends StatelessWidget {
  List<Product> productList;
  _getBestSellerProducts(
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

class _getCategoryList extends StatelessWidget {
  List<Category> categoryList;
  _getCategoryList(
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

class _getCategoryListTitle extends StatelessWidget {
  const _getCategoryListTitle({
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

class _getBanners extends StatelessWidget {
  List<Banners> list;
  _getBanners(
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

class _getSearchBox extends StatelessWidget {
  const _getSearchBox({
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
