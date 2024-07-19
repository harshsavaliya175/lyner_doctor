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

  /// File path: assets/icons/lock.svg
  SvgGenImage get lock => const SvgGenImage('assets/icons/lock.svg');

  /// File path: assets/icons/open_eye.svg
  SvgGenImage get openEye => const SvgGenImage('assets/icons/open_eye.svg');

  /// File path: assets/icons/phone.svg
  SvgGenImage get phone => const SvgGenImage('assets/icons/phone.svg');

  /// List of all assets
  List<SvgGenImage> get values =>
      [mail, user, clinic, closeEye, lock, openEye, phone];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/img_splash.svg
  SvgGenImage get imgSplash =>
      const SvgGenImage('assets/images/img_splash.svg');

  /// List of all assets
  List<SvgGenImage> get values => [imgSplash];
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
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
