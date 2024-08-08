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
import 'package:lynerdoctor/ui/screens/main/lyner_connect/lyner_connect_home/lyner_connect_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_bar.dart';
import 'package:lynerdoctor/ui/widgets/app_patient_card.dart';
import 'package:lynerdoctor/ui/widgets/app_progress_view.dart';

class LynerConnectScreen extends StatelessWidget {
  const LynerConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: appbarWithIcons(
          centerTitle: false,
          title: Text(
            LocaleKeys.lynerConnect.translateText,
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
          ).onClick(
            () {
              Get.toNamed(Routes.addLynerConnect);
            },
          ).paddingOnly(right: 15)),
      body: GetBuilder<LynerConnectController>(
        builder: (ctrl) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  24.space(),
                  Expanded(
                    child: ListView.separated(
                      itemCount: ctrl.lynerConnectList.length,
                      padding: EdgeInsets.only(bottom: 150, top: 6),
                      itemBuilder: (BuildContext context, int index) {
                        var lynerConnectListData = ctrl.lynerConnectList[index];
                        return AppPatientCard(
                          isEditCard: true,
                          title1: LocaleKeys.alignerStagesCom,
                          title2: LocaleKeys.alignerDaysCom,
                          title3: LocaleKeys.caseCom,
                          data1: lynerConnectListData?.alignerStage.toString()??'',
                          data2: lynerConnectListData?.alignerDay.toString()??'',
                          data3: lynerConnectListData?.caseName.toString()??'',
                          treatmentStartDate:  lynerConnectListData?.treatmentStartDate?.ddMMYYYYFormat(),
                          patientName: "${lynerConnectListData?.firstName} ${lynerConnectListData?.lastName}",
                          deleteOnTap: () {},
                          editOrSubmitOnTap: () {
                            Get.toNamed(Routes.addEditLynerConnect,
                                arguments: [false,null]);
                          },
                          patientImagePath: "${lynerConnectListData?.userProfilePhoto}",
                        ).onClick(
                          () {
                            Get.toNamed(Routes.lynerConnectDetails);
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          12.space(),
                    ),
                  ),
                ],
              ).paddingOnly(left: 20, right: 20),
              ctrl.isLoading
                  ? AppProgressView(
                      progressColor: Colors.black,
                    )
                  : Container()
            ],
          );
        },
      ),
    );
  }
}
