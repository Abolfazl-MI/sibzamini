import 'package:flutter/painting.dart';
import 'package:sibzamini/gen/fonts.gen.dart';
import 'package:sibzamini/views/views.dart';

class AppTextTheme {
  static const TextStyle baseStyle = TextStyle(
      color: SolidColors.textColor3,
      fontSize: 15,
      fontFamily: FontFamily.yekanBakh);
  static const TextStyle header = TextStyle(
      color: SolidColors.textColor3,
      fontSize: 30,
      fontWeight: FontWeight.bold,
      fontFamily: FontFamily.yekanBakh);
  static const TextStyle caption = TextStyle(
      color: SolidColors.textColor3,
      fontFamily: FontFamily.yekanBakh,
      fontSize: 20);

      static const TextStyle subCaption = TextStyle(
      color: SolidColors.textColor3,
      fontFamily: FontFamily.yekanBakh,
      fontSize: 14);

       static const TextStyle captionBold = TextStyle(
      color: SolidColors.textColor3,
      fontFamily: FontFamily.yekanBakh,
      fontWeight: FontWeight.bold,
      fontSize: 20);

}
