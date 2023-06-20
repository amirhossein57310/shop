import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_apk/bloc/productCategory/product_category_bloc.dart';
import 'package:shop_apk/data/model/categoty.dart';
import 'package:shop_apk/di/di.dart';

import 'package:shop_apk/screens/product_list_screen.dart';
import 'package:shop_apk/widgets/cached_image.dart';

class HorizontalItem extends StatelessWidget {
  final Category category;

  const HorizontalItem(
    this.category, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String categoryColor = 'ff${category.color}';
    int hexColor = int.parse(categoryColor, radix: 16);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: ((context) => BlocProvider(
                create: (context) => ProductCategoryBloc(locator.get()),
                child: ProductListScreen(category))),
          ),
        );
      },
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: ShapeDecoration(
                  shadows: [
                    BoxShadow(
                      color: Color(hexColor),
                      blurRadius: 25,
                      spreadRadius: -10,
                      offset: Offset(0.0, 15),
                    ),
                  ],
                  color: Color(hexColor),
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
                width: 24,
                child: Center(
                  child: CachedImage(
                    imageUrl: category.icon,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            category.title,
            style: const TextStyle(fontFamily: 'SB'),
          ),
        ],
      ),
    );
  }
}
