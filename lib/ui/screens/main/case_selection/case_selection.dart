import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/case_selection/case_selection_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_bar.dart';
import 'package:lynerdoctor/ui/widgets/app_progress_view.dart';

class CaseSelectionScreen extends StatelessWidget {
  const CaseSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: appbarWithIcons(
        centerTitle: false,
        title: Text(
          LocaleKeys.caseSelection.translateText,
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
        rightIcon: Assets.icons.icLynerAddPatient
            .svg(
          height: !isTablet ? 28.h : 35.h,
        )
            .onClick(
          () {
            Get.toNamed(Routes.addCaseSelection);
          },
        ).paddingOnly(right: 15),
      ),
      body: GetBuilder<CaseSelectionController>(
        builder: (CaseSelectionController ctrl) {
          return Stack(
            children: [
              ListView.separated(
                padding: EdgeInsets.only(left: 20, right: 20, top: 24),
                itemCount: 0,
                separatorBuilder: (BuildContext context, int index) =>
                    12.space(),
                itemBuilder: (BuildContext context, int index) {},
              ),
              ctrl.isLoading ? AppProgressView() : Container()
            ],
          );
        },
      ),
    );
  }
}
