import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import '../../gen/assets.gen.dart';



class HomeImage extends StatelessWidget {
final double? height;
final double? width;
final double size;
final ImageType type;
final String path;
final BoxShape shape;
final BoxFit? fit;
final Color? color;
final BorderRadius radius;

  HomeImage(
    this.height,
    this.width,
    this.size,
    this.type,
    this.path,
    this.shape,
    this.fit,
    this.radius, {
    this.color,
    super.key,
  });

  factory HomeImage.fileImage({
    required String path,
    double? size,
    double? height,
    double? width,
    BoxShape? shape,
    BoxFit? fit,
    BorderRadius? radius,
  }) {
    return HomeImage(
      height,
      width,
      size ?? 20,
      ImageType.file,
      path,
      shape ?? BoxShape.circle,
      fit,
      radius ?? BorderRadius.circular(0),
    );
  }

  factory HomeImage.networkImage({
    required String path,
    double? size,
    double? height,
    double? width,
    BoxShape? shape,
    BoxFit? fit,
    BorderRadius? radius,
  }) {
    return HomeImage(
      height,
      width,
      size ?? 80,
      ImageType.Netwrok,
      path,
      shape ?? BoxShape.circle,
      fit,
      radius ?? BorderRadius.circular(0),
    );
  }

  factory HomeImage.assetImage({
    required String path,
    double? size,
    double? height,
    double? width,
    BoxShape? shape,
    BoxFit? fit,
    Color? color,
    BorderRadius? radius,
  }) {
    return HomeImage(
      height,
      width,
      size ?? 20,
      ImageType.Asset,
      path,
      shape ?? BoxShape.circle,
      fit,
      radius ?? BorderRadius.circular(0),
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (path.trim().isEmpty) {
      return shape == BoxShape.rectangle
          ? ClipRRect(
              borderRadius: radius,
              child: Image.asset(
                Assets.images.imgUserPlaceholder.path,
                height: height ?? size,
                width: width ?? size,
                fit: fit,
                color: color,
              ),
            )
          : ClipOval(
              child: Image.asset(
                Assets.images.imgUserPlaceholder.path,
                height: height ?? size,
                width: width ?? size,
                fit: fit,
                color: color,
              ),
            );
    }

    if (type == ImageType.Netwrok) {
      return CachedNetworkImage(
        imageUrl: path,
        fit: fit,
        imageBuilder: (context, imageprovider) {
          return Container(
            height: height ?? size,
            width: width ?? size,
            decoration: shape == BoxShape.circle
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageprovider,
                      fit: fit,
                    ),
                  )
                : BoxDecoration(
                    borderRadius: radius,
                    image: DecorationImage(
                      image: imageprovider,
                      fit: fit,
                    ),
                  ),
          );
        },
        placeholder: (context, url) => Container(
          height: height ?? size,
          width: width ?? size,
          child: Center(
            child: CupertinoActivityIndicator(
              radius: size / 4,
            ),
          ),
        ),
        errorWidget: (context, url, error) {
          return shape == BoxShape.rectangle
              ? ClipRRect(
                  borderRadius: radius,
                  child: Image.asset(
                    Assets.images.imgUserPlaceholder.path,
                    height: height ?? size,
                    width: width ?? size,
                    fit: fit,
                    color: color,
                  ),
                )
              : ClipOval(
                  child: Image.asset(
                    Assets.images.imgUserPlaceholder.path,
                    height: height ?? size,
                    width: width ?? size,
                    fit: fit,
                    color: color,
                  ),
                );
        },
      );
    }

    if (type == ImageType.Asset) {
      return shape == BoxShape.circle
          ? ClipOval(
              child: Image.asset(
                path,
                height: height ?? size,
                width: width ?? size,
                fit: fit,
                color: color,
              ),
            )
          : ClipRRect(
              borderRadius: radius,
              child: Image.asset(
                path,
                height: height ?? size,
                width: width ?? size,
                fit: fit,
                color: color,
              ),
            );
    }

    if (type == ImageType.file) {
      return shape == BoxShape.circle
          ? ClipOval(
              child: Image.file(
                File(path),
                height: height ?? size,
                width: width ?? size,
                fit: fit,
              ),
            )
          : ClipRRect(
              borderRadius: radius,
              child: Image.file(
                File(path),
                height: height ?? size,
                width: width ?? size,
                fit: fit,
              ),
            );
    }

    return Container();
  }
}

enum ImageType { Asset, Netwrok, file }
