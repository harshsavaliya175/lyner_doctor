import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/model/reports_estimation.dart';
import 'package:lynerdoctor/ui/screens/main/devis/devis_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_progress_view.dart';

import '../../../../generated/locale_keys.g.dart';

class ReportListScreen extends StatelessWidget {
  final DevisController ctrl = Get.put(DevisController());

  ReportListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: appBgColor,
          appBar: AppBar(
            toolbarHeight: 70,
            centerTitle: false,
            title: Text(
              "Créer un devis",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: Assets.fonts.maax,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: !isTablet ? 20 : 22,
              ),
            ),
            leading: Assets.icons.icBack
                .svg(
                  height: 35,
                  width: 35,
                  fit: !isTablet ? BoxFit.scaleDown : BoxFit.fill,
                )
                .paddingOnly(
                  left: 10,
                  top: isTablet ? 22 : 2,
                  bottom: isTablet ? 22 : 0,
                  right: 10,
                )
                .onClick(
              () {
                Get.back();
              },
            ),
            backgroundColor: Colors.white,
            shadowColor: Colors.grey[300],
            titleSpacing: 1,
            elevation: 0.5,
            scrolledUnderElevation: 0,
          ),
          body: GetBuilder<DevisController>(builder: (ctrl) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      12.space(),
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: ctrl.getEstimationReportList.length,
                        padding: EdgeInsets.only(bottom: 150, top: 6),
                        itemBuilder: (BuildContext context, int index) {
                          EstimateQuotesData? data =
                              ctrl.getEstimationReportList[index];
                          return Container(
                              width: Get.width,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(color: skyColor),
                                  boxShadow: [
                                    // BoxShadow(
                                    //   color: primaryBrown.withOpacity(0.4),
                                    //   spreadRadius:1,
                                    //   blurRadius: 9
                                    // )
                                  ]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(Assets.icons.icWordFile.path,
                                          height: 40, width: 40)
                                      .paddingOnly(right: 12),
                                  Expanded(
                                    child: "${data?.estimateQuoteTittle ?? ""}"
                                        .appCommonText(
                                      weight: FontWeight.w400,
                                      color: blackColor,
                                      size: !isTablet ? 16 : 20,
                                      align: TextAlign.start,
                                      maxLine: 2,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: SvgPicture.asset(
                                            Assets.icons.icEye.path,
                                            height: 14,
                                            color: primaryBrown,
                                            width: 21)
                                        .paddingOnly(right: 5),
                                  ).onClick(
                                    () {
                                      ctrl.onShowTap(data?.fileName ?? "");
                                    },
                                  ).paddingOnly(left: 5)
                                ],
                              ).paddingSymmetric(horizontal: 20, vertical: 20));
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            12.space(),
                      ),
                    ],
                  ),
                ),
                ctrl.isLoading ? AppProgressView() : Container()
              ],
            );
          }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // context.showAppBottomSheet(
              //   contentWidget: AddNewPatientBottomSheet(),
              // );
              Get.toNamed(Routes.devisScreen, arguments: null);
            },
            child: Icon(Icons.add, size: 40, color: whiteColor),
            heroTag: Object(),
            shape: CircleBorder(),
            backgroundColor: primaryBrown,
          ),
        ),
      ],
    );
  }
}
