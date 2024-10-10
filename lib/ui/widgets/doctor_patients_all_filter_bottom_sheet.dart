import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/model/clinic_location_model.dart';
import 'package:lynerdoctor/model/doctor_model.dart';
import 'package:lynerdoctor/ui/screens/main/patients/patients_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';
import 'package:lynerdoctor/ui/widgets/common_bottom_sheet_top_widget.dart';

class DoctorPatientsAllFilterBottomSheet extends StatefulWidget {
  const DoctorPatientsAllFilterBottomSheet({
    super.key,
    required this.controller,
    required this.onTap,
  });

  final ScrollController controller;
  final VoidCallback onTap;

  @override
  State<DoctorPatientsAllFilterBottomSheet> createState() =>
      _DoctorPatientsAllFilterBottomSheetState();
}

class _DoctorPatientsAllFilterBottomSheetState
    extends State<DoctorPatientsAllFilterBottomSheet> {
  dynamic allDoctorAndClinicAddressGroupValue = 'All';
  String appbarSubTitle = '';
  String filterType = '';
  String clinicLocationId = '';
  String sessionDoctorId = '';
  PatientsController patientsController = Get.put(PatientsController());

  @override
  void initState() {
    appbarSubTitle = LocaleKeys.all.translateText;
    allDoctorAndClinicAddressGroupValue =
        patientsController.allDoctorAndClinicAddressGroupValue;
    appbarSubTitle = patientsController.appbarSubTitle;
    filterType = patientsController.filterType;
    clinicLocationId = patientsController.clinicLocationId;
    sessionDoctorId = patientsController.sessionDoctorId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: Container(
        color: appBgColor,
        child: ListView(
          controller: widget.controller,
          shrinkWrap: true,
          children: [
            CommonBottomSheetTopWidget(
              title: LocaleKeys.filter.translateText,
              onTap: () {
                Get.back();
              },
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.space(),
                // Text(
                //   LocaleKeys.treatmentStatus.translateText,
                //   style: hintTextStyle(
                //     size: 16,
                //     weight: FontWeight.w600,
                //     color: Colors.black,
                //   ),
                // ),
                // 12.space(),
                Container(
                  height: !isTablet ? 55 : 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(!isTablet ? 25 : 35),
                    color: Colors.white,
                    border: Border.all(color: skyColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LocaleKeys.all.translateText
                          .appCommonText(
                            size: !isTablet ? 16 : 18,
                            weight: FontWeight.w400,
                            color: Colors.black,
                          )
                          .paddingOnly(left: 15),
                      Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryBrown, width: 1),
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: 14.0,
                          height: 14.0,
                          decoration: BoxDecoration(
                            color: allDoctorAndClinicAddressGroupValue == 'All'
                                ? primaryBrown
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ).paddingOnly(right: 13)
                    ],
                  ),
                ).onClick(() {
                  setState(() {
                    allDoctorAndClinicAddressGroupValue = 'All';
                    appbarSubTitle = LocaleKeys.all.translateText;
                    filterType = '';
                  });
                }),
                12.space(),
                preferences.getClinicData()?.type ==
                        SharedPreference.LOGIN_TYPE_CLINIC
                    ? doctorData(patientsController)
                    : Container(),
                // doctorData(patientsController),
                12.space(),
                clinicAddressData(patientsController),
                40.space(),
                AppButton(
                  bgColor: primaryBrown,
                  text: LocaleKeys.apply.translateText,
                  fontColor: whiteColor,
                  radius: 100,
                  onTap: () {
                    Get.back();
                    patientsController.changeData(
                      allDoctorAndClinicAddressValue:
                          allDoctorAndClinicAddressGroupValue,
                      appbarSubTitleValue: appbarSubTitle,
                      clinicLocationIdValue: clinicLocationId,
                      sessionDoctorIdValue: sessionDoctorId,
                      filterTypeValue: filterType,
                    );
                    widget.onTap();
                  },
                ),
                28.space(),
              ],
            ).paddingSymmetric(horizontal: 20),
          ],
        ),
      ),
    );
  }

  Widget doctorData(PatientsController ctrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(!isTablet ? 12 : 15),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(!isTablet ? 12 : 15),
          border: Border.all(color: skyColor, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(!isTablet ? 12 : 15),
              ),
              child: LocaleKeys.doctor.translateText
                  .appCommonText(
                    size: !isTablet ? 16 : 18,
                    weight: FontWeight.w400,
                    color: Colors.black,
                  )
                  .paddingOnly(top: 16, left: 16, bottom: 16),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(color: skyColor, thickness: 1, height: 0),
                ctrl.doctorDataList.isEmpty
                    ? LocaleKeys.doctorNotFound.translateText
                        .appCommonText(
                          size: !isTablet ? 15 : 17,
                          weight: FontWeight.w300,
                          color: Colors.black,
                        )
                        .paddingOnly(top: 16, left: 16, bottom: 16)
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: ctrl.doctorDataList.length,
                        padding: EdgeInsets.all(15),
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) =>
                            20.space(),
                        itemBuilder: (BuildContext context, int index) {
                          DoctorData? doctor = ctrl.doctorDataList[index];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child:
                                    "Dr. ${doctor?.firstName ?? ''} ${doctor?.lastName ?? ''}"
                                        .appCommonText(
                                  size: !isTablet ? 16 : 18,
                                  weight: FontWeight.w300,
                                  color: Colors.black,
                                  align: TextAlign.start,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: primaryBrown, width: 1),
                                  shape: BoxShape.circle,
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 14.0,
                                  height: 14.0,
                                  decoration: BoxDecoration(
                                    color:
                                        allDoctorAndClinicAddressGroupValue ==
                                                ctrl.doctorDataList[index]
                                            ? primaryBrown
                                            : Colors.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ).onClick(
                            () {
                              setState(() {
                                allDoctorAndClinicAddressGroupValue =
                                    ctrl.doctorDataList[index];
                                appbarSubTitle =
                                    "Dr. ${doctor?.firstName ?? ''} ${doctor?.lastName ?? ''}";
                                filterType = 'doctor';
                                sessionDoctorId =
                                    '${ctrl.doctorDataList[index]?.doctorId}';
                              });
                            },
                          );
                        },
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget clinicAddressData(PatientsController ctrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(!isTablet ? 12 : 15),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(!isTablet ? 12 : 15),
          border: Border.all(color: skyColor, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(!isTablet ? 12 : 15),
              ),
              child: LocaleKeys.clinic.translateText
                  .appCommonText(
                    size: !isTablet ? 16 : 18,
                    weight: FontWeight.w400,
                    color: Colors.black,
                  )
                  .paddingOnly(top: 16, left: 16, bottom: 16),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(color: skyColor, thickness: 1, height: 0),
                ctrl.clinicLocationList.isEmpty
                    ? LocaleKeys.clinicLocationNotFound.translateText
                        .appCommonText(
                          size: !isTablet ? 15 : 17,
                          weight: FontWeight.w300,
                          color: Colors.black,
                        )
                        .paddingOnly(top: 16, left: 16, bottom: 16)
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: ctrl.clinicLocationList.length,
                        padding: EdgeInsets.all(15),
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) =>
                            20.space(),
                        itemBuilder: (BuildContext context, int index) {
                          ClinicLocation? location =
                              ctrl.clinicLocationList[index];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child:
                                    "${location?.address ?? ''}".appCommonText(
                                  size: !isTablet ? 16 : 18,
                                  weight: FontWeight.w300,
                                  color: Colors.black,
                                  align: TextAlign.start,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: primaryBrown, width: 1),
                                  shape: BoxShape.circle,
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 14.0,
                                  height: 14.0,
                                  decoration: BoxDecoration(
                                    color:
                                        allDoctorAndClinicAddressGroupValue ==
                                                ctrl.clinicLocationList[index]
                                            ? primaryBrown
                                            : Colors.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ).onClick(
                            () {
                              setState(
                                () {
                                  allDoctorAndClinicAddressGroupValue =
                                      ctrl.clinicLocationList[index];
                                  appbarSubTitle = '${location?.address ?? ''}';
                                  filterType = 'location';
                                  clinicLocationId =
                                      '${ctrl.clinicLocationList[index]?.clinicLocationId}';
                                },
                              );
                            },
                          );
                        },
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
