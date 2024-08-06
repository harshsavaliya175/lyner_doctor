import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/widgets/app_bar.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: appbarWithIcons(
        centerTitle: false,
        title: Text(
          LocaleKeys.library.translateText,
          style: TextStyle(
              fontFamily: Assets.fonts.maax,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: !isTablet ? 20 : 25),
        ),
        backgroundColor: Colors.white,
        leadingWidth: 5,
        leading: SizedBox(),
        elevation: 0.5,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const PageScrollPhysics(),
        itemBuilder: (builder, index) {
          return Container(
            height: !isTablet ? 80 : 90,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: skyColor),
            ),
            child: Row(
              children: [
                3.space(),
                Assets.icons.icPdfFile
                    .image(
                        height: !isTablet ? 40 : 55, width: !isTablet ? 40 : 55)
                    .paddingOnly(right: 5),
                Expanded(
                  child: "How to Wear and Care for Your Aligner".appCommonText(
                      size: !isTablet ? 16 : 19,
                      weight: FontWeight.w400,
                      color: blackColor,
                      maxLine: 2,
                      overflow: TextOverflow.ellipsis,
                      align: TextAlign.start),
                ),
                Assets.icons.icRight.svg(height: !isTablet ? 15:20).paddingOnly(left: 5)
              ],
            ),
          ).paddingSymmetric(vertical: 5);
        },
        itemCount: 10,
      ).paddingSymmetric(horizontal: 15).paddingOnly(top: 15),
    );
  }
}
