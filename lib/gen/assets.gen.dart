/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/YekanBakh-Regular.ttf
  String get yekanBakhRegular => 'assets/fonts/YekanBakh-Regular.ttf';
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/Arrow-Left.svg
  String get arrowLeft => 'assets/icons/Arrow-Left.svg';

  /// File path: assets/icons/Group .svg
  String get group => 'assets/icons/Group .svg';

  /// File path: assets/icons/arrow_back_fiiled.svg
  String get arrowBackFiiled => 'assets/icons/arrow_back_fiiled.svg';

  /// File path: assets/icons/arrow_back_thin_blue.svg
  String get arrowBackThinBlue => 'assets/icons/arrow_back_thin_blue.svg';

  /// File path: assets/icons/heart .svg
  String get heart => 'assets/icons/heart .svg';

  /// File path: assets/icons/iPad.svg
  String get iPad => 'assets/icons/iPad.svg';

  /// File path: assets/icons/location.svg
  String get location => 'assets/icons/location.svg';

  /// File path: assets/icons/location_search.svg
  String get locationSearch => 'assets/icons/location_search.svg';

  /// File path: assets/icons/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/icons/logo.png');

  /// File path: assets/icons/logos.svg
  String get logos => 'assets/icons/logos.svg';

  /// File path: assets/icons/menu.svg
  String get menu => 'assets/icons/menu.svg';

  /// File path: assets/icons/menu_FILL0_wght400_GRAD0_opsz48 1.png
  AssetGenImage get menuFILL0Wght400GRAD0Opsz481 =>
      const AssetGenImage('assets/icons/menu_FILL0_wght400_GRAD0_opsz48 1.png');

  /// File path: assets/icons/search.svg
  String get search => 'assets/icons/search.svg';
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/cardbg.png
  AssetGenImage get cardbg => const AssetGenImage('assets/images/cardbg.png');

  /// File path: assets/images/modern-beauty-salon-interior 2.png
  AssetGenImage get modernBeautySalonInterior2 =>
      const AssetGenImage('assets/images/modern-beauty-salon-interior 2.png');

  /// File path: assets/images/slaon.png
  AssetGenImage get slaon => const AssetGenImage('assets/images/slaon.png');
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
