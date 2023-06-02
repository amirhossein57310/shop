import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shop_apk/bloc/basket/basket_bloc.dart';
import 'package:shop_apk/bloc/basket/basket_state.dart';
import 'package:shop_apk/constants/colors.dart';
import 'package:shop_apk/util/extentions/string_extentions.dart';
import 'package:shop_apk/widgets/cached_image.dart';

import '../data/model/basket_item.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.scaffoldColor,
      body: SafeArea(
        child: BlocBuilder<BasketBloc, BasketState>(
          builder: (context, state) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                CustomScrollView(
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
                              const Expanded(
                                child: Text(
                                  'سبد خرید',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: CustomColor.blue,
                                      fontFamily: 'SB',
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (state is BasketFetchedDataState) ...{
                      state.getAllBasketItem.fold((l) {
                        return SliverToBoxAdapter(
                          child: Text(l),
                        );
                      }, (basketItem) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            ((context, index) {
                              return CardItem(basketItem[index]);
                            }),
                            childCount: basketItem.length,
                          ),
                        );
                      })
                    },
                    const SliverPadding(
                      padding: EdgeInsets.only(
                        bottom: 100,
                      ),
                    ),
                  ],
                ),
                if (state is BasketFetchedDataState) ...{
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 44,
                      right: 44,
                      bottom: 20,
                    ),
                    child: SizedBox(
                      height: 53,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColor.green,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          state.getTotalPrice == 0
                              ? 'your basket is empty'
                              : '  ${state.getTotalPrice}',
                          style: TextStyle(
                            fontFamily: 'geb',
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                },
              ],
            );
          },
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  BasketItem basketItem;
  CardItem(
    this.basketItem, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 44,
        right: 44,
        bottom: 20,
      ),
      height: 249,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          basketItem.name,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'SB',
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        const Text(
                          'گارانتی فیلان 18 ماهه',
                          style: TextStyle(fontSize: 15, fontFamily: 'SB'),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: CustomColor.red,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5,
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
                            SizedBox(
                              width: 4,
                            ),
                            const Text(
                              'تومان',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 13, fontFamily: 'SB'),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            const Text(
                              '49,000,000',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 16, fontFamily: 'SB'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Wrap(
                          spacing: 8,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: CustomColor.red,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 2,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'حدف',
                                      style: TextStyle(
                                          color: CustomColor.red,
                                          fontFamily: 'SB',
                                          fontSize: 14),
                                      textDirection: TextDirection.rtl,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Image.asset('images/icon_trash.png'),
                                  ],
                                ),
                              ),
                            ),
                            OptionCheap(
                              'امینیان',
                              color: '4287f5',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                    ),
                    child: SizedBox(
                      height: 104,
                      width: 75,
                      child: CachedImage(
                        imageUrl: basketItem.thumbnail,
                      ),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: DottedLine(
              lineThickness: 3.0,
              dashLength: 8.0,
              dashColor: CustomColor.gery.withOpacity(0.5),
              dashGapLength: 3.0,
              dashGapColor: Colors.transparent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'تومان',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 16, fontFamily: 'SB'),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  (basketItem.realPrice).toString(),
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 16, fontFamily: 'SB'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OptionCheap extends StatelessWidget {
  String title;
  String? color;
  OptionCheap(
    this.title, {
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: CustomColor.gery,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 2,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 10,
            ),
            if (color != null) ...{
              Container(
                width: 12,
                height: 12,
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color!.parseToColor(),
                ),
              )
            },
            Text(
              title,
              style: TextStyle(fontFamily: 'SB', fontSize: 14),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}
