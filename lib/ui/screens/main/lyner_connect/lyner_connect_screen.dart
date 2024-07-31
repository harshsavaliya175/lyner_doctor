import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/ui/widgets/app_bar.dart';

class LynerConnectScreen extends StatelessWidget {
  const LynerConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: appbarWithIcons(
        centerTitle: false,
        title: Text(
          "Lyner connect",
          style: TextStyle(
              fontFamily: Assets.fonts.maax,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: 20),
        ),
        backgroundColor: Colors.white,
        leadingWidth: 40,
        leading: Assets.icons.icBack
            .svg(
          height: 25,
          width: 25,
          fit: BoxFit.scaleDown,
        )
            .paddingOnly(
          left: 10,
        )
            .onClick(() {
          Get.back();
        }),
      ),
      body: Center(
        child: Text('Lyner Connect Screen'),
      ),
    );
  }
}
