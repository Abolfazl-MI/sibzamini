

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sibzamini/core/error_code.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/views/global/constants/app_text_themes.dart';

class ErrorScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 0.9,
            child: Lottie.asset(Assets.lotties.error)), 
          Text(SOMETHING_WENT_WRONG,
          
            style: AppTextTheme.caption.copyWith(
              fontWeight: FontWeight.bold
            )), 
            Container(height: 40,)
        ],
      ),
    );
  }
}