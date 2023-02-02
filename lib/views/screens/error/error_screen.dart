import 'package:flutter/material.dart';

import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';

import 'package:sibzamini/core/error_code.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/views/global/colors/colors.dart';
import 'package:sibzamini/views/global/constants/app_text_themes.dart';
import 'package:sibzamini/views/routes/app_route_names.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // String error_code=Get.argument['error'];
    String error_code = Get.arguments['error'];
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Transform.scale(
                scale: 0.87, child: Lottie.asset(Assets.lotties.error)),
            Text(
              error_code,
              style: AppTextTheme.caption.copyWith(fontWeight: FontWeight.bold),
            ),
              InkWell(
                onTap: (){
                  Get.offAllNamed(rSplashScreen);
                },
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: SolidColors.primaryBlue,
                  ),
                  child: Center(
                    child: Text(
                      'دوباره تلاش کنید',
                      style: AppTextTheme.caption.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
