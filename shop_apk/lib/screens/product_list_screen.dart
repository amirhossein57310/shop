import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_apk/bloc/productCategory/product_category_bloc.dart';
import 'package:shop_apk/bloc/productCategory/product_category_event.dart';
import 'package:shop_apk/bloc/productCategory/product_category_state.dart';
import 'package:shop_apk/constants/colors.dart';
import 'package:shop_apk/data/model/categoty.dart';
import 'package:shop_apk/data/model/product.dart';
import 'package:shop_apk/widgets/product_item.dart';

class ProductListScreen extends StatefulWidget {
  Category category;
  ProductListScreen(this.category, {Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductCategoryBloc>(context)
        .add(ProductCategoryResponseEvent(widget.category.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.scaffoldColor,
      body: SafeArea(
          child: BlocBuilder<ProductCategoryBloc, ProductCategoryState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
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
                          child: Text(
                            widget.category.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: CustomColor.blue,
                                fontFamily: 'SB',
                                fontSize: 16),
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
              if (state is LoadingProductCategoryState) ...{
                const SliverToBoxAdapter(
                  child: Center(
                      child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(),
                  )),
                )
              },
              if (state is ResponseProductCategoryState) ...{
                state.productList.fold((l) {
                  return SliverToBoxAdapter(
                    child: Text(l),
                  );
                }, (productList) {
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return ProductItem(productList[index]);
                        },
                        childCount: productList.length,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 30,
                        crossAxisSpacing: 30,
                        childAspectRatio: 2 / 2.7,
                      ),
                    ),
                  );
                })
              },
            ],
          );
        },
      )),
    );
  }
}
