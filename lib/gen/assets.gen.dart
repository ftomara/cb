/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class Assets {
  Assets._();

  static const String add = 'assets/add.svg';
  static const String brush = 'assets/brush.svg';
  static const String colorP = 'assets/color_p.svg';
  static const String eraser = 'assets/eraser.svg';
  static const String home = 'assets/home.svg';
  static const AssetGenImage image1 = AssetGenImage('assets/image1.png');
  static const AssetGenImage image10 = AssetGenImage('assets/image10.png');
  static const AssetGenImage image11 = AssetGenImage('assets/image11.png');
  static const AssetGenImage image2 = AssetGenImage('assets/image2.png');
  static const AssetGenImage image3 = AssetGenImage('assets/image3.png');
  static const AssetGenImage image5 = AssetGenImage('assets/image5.png');
  static const AssetGenImage image6 = AssetGenImage('assets/image6.png');
  static const AssetGenImage image7 = AssetGenImage('assets/image7.png');
  static const AssetGenImage image8 = AssetGenImage('assets/image8.png');
  static const AssetGenImage image9 = AssetGenImage('assets/image9.png');
  static const AssetGenImage paint = AssetGenImage('assets/paint.png');
  static const String profile = 'assets/profile.svg';

  /// List of all assets
  static List<dynamic> get values => [
        add,
        brush,
        colorP,
        eraser,
        home,
        image1,
        image10,
        image11,
        image2,
        image3,
        image5,
        image6,
        image7,
        image8,
        image9,
        paint,
        profile
      ];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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
    bool gaplessPlayback = true,
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

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
