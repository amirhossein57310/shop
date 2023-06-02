import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_apk/bloc/basket/basket_bloc.dart';
import 'package:shop_apk/bloc/product/product_bloc.dart';
import 'package:shop_apk/constants/colors.dart';
import 'package:shop_apk/data/model/product.dart';
import 'package:shop_apk/screens/product_detail_screen.dart';
import 'package:shop_apk/widgets/cached_image.dart';

import '../di/di.dart';

class ProductItem extends StatelessWidget {
  Product product;
  ProductItem(
    this.product, {
    Key? key,
  }) : super(key: key);

  Object? get imageUrl => null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: ((context) => BlocProvider<BasketBloc>.value(
                value: locator.get<BasketBloc>(),
                child: ProductDetailScreen(product),
              )),
        ));
      },
      child: Container(
        height: 216,
        width: 190,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(),
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CachedImage(
                    imageUrl: product.thumbnail,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 10,
                  child: SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset('images/active_fav_product.png')),
                ),
                Positioned(
                  bottom: 0,
                  left: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: CustomColor.red,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 6,
                      ),
                      child: Text(
                        '${product.percent!.round()}  %',
                        style: TextStyle(
                          fontFamily: 'SB',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 10,
                      right: 10,
                    ),
                    child: Text(
                      product.name,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    height: 53,
                    decoration: const BoxDecoration(
                      color: CustomColor.blue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: CustomColor.blue,
                          blurRadius: 25,
                          spreadRadius: -12,
                          offset: Offset(0, 15),
                        ),
                      ],
                    ),
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
                            children: [
                              Text(
                                product.price.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'SB',
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                product.realPrice.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'SB',
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Image.asset(
                                'images/icon_right_arrow_cricle.png'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static jsonObject(jsonObject) {}
}
