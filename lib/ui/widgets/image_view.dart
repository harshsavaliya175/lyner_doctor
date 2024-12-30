import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/home_image.dart';

void showImageDialog({
  required BuildContext context,
  required String imagePath,
}) {
  // Size size = context.getScreenSize;
  context.showAppDialog(
    contentWidget: BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 1,
        sigmaY: 1,
      ),
      blendMode: BlendMode.srcIn,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: HomeImage.networkImage(
            path: imagePath,
            radius: BorderRadius.circular(6),
            shape: BoxShape.rectangle,
            fit: BoxFit.cover,
            width: Get.width,
            height: Get.height * 0.7,
          ),
        ),
      ),
    ),
  );
}
