import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/lyner_connect/lyner_connect_add_patient/add_new_patient_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_bar.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';

class AddNewPatient extends StatelessWidget {
  AddNewPatient({super.key});

  var controller = Get.put(AddNewPatientController());

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
      body: GetBuilder<AddNewPatientController>(builder: (ctrl) {
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
                    // patientsController.getClinicListBySearchOrFilter(
                    //   isFromSearch: true,
                    // );
                  },
                ).paddingSymmetric(horizontal: 15),
                15.space(),
                LocaleKeys.patients.translateText
                    .appCommonText(
                        align: TextAlign.start,
                        size: 20,
                        weight: FontWeight.w500)
                    .paddingSymmetric(horizontal: 15),
                10.space(),
                Expanded(
                  child: ListView(
                    children: [
                      ListView.builder(
                        itemCount: ctrl.patientList.length,
                        physics: PageScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final item = ctrl.patientList[index];
                          bool isSelected = ctrl.selectedIndex == index;
                          return Column(
                            children: [
                              Container(
                                height: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white,
                                  border: Border.all(color: skyColor),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: item.title
                                          .appCommonText(
                                            maxLine: 2,
                                            overflow: TextOverflow.ellipsis,
                                            size: 16,
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
                    ],
                  ),
                ),
                70.space(),
              ],
            ),
            AppButton(
              btnHeight: 50,
              text: LocaleKeys.add.translateText,
              onTap: () {
                if(ctrl.selectedIndex!=-1){
                  Get.toNamed(Routes.addEditLynerConnect,arguments: true);
                }else{
                  showAppSnackBar(LocaleKeys.pleaseSelectAnyPatient.translateText);
                }

              },
              boxShadow: [],
              radius: 25,
              fontSize: 20,
              bgColor: primaryBrown,
              fontColor: Colors.white,
            ).paddingOnly(top: 10).paddingSymmetric(horizontal: 15),
          ],
        );
      }),
    );
  }
}
