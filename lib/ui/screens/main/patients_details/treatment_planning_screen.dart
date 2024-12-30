import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/widgets/app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'patients_details_controller.dart';

class TreatmentPlanningScreen extends StatelessWidget {
  TreatmentPlanningScreen({super.key});

  final PatientsDetailsController patientsDetailsController =
      Get.put(PatientsDetailsController());

  @override
  Widget build(BuildContext context) {
    String modelLink = Get.arguments[link] ?? "";
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: appbarWithIcons(
        centerTitle: false,
        title: Text(
          LocaleKeys.treatmentPlanning.translateText,
          style: TextStyle(
            fontFamily: Assets.fonts.maax,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        leading: Assets.icons.icBack
            .svg(
              height: 25,
              width: 25,
              fit: BoxFit.scaleDown,
            )
            .paddingOnly(left: 10)
            .onClick(() {
          Get.back();
        }),
        elevation: 0.5,
      ),
      // body: (patientsDetailsController.isShowLatestLink
      //         ? ((patientsDetailsController
      //                     .patientDetailsModel?.latestPatient3dModalLink !=
      //                 null ||
      //             patientsDetailsController
      //                     .patientDetailsModel?.latestPatient3dModalLink !=
      //                 ""))
      //         : ((patientsDetailsController.link.isNotEmpty)))
      body: (modelLink.isNotEmpty)
          ? WebViewWidget(
              controller: WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..setBackgroundColor(const Color(0x00000000))
                ..setNavigationDelegate(
                  NavigationDelegate(
                    onProgress: (int progress) {
                      // Update loading bar.
                    },
                    onPageStarted: (String url) {},
                    onPageFinished: (String url) {},
                    onHttpError: (HttpResponseError error) {},
                    onWebResourceError: (WebResourceError error) {},
                  ),
                )
                ..loadRequest(Uri.parse(
                    // patientsDetailsController.isShowLatestLink
                    //     ? patientsDetailsController
                    //         .patientDetailsModel!.latestPatient3dModalLink!
                    //     : (patientsDetailsController.link),
                    modelLink)),
            )
          : Center(
              child: Text(LocaleKeys.noUrlAvailableToLoad.translateText)
                  .paddingOnly(bottom: 60),
            ),
    );
  }
}
