/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/maax-black.ttf
  String get maaxBlack => 'assets/fonts/maax-black.ttf';

  /// File path: assets/fonts/maax-bold.ttf
  String get maaxBold => 'assets/fonts/maax-bold.ttf';

  /// File path: assets/fonts/maax-bolditalic.ttf
  String get maaxBolditalic => 'assets/fonts/maax-bolditalic.ttf';

  /// File path: assets/fonts/maax-italic.ttf
  String get maaxItalic => 'assets/fonts/maax-italic.ttf';

  /// File path: assets/fonts/maax-medium.ttf
  String get maaxMedium => 'assets/fonts/maax-medium.ttf';

  /// File path: assets/fonts/maax-mediumitalic.ttf
  String get maaxMediumitalic => 'assets/fonts/maax-mediumitalic.ttf';

  /// File path: assets/fonts/maax.ttf
  String get maax => 'assets/fonts/maax.ttf';

  /// List of all assets
  List<String> get values => [
        maaxBlack,
        maaxBold,
        maaxBolditalic,
        maaxItalic,
        maaxMedium,
        maaxMediumitalic,
        maax
      ];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/Mail.svg
  SvgGenImage get mail => const SvgGenImage('assets/icons/Mail.svg');

  /// File path: assets/icons/User.svg
  SvgGenImage get user => const SvgGenImage('assets/icons/User.svg');

  /// File path: assets/icons/clinic.svg
  SvgGenImage get clinic => const SvgGenImage('assets/icons/clinic.svg');

  /// File path: assets/icons/close_eye.svg
  SvgGenImage get closeEye => const SvgGenImage('assets/icons/close_eye.svg');

  /// File path: assets/icons/ic_back.svg
  SvgGenImage get icBack => const SvgGenImage('assets/icons/ic_back.svg');

  /// File path: assets/icons/ic_document.svg
  SvgGenImage get icDocument =>
      const SvgGenImage('assets/icons/ic_document.svg');

  /// File path: assets/icons/ic_down.svg
  SvgGenImage get icDown => const SvgGenImage('assets/icons/ic_down.svg');

  /// File path: assets/icons/ic_select.svg
  SvgGenImage get icSelect => const SvgGenImage('assets/icons/ic_select.svg');

  /// File path: assets/icons/lock.svg
  SvgGenImage get lock => const SvgGenImage('assets/icons/lock.svg');

  /// File path: assets/icons/open_eye.svg
  SvgGenImage get openEye => const SvgGenImage('assets/icons/open_eye.svg');

  /// File path: assets/icons/phone.svg
  SvgGenImage get phone => const SvgGenImage('assets/icons/phone.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        mail,
        user,
        clinic,
        closeEye,
        icBack,
        icDocument,
        icDown,
        icSelect,
        lock,
        openEye,
        phone
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/img_face.png
  AssetGenImage get imgFace =>
      const AssetGenImage('assets/images/img_face.png');

  /// File path: assets/images/img_inter_face.png
  AssetGenImage get imgInterFace =>
      const AssetGenImage('assets/images/img_inter_face.png');

  /// File path: assets/images/img_inter_left.png
  AssetGenImage get imgInterLeft =>
      const AssetGenImage('assets/images/img_inter_left.png');

  /// File path: assets/images/img_inter_right.png
  AssetGenImage get imgInterRight =>
      const AssetGenImage('assets/images/img_inter_right.png');

  /// File path: assets/images/img_intra_mand.png
  AssetGenImage get imgIntraMand =>
      const AssetGenImage('assets/images/img_intra_mand.png');

  /// File path: assets/images/img_intra_max.png
  AssetGenImage get imgIntraMax =>
      const AssetGenImage('assets/images/img_intra_max.png');

  /// File path: assets/images/img_profile.png
  AssetGenImage get imgProfile =>
      const AssetGenImage('assets/images/img_profile.png');

  /// File path: assets/images/img_smile.png
  AssetGenImage get imgSmile =>
      const AssetGenImage('assets/images/img_smile.png');

  /// File path: assets/images/img_splash.svg
  SvgGenImage get imgSplash =>
      const SvgGenImage('assets/images/img_splash.svg');

  /// File path: assets/images/img_tab.png
  AssetGenImage get imgTab => const AssetGenImage('assets/images/img_tab.png');

  /// File path: assets/images/img_user_placeholder.png
  AssetGenImage get imgUserPlaceholder =>
      const AssetGenImage('assets/images/img_user_placeholder.png');

  /// List of all assets
  List<dynamic> get values => [
        imgFace,
        imgInterFace,
        imgInterLeft,
        imgInterRight,
        imgIntraMand,
        imgIntraMax,
        imgProfile,
        imgSmile,
        imgSplash,
        imgTab,
        imgUserPlaceholder
      ];
}

class $AssetsJsonGen {
  const $AssetsJsonGen();

  /// File path: assets/json/lyner_cases.json
  String get lynerCases => 'assets/json/lyner_cases.json';

  /// List of all assets
  List<String> get values => [lynerCases];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/en.json
  String get en => 'assets/translations/en.json';

  /// List of all assets
  List<String> get values => [en];
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsJsonGen json = $AssetsJsonGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
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

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final BytesLoader loader;
    if (_isVecFormat) {
      loader = AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
