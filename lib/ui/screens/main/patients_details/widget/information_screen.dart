import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/patients_details/patients_details_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GetBuilder<PatientsDetailsController>(
          builder: (PatientsDetailsController controller) {
        return ListView(
          padding: EdgeInsets.only(top: 10, bottom: 50),
          children: [
            LocaleKeys.information.translateText
                .normalText(fontWeight: FontWeight.w600),
            12.space(),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: skyColor),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LocaleKeys.firstName.translateText.normalText(
                              fontWeight: FontWeight.w500,
                              color: hintStepColor,
                              fontSize: 16,
                            ),
                            6.space(),
                            (controller.patientDetailsModel?.firstName ?? "")
                                .normalText(
                              fontWeight: FontWeight.w500,
                              color: blackColor,
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LocaleKeys.lastName.translateText.normalText(
                              fontWeight: FontWeight.w500,
                              color: hintStepColor,
                              fontSize: 16,
                            ),
                            6.space(),
                            "Koladiya".normalText(
                              fontWeight: FontWeight.w500,
                              color: blackColor,
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  12.space(),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LocaleKeys.doctor.translateText.normalText(
                              fontWeight: FontWeight.w500,
                              color: hintStepColor,
                              fontSize: 16,
                            ),
                            6.space(),
                            "Dr. DR IB".normalText(
                              fontWeight: FontWeight.w500,
                              color: blackColor,
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LocaleKeys.dateOfBirth.translateText.normalText(
                              fontWeight: FontWeight.w500,
                              color: hintStepColor,
                              fontSize: 16,
                            ),
                            6.space(),
                            "05/11/2001".normalText(
                              fontWeight: FontWeight.w500,
                              color: blackColor,
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            12.space(),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: skyColor),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LocaleKeys.clinic.translateText.normalText(
                    fontWeight: FontWeight.w500,
                    color: hintStepColor,
                    fontSize: 16,
                  ),
                  6.space(),
                  "12 Apostles, Victoria, Australia".normalText(
                    fontWeight: FontWeight.w500,
                    color: blackColor,
                    fontSize: 16,
                  ),
                ],
              ),
            ),
            12.space(),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: skyColor),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LocaleKeys.billing.translateText.normalText(
                    fontWeight: FontWeight.w500,
                    color: hintStepColor,
                    fontSize: 16,
                  ),
                  6.space(),
                  "6391 Elgin St. Celina, Delaware 10299".normalText(
                    fontWeight: FontWeight.w500,
                    color: blackColor,
                    fontSize: 16,
                  ),
                ],
              ),
            ),
            12.space(),
            LocaleKeys.plan.translateText
                .normalText(fontWeight: FontWeight.w600),
            12.space(),
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  border: Border.all(color: skyColor),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: lightBrown,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(13),
                            topLeft: Radius.circular(13)),
                      ),
                      child: LocaleKeys.lyner_expert.translateText
                          .appCommonText(weight: FontWeight.w500, size: 20)
                          .paddingAll(15),
                    ),
                    11.space(),
                    "Analyse Orthodontiste"
                        .appCommonText(
                            weight: FontWeight.w500,
                            size: 16,
                            align: TextAlign.start)
                        .paddingSymmetric(horizontal: 15),
                    10.space(),
                    "Lyner chooses the appropriate and optimized treatment for you."
                        .appCommonText(
                            weight: FontWeight.w300,
                            size: 16,
                            color: hintColor,
                            maxLine: 2,
                            overflow: TextOverflow.ellipsis,
                            align: TextAlign.start)
                        .paddingSymmetric(horizontal: 15),
                    12.space(),
                    "Contention Included"
                        .appCommonText(weight: FontWeight.w500, size: 16)
                        .paddingSymmetric(horizontal: 15),
                    13.space(),
                  ],
                ),
              ),
            ),
            20.space(),
            LocaleKeys.link.translateText
                .normalText(fontWeight: FontWeight.w600),
            12.space(),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(13)),
                border: Border.all(color: skyColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "In-Treatment Planning".appCommonText(
                              weight: FontWeight.w500,
                              size: 16,
                              align: TextAlign.start,
                            ),
                            20.space(),
                            AppButton(
                              btnHeight: 45,
                              btnWidth: 125,
                              bgColor: primaryBrown,
                              fontColor: whiteColor,
                              fontSize: 16,
                              weight: FontWeight.w600,
                              text: LocaleKeys.approved.translateText,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      Assets.icons.icTeethWithScreen.svg(height: 50, width: 50),
                    ],
                  ).paddingAll(20),
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: lightBrown,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(13),
                        topLeft: Radius.circular(13),
                      ),
                    ),
                    child: "2024-07-05"
                        .appCommonText(
                          weight: FontWeight.w600,
                          size: 16,
                          color: primaryBrown,
                        )
                        .paddingAll(12),
                  ),
                ],
              ),
            ),
            20.space(),
            LocaleKeys.photos.translateText
                .normalText(fontWeight: FontWeight.w600),
            12.space(),
            Row(
              children: [
                Expanded(
                  child:
                      photoWithTitle(title: LocaleKeys.profile.translateText),
                ),
                isTablet ? 60.space() : 10.space(),
                Expanded(
                  child: photoWithTitle(title: LocaleKeys.face.translateText),
                ),
                isTablet ? 60.space() : 10.space(),
                Expanded(
                  child: photoWithTitle(title: LocaleKeys.smile.translateText),
                ),
              ],
            ),
            16.space(),
            Row(
              children: [
                Expanded(
                  child: photoWithTitle(title: "Intra Max"),
                ),
                isTablet ? 60.space() : 10.space(),
                Expanded(child: SizedBox()),
                isTablet ? 60.space() : 10.space(),
                Expanded(
                  child: photoWithTitle(title: "Intra Mand"),
                ),
              ],
            ),
            16.space(),
            Row(
              children: [
                Expanded(
                  child: photoWithTitle(title: "Inter Right"),
                ),
                isTablet ? 60.space() : 10.space(),
                Expanded(
                  child: photoWithTitle(title: "Inter Face"),
                ),
                isTablet ? 60.space() : 10.space(),
                Expanded(
                  child: photoWithTitle(title: "Inter Left"),
                ),
              ],
            ),
            20.space(),
            LocaleKeys.photos.translateText
                .normalText(fontWeight: FontWeight.w600),
            12.space(),
            Row(
              children: [
                Expanded(
                  child: photoWithTitle(
                    title: "Panoramique",
                    photoHeight: isTablet ? 180 : 125,
                    photoWidth: Get.width,
                  ),
                ),
                isTablet ? 40.space() : 16.space(),
                Expanded(
                  child: photoWithTitle(
                    title: "Cephalométrique",
                    photoHeight: isTablet ? 180 : 125,
                    photoWidth: Get.width,
                  ),
                ),
              ],
            ),
            20.space(),
            LocaleKeys.stlFile.translateText
                .normalText(fontWeight: FontWeight.w600),
            12.space(),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: primaryBrown.withOpacity(0.2),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: primaryBrown,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: "Posted By 3shape".normalText(
                      fontWeight: FontWeight.w500,
                      color: primaryBrown,
                      fontSize: 16,
                    ),
                  ),
                  Assets.icons.icTeethWithScreen.svg()
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget photoWithTitle({
    required String title,
    double? photoHeight,
    double? photoWidth,
    // AssetGenImage? assetImage,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Assets.images.imgProfile.image(
            height: photoHeight,
            width: photoWidth,
            fit: BoxFit.cover,
          ),
        ),
        12.space(),
        title.normalText(
          fontWeight: FontWeight.w500,
          color: blackColor,
          fontSize: 16,
        ),
      ],
    );
  }
}
