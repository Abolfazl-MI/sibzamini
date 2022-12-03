import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sibzamini/gen/assets.gen.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Transform.scale(
            scale: 0.5, child: Lottie.asset(Assets.lotties.loading)));
  }
}
