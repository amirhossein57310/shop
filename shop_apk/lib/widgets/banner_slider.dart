import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shop_apk/constants/colors.dart';
import 'package:shop_apk/data/model/banner.dart';
import 'package:shop_apk/widgets/cached_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  final List<Banners> list;
  const BannerSlider(this.list, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = PageController(viewportFraction: 0.9);
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          height: 177,
          child: PageView.builder(
            controller: controller,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                ),
                child: CachedImage(
                  imageUrl: list[index].thumbnail,
                  radius: 15,
                ),
              );
            },
            itemCount: list.length,
          ),
        ),
        Positioned(
          bottom: 10,
          child: SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: const ExpandingDotsEffect(
                expansionFactor: 4,
                dotHeight: 6,
                dotWidth: 6,
                dotColor: Colors.white,
                activeDotColor: CustomColor.indicatorColor),
          ),
        ),
      ],
    );
  }
}
