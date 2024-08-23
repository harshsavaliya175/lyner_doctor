import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/home_image.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/model/financial_model.dart';
import 'package:lynerdoctor/ui/screens/main/financial/financial_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_progress_view.dart';

class FinancialScreen extends StatelessWidget {
  const FinancialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: false,
        title: Text(
          LocaleKeys.financial.translateText,
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
                right: 10)
            .onClick(() {
          Get.back();
        }),
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[300],
        titleSpacing: 1,
        elevation: 0.5,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: appBgColor,
      body: GetBuilder<FinancialController>(
        builder: (FinancialController ctrl) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  24.space(),
                  CommonTextField(
                    prefixIcon: Assets.icons.icSearch,
                    hintText: LocaleKeys.search_financial.translateText,
                    hintTextSize: !isTablet ? 16 : 20,
                    controller: ctrl.searchController,
                    action: TextInputAction.done,
                    onChange: (String value) {},
                  ).paddingSymmetric(horizontal: 20),
                  15.space(),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        5.space(),
                        Container(
                          width: Get.width,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(color: skyColor),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LocaleKeys.clinic.translateText.normalText(
                                fontWeight: FontWeight.w500,
                                fontSize: !isTablet ? 16 : 20,
                                color: hintStepColor,
                              ),
                              6.space(),
                              (ctrl.financialModel?.clinicBillingAddresses
                                          ?.billingAddress ??
                                      "")
                                  .normalText(
                                fontWeight: FontWeight.w500,
                                fontSize: !isTablet ? 16 : 20,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                        12.space(),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (BuildContext context, int index) =>
                              12.space(),
                          itemCount:
                              ctrl.financialModel?.patientList?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            PatientList? patient =
                                ctrl.financialModel!.patientList![index];
                            return Container(
                              width: Get.width,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              padding: EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: skyColor),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      HomeImage.networkImage(
                                        path: (patient.patientProfile
                                                    ?.isNotEmpty ??
                                                false)
                                            ? ApiUrl.patientProfileImage +
                                                patient.patientProfile!
                                            : "",
                                        fit: BoxFit.cover,
                                        shape: BoxShape.circle,
                                        size: !isTablet ? 44.w : 54.w,
                                      ).paddingOnly(
                                          top: 16,
                                          left: 16,
                                          right: 12,
                                          bottom: 12),
                                      ("${patient.firstName} ${patient.lastName}")
                                          .appCommonText(
                                        weight: FontWeight.w500,
                                        size: !isTablet ? 16 : 20,
                                        maxLine: 1,
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  DottedBorder(
                                    borderType: BorderType.RRect,
                                    color: skyColor,
                                    padding: EdgeInsets.zero,
                                    radius: Radius.circular(35),
                                    dashPattern: [5, 5, 5, 5],
                                    child: Container(),
                                  ),
                                  16.space(),
                                  Row(
                                    children: [
                                      LocaleKeys.caseCom.translateText
                                          .appCommonText(
                                        weight: FontWeight.w400,
                                        size: !isTablet ? 16 : 20,
                                      ),
                                      5.space(),
                                      "${patient.caseName}".appCommonText(
                                        weight: FontWeight.w500,
                                        size: !isTablet ? 16 : 20,
                                      ),
                                    ],
                                  ).paddingSymmetric(horizontal: 16)
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ctrl.isLoading ? AppProgressView() : Container()
            ],
          );
        },
      ),
    );
  }
}
