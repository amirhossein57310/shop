import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../constants/colors.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Center(
        child: LoadingIndicator(
          indicatorType: Indicator.ballRotateChase,
          colors: const [CustomColor.blue],
          strokeWidth: 2,
        ),
      ),
    );
  }
}
