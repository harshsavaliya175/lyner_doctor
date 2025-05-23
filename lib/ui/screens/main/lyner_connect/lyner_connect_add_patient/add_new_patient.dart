import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/model/lyner_patient_list_model.dart';
import 'package:lynerdoctor/ui/screens/main/lyner_connect/lyner_connect_add_patient/add_new_patient_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_bar.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';
import 'package:lynerdoctor/ui/widgets/app_progress_view.dart';

class AddLynerConnectPatient extends StatelessWidget {
  AddLynerConnectPatient({super.key});

  final AddNewPatientController controller = Get.put(AddNewPatientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: appbarWithIcons(
        centerTitle: false,
        title: Text(
          LocaleKeys.addLynerConnect.translateText,
          style: TextStyle(
              fontFamily: Assets.fonts.maax,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: !isTablet ? 20 : 22),
        ),
        backgroundColor: Colors.white,
        leadingWidth: !isTablet ? 40 : 50,
        leading: Assets.icons.icBack
            .svg(
              height: 35,
              width: 35,
              fit: !isTablet ? BoxFit.scaleDown : BoxFit.fill,
            )
            .paddingOnly(
                left: 10, top: isTablet ? 22 : 0, bottom: isTablet ? 22 : 0)
            .onClick(() {
          Get.back();
        }),
      ),
      body: GetBuilder<AddNewPatientController>(
          builder: (AddNewPatientController ctrl) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                15.space(),
                CommonTextField(
                  prefixIcon: Assets.icons.icSearch,
                  hintText: LocaleKeys.search.translateText,
                  controller: ctrl.searchController,
                  action: TextInputAction.done,
                  onChange: (String value) {
                    ctrl.getLynerConnectPatientList(
                      isFromSearch: true,
                    );
                  },
                ).paddingSymmetric(horizontal: 15),
                15.space(),
                LocaleKeys.patients.translateText
                    .appCommonText(
                        align: TextAlign.start,
                        size: !isTablet ? 20 : 24,
                        weight: FontWeight.w500)
                    .paddingSymmetric(horizontal: 15),
                10.space(),
                ctrl.lynerPatientListData.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: ctrl.lynerPatientListData.length,
                          physics: PageScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            final LynerPatientListData? item =
                                ctrl.lynerPatientListData[index];
                            bool isSelected = ctrl.selectedIndex == index;
                            return Column(
                              children: [
                                Container(
                                  height: !isTablet ? 55 : 65,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        !isTablet ? 25 : 40),
                                    color: Colors.white,
                                    border: Border.all(color: skyColor),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child:
                                            "${item?.firstName} ${item?.lastName}"
                                                .appCommonText(
                                                  maxLine: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  size: !isTablet ? 16 : 19,
                                                  align: TextAlign.start,
                                                  weight: FontWeight.w400,
                                                  color: Colors.black,
                                                )
                                                .paddingOnly(left: 15),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 20.0,
                                        height: 20.0,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? primaryBrown
                                              : Colors.transparent,
                                          border: Border.all(
                                              color: primaryBrown, width: 1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: isSelected
                                            ? Icon(Icons.check,
                                                color: Colors.white, size: 16)
                                            : Container(),
                                      ).paddingOnly(right: 13),
                                    ],
                                  ),
                                ).paddingSymmetric(vertical: 5).onClick(() {
                                  ctrl.togglePatientSelection(index);
                                }),
                              ],
                            );
                          },
                        ).paddingSymmetric(horizontal: 15),
                      )
                    : Visibility(
                        visible: !ctrl.isLoading,
                        child: LocaleKeys.noPatientFound.translateText
                            .appCommonText(
                                align: TextAlign.center,
                                size: 18,
                                weight: FontWeight.w300,
                                color: hintColor),
                      ).center,
                !isTablet ? 70.space() : 80.space(),
              ],
            ),
            AppButton(
              btnHeight: !isTablet ? 50 : 60,
              text: LocaleKeys.add.translateText,
              onTap: () {
                if (ctrl.selectedIndex != -1) {
                  Get.toNamed(Routes.addEditLynerConnect, arguments: [
                    true,
                    null,
                    ctrl.lynerPatientListData[ctrl.selectedIndex]
                  ]);
                } else {
                  showAppSnackBar(
                      LocaleKeys.pleaseSelectAnyPatient.translateText);
                }
              },
              boxShadow: [],
              radius: !isTablet ? 25 : 40,
              fontSize: !isTablet ? 20 : 24,
              bgColor: primaryBrown,
              fontColor: Colors.white,
            ).paddingOnly(top: 10, bottom: 10).paddingSymmetric(horizontal: 15),
            Visibility(visible: ctrl.isLoading, child: AppProgressView())
          ],
        );
      }),
    );
  }
}
