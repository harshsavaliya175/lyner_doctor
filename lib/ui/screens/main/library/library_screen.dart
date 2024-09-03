import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/home_image.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/model/library_list_model.dart';
import 'package:lynerdoctor/ui/screens/main/library/library_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_bar.dart';
import 'package:lynerdoctor/ui/widgets/app_progress_view.dart';

class LibraryScreen extends StatelessWidget {
  LibraryScreen({super.key});

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
      body: GetBuilder<LibraryController>(
        builder: (LibraryController ctrl) {
          return Stack(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const PageScrollPhysics(),
                itemCount: ctrl.libraryListData.length,
                itemBuilder: (BuildContext builder, int index) {
                  LibraryListData libraryData = ctrl.libraryListData[index];
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
                        libraryData.isYoutube == 1 ? 0.space() : 3.space(),
                        HomeImage.assetImage(
                                path: getFileIcon(libraryData.isYoutube),
                                height: !isTablet
                                    ? libraryData.isYoutube == 1
                                        ? 43
                                        : 45
                                    : 60,
                                shape: BoxShape.rectangle,
                                width: !isTablet
                                    ? libraryData.isYoutube == 1
                                        ? 43
                                        : 45
                                    : 60)
                            .paddingOnly(
                                right: libraryData.isYoutube == 1 ? 8 : 5),
                        Expanded(
                          child: (libraryData.title ?? '').appCommonText(
                              size: !isTablet ? 16 : 19,
                              weight: FontWeight.w400,
                              color: blackColor,
                              maxLine: 2,
                              overflow: TextOverflow.ellipsis,
                              align: TextAlign.start),
                        ),
                        Assets.icons.icRight
                            .svg(height: !isTablet ? 15 : 20)
                            .paddingOnly(left: 5)
                      ],
                    ),
                  ).onTap(
                    () {
                      if (libraryData.isYoutube == 0) {
                        ctrl.loadPdfFromUrl(
                            "${ApiUrl.lynerLibraryUrl}${libraryData.file}");
                      } else if (libraryData.isYoutube == 1) {
                        ctrl.loadYoutubeUrl(libraryData.youtubeLink ?? '');
                      }
                    },
                  ).paddingSymmetric(vertical: 5);
                },
              ).paddingSymmetric(horizontal: 15).paddingOnly(top: 15),
              ctrl.isLoading
                  ? AppProgressView(progressColor: primaryBrown)
                  : Container()
            ],
          );
        },
      ),
    );
  }
}
