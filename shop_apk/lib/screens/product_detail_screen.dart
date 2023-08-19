import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_apk/bloc/basket/basket_bloc.dart';
import 'package:shop_apk/bloc/basket/basket_event.dart';
import 'package:shop_apk/bloc/product/product_bloc.dart';
import 'package:shop_apk/bloc/product/product_event.dart';
import 'package:shop_apk/bloc/product/product_state.dart';
import 'package:shop_apk/constants/colors.dart';

import 'package:shop_apk/data/model/product.dart';
import 'package:shop_apk/data/model/product_image.dart';
import 'package:shop_apk/data/model/product_variant.dart';
import 'package:shop_apk/data/model/properties.dart';
import 'package:shop_apk/data/model/variant.dart';
import 'package:shop_apk/data/model/variant_type.dart';
import 'package:shop_apk/di/di.dart';

import 'package:shop_apk/widgets/cached_image.dart';
import 'package:shop_apk/widgets/loading_animation.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen(this.product, {Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var bloc = ProductBloc(locator.get(), locator.get());
        bloc.add(
            ProductResponseEvent(widget.product.id, widget.product.category));
        return bloc;
      },
      child: DetailContent(
        parentWidget: widget,
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  const DetailContent({
    Key? key,
    required this.parentWidget,
  }) : super(key: key);

  final ProductDetailScreen parentWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.scaffoldColor,
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: ((context, state) {
            if (state is LoadingProductState) {
              return Center(
                child: LoadingAnimation(),
              );
            }
            return CustomScrollView(
              slivers: [
                if (state is LoadingProductState) ...{
                  SliverToBoxAdapter(
                    child: LoadingAnimation(),
                  ),
                },
                if (state is ProductResponseState) ...{
                  SliverToBoxAdapter(
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
                            Image.asset('images/icon_apple_blue.png'),
                            Expanded(
                              child: state.productCategory.fold(
                                (l) {
                                  return Text(
                                    'اطلاعات محصول',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: CustomColor.blue,
                                        fontFamily: 'SB',
                                        fontSize: 20),
                                  );
                                },
                                (productCategory) {
                                  return Text(
                                    productCategory.title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: CustomColor.blue,
                                        fontFamily: 'SB',
                                        fontSize: 20),
                                  );
                                },
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Image.asset('images/icon_back.png'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                },
                if (state is ProductResponseState) ...{
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 20,
                      ),
                      child: Text(
                        parentWidget.product.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'SB',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                },
                if (state is ProductResponseState) ...{
                  state.listProductImage.fold((l) {
                    return SliverToBoxAdapter(
                      child: Text(l),
                    );
                  }, (productImageList) {
                    return ProductGallery(
                        parentWidget.product.thumbnail, productImageList);
                  })
                },
                if (state is ProductResponseState) ...{
                  state.productVariant.fold((l) {
                    return SliverToBoxAdapter(
                      child: Text(l),
                    );
                  }, ((productVariantList) {
                    return VariantContainerGenerator(productVariantList);
                  })
                      // myself code that works perfectly
                      //   (variantTypeList) {
                      //     var type = variantTypeList.where((element) {
                      //       return element.type == VariantTypeEnum.Color;
                      //     }).toList();
                      //     return ColorVariant(type.single);
                      //   },
                      ),
                },
                if (state is ProductResponseState) ...{
                  state.productProperties.fold(
                    (l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    },
                    (propertiesList) {
                      return TechnicalProperties(propertiesList);
                    },
                  ),
                },
                if (state is ProductResponseState) ...{
                  ProductDescription(parentWidget.product.description),
                },
                if (state is ProductResponseState) ...{
                  SliverToBoxAdapter(
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 44, right: 44, top: 24),
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 2,
                          color: CustomColor.gery,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Image.asset('images/icon_left_categroy.png'),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'مشاهده',
                              style: TextStyle(
                                fontFamily: 'SB',
                                color: CustomColor.blue,
                              ),
                            ),
                            const Spacer(),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: 26,
                                  width: 26,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.red,
                                  ),
                                ),
                                Positioned(
                                  right: 15,
                                  child: Container(
                                    height: 26,
                                    width: 26,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 30,
                                  child: Container(
                                    height: 26,
                                    width: 26,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.yellow,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 45,
                                  child: Container(
                                    height: 26,
                                    width: 26,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 60,
                                  child: Container(
                                    height: 26,
                                    width: 26,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '+10',
                                        style: TextStyle(
                                          fontFamily: 'SB',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              ':  نظرات کاربران',
                              style: TextStyle(
                                fontFamily: 'SB',
                                color: CustomColor.gery,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                },
                if (state is ProductResponseState) ...{
                  SliverPadding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                      left: 20,
                      right: 10,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          DiscountBasket(),
                          BuyingBasket(parentWidget.product),
                        ],
                      ),
                    ),
                  ),
                },
              ],
            );
          }),
        ),
      ),
    );
  }
}

class TechnicalProperties extends StatefulWidget {
  final List<Properties> propertiesList;
  const TechnicalProperties(
    this.propertiesList, {
    Key? key,
  }) : super(key: key);

  @override
  State<TechnicalProperties> createState() => _TechnicalPropertiesState();
}

class _TechnicalPropertiesState extends State<TechnicalProperties> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                visible = !visible;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(left: 44, right: 44, top: 24),
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 2,
                  color: CustomColor.gery,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Image.asset('images/icon_left_categroy.png'),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'مشاهده',
                      style: TextStyle(
                        fontFamily: 'SB',
                        color: CustomColor.blue,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      ': مشخصات فنی',
                      style: TextStyle(
                        fontFamily: 'SB',
                        color: CustomColor.gery,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: visible,
            child: Container(
              margin: const EdgeInsets.only(left: 44, right: 44, top: 24),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 2,
                  color: CustomColor.gery,
                ),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.propertiesList.length,
                itemBuilder: (context, index) {
                  var property = widget.propertiesList[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          '${property.title} :  ${property.value}',
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            height: 2,
                            fontFamily: 'SB',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDescription extends StatefulWidget {
  final String description;
  const ProductDescription(
    this.description, {
    Key? key,
  }) : super(key: key);

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(left: 44, right: 44, top: 24),
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 2,
                  color: CustomColor.gery,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Image.asset('images/icon_left_categroy.png'),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'مشاهده',
                      style: TextStyle(
                        fontFamily: 'SB',
                        color: CustomColor.blue,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      ':  توضیحات محصول',
                      style: TextStyle(
                        fontFamily: 'SB',
                        color: CustomColor.gery,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Container(
              margin: const EdgeInsets.only(left: 44, right: 44, top: 24),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 2,
                  color: CustomColor.gery,
                ),
              ),
              child: Text(
                widget.description,
                style: TextStyle(
                  height: 2,
                  fontFamily: 'sb',
                  fontSize: 16,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VariantContainerGenerator extends StatelessWidget {
  final List<ProductVariant> productVariantList;

  const VariantContainerGenerator(
    this.productVariantList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          for (var productVariant in productVariantList) ...{
            if (productVariant.variantList.isNotEmpty) ...{
              VariantContainerChild(productVariant)
            }
          }
        ],
      ),
    );
  }
}

class VariantContainerChild extends StatelessWidget {
  final ProductVariant productVariant;
  const VariantContainerChild(this.productVariant, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 44,
        top: 20,
        right: 44,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            productVariant.variantType.title,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontFamily: 'SM',
              color: CustomColor.gery,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (productVariant.variantType.type == VariantTypeEnum.Color) ...{
            ColorVariantList(productVariant.variantList)
          },
          if (productVariant.variantType.type == VariantTypeEnum.Storage) ...{
            StorageVariantList(productVariant.variantList)
          }
        ],
      ),
    );
  }
}

class ProductGallery extends StatefulWidget {
  final String defaultProductThumbnail;
  final List<ProductImage> productImageList;
  int selectedItem = 0;
  ProductGallery(
    this.defaultProductThumbnail,
    this.productImageList, {
    Key? key,
  }) : super(key: key);

  @override
  State<ProductGallery> createState() => _ProductGalleryState();
}

class _ProductGalleryState extends State<ProductGallery> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 44,
        ),
        child: Container(
          height: 284,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 14,
                    right: 14,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset('images/icon_star.png'),
                          const SizedBox(
                            width: 2,
                          ),
                          const Text(
                            '4.6',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'SB',
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                          height: 200,
                          width: 200,
                          child: CachedImage(
                            imageUrl: (widget.productImageList.isEmpty)
                                ? widget.defaultProductThumbnail
                                : widget.productImageList[widget.selectedItem]
                                    .imageUrl,
                          )),
                      const Spacer(),
                      Image.asset('images/icon_favorite_deactive.png'),
                    ],
                  ),
                ),
              ),
              if (widget.productImageList.isNotEmpty) ...{
                SizedBox(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 44,
                    ),
                    child: ListView.builder(
                      itemCount: widget.productImageList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.selectedItem = index;
                            });
                          },
                          child: Container(
                            height: 70,
                            width: 70,
                            margin: const EdgeInsets.only(left: 20),
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              border: Border.all(
                                width: 2,
                                color: CustomColor.gery,
                              ),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: CachedImage(
                                  imageUrl:
                                      widget.productImageList[index].imageUrl,
                                  radius: 10,
                                )),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}

class BuyingBasket extends StatelessWidget {
  final Product product;
  const BuyingBasket(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: 60,
          width: 140,
          decoration: BoxDecoration(
            color: CustomColor.blue,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        GestureDetector(
          onTap: () async {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 15,
                sigmaY: 15,
              ),
              child: GestureDetector(
                onTap: () {
                  context.read<ProductBloc>().add(ProductBasketEvent(product));
                  context.read<BasketBloc>().add(BasketFetchHiveEvent());
                },
                child: Container(
                  height: 53,
                  width: 170,
                  color: Colors.transparent,
                  child: const Center(
                    child: Text(
                      'افزودن به سبد خرید',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DiscountBasket extends StatelessWidget {
  const DiscountBasket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: 60,
          width: 140,
          decoration: BoxDecoration(
            color: CustomColor.green,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 15,
              sigmaY: 15,
            ),
            child: Container(
              height: 53,
              width: 170,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Text(
                      'تومان',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SB',
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '49,000,000',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SB',
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '48,000,000',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SB',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: CustomColor.red,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 3,
                        ),
                        child: Text(
                          '3%',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'SB',
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ColorVariantList extends StatefulWidget {
  final List<Variant> variantList;
  const ColorVariantList(this.variantList, {Key? key}) : super(key: key);

  @override
  State<ColorVariantList> createState() => _ColorVariantListState();
}

class _ColorVariantListState extends State<ColorVariantList> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 30,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.variantList.length,
          itemBuilder: (context, index) {
            String categoryColor = 'ff${widget.variantList[index].value}';
            int hexColor = int.parse(categoryColor, radix: 16);
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                height: 30,
                width: 30,
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  border: _selectedIndex == index
                      ? Border.all(
                          width: 2,
                          color: CustomColor.blue,
                          strokeAlign: BorderSide.strokeAlignOutside)
                      : Border.all(
                          width: 1,
                          color: Colors.white,
                        ),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(hexColor),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class StorageVariantList extends StatefulWidget {
  final List<Variant> storageList;
  const StorageVariantList(this.storageList, {Key? key}) : super(key: key);

  @override
  State<StorageVariantList> createState() => _StorageVariantListState();
}

class _StorageVariantListState extends State<StorageVariantList> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.storageList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                height: 25,
                decoration: BoxDecoration(
                  border: _selectedIndex == index
                      ? Border.all(
                          color: CustomColor.blue,
                          width: 4,
                        )
                      : Border.all(
                          color: CustomColor.gery,
                          width: 1,
                        ),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Text(
                      widget.storageList[index].value,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
