import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sibzamini/controller/splash/splash_controller.dart';
import 'package:sibzamini/gen/assets.gen.dart';

class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 1.5,
              child: Image.asset(Assets.icons.logo.path),
            ),
            SizedBox(
              height: 30,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
