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
import 'package:lynerdoctor/model/global_search_model.dart';
import 'package:lynerdoctor/model/lyner_connect_list_model.dart';
import 'package:lynerdoctor/ui/screens/main/global_search/global_search_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_patient_card.dart';
import 'package:lynerdoctor/ui/widgets/app_progress_view.dart';

class GlobalSearchScreen extends StatelessWidget {
  GlobalSearchScreen({super.key});

  final GlobalSearchController globalSearchController =
      Get.put(GlobalSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: false,
        title: Text(
          LocaleKeys.search.translateText,
          style: TextStyle(
            fontFamily: Assets.fonts.maax,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: !isTablet ? 20 : 25,
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
        elevation: 0.5,
        scrolledUnderElevation: 0,
      ),
      body: GetBuilder<GlobalSearchController>(
        builder: (GlobalSearchController ctrl) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  24.space(),
                  CommonTextField(
                    prefixIcon: Assets.icons.icSearch,
                    hintText: LocaleKeys.search.translateText,
                    controller: ctrl.searchController,
                    action: TextInputAction.done,
                    onChange: (String value) {
                      // ctrl.patientList.clear();
                      Future.delayed(
                        Duration(seconds: 2),
                        () {
                          globalSearchController.globalSearch();
                        },
                      );
                    },
                  ).paddingSymmetric(horizontal: 20),
                  24.space(),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        (LocaleKeys.tasks.translateText).appCommonText(
                          weight: FontWeight.w500,
                          size: !isTablet ? 20 : 22,
                          color: Colors.black,
                          align: TextAlign.start,
                        ),
                        6.space(),
                        ctrl.patientTaskData.isEmpty
                            ? (LocaleKeys.dataNotFound.translateText)
                                .appCommonText(
                                weight: FontWeight.w400,
                                size: !isTablet ? 16 : 18,
                                color: Colors.black,
                                align: TextAlign.start,
                              )
                            : ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        8.space(),
                                itemCount: ctrl.patientTaskData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Archive? patientData =
                                      ctrl.patientTaskData[index];
                                  return AppPatientCard(
                                    isUnread: 0,
                                    isDraft: patientData?.isDraft ?? 0,
                                    // isShowBottomWidget: patientData?.isDraft == 1,
                                    isShowBottomWidget: true,
                                    clinicItem: patientData?.clinicItem ?? '',
                                    isEditCard: false,
                                    title1: LocaleKeys.statusCom,
                                    title2: LocaleKeys.patientIdCom,
                                    title3: LocaleKeys.productCom,
                                    data1: getClinicItemStatus(patientData),
                                    data2: patientData?.patientUniqueId ?? '',
                                    data3: patientData?.caseName ?? '',
                                    patientName:
                                        '${patientData?.firstName ?? ''} ${patientData?.lastName ?? ''}',
                                    deleteOnTap: () {},
                                    editOrSubmitOnTap: () {
                                      if (patientData?.isDraft == 0) {
                                        Get.toNamed(
                                            Routes.patientsDetailsScreen,
                                            arguments: [
                                              {
                                                patientIdString:
                                                    patientData?.patientId,
                                                isShowCheckModificationButtonString:
                                                    (patientData
                                                            ?.patient3DModalLink
                                                            ?.isNotEmpty ??
                                                        false),
                                              }
                                            ])?.then(
                                          (value) {
                                            ctrl.globalSearch();
                                            ctrl.update();
                                          },
                                        );
                                      } else {
                                        Get.toNamed(Routes.addPatientScreen,
                                            arguments: patientData?.patientId);
                                      }
                                    },
                                    patientImagePath:
                                        patientData?.patientProfile ?? '',
                                  );
                                },
                              ),
                        20.space(),
                        (LocaleKeys.patient.translateText).appCommonText(
                          weight: FontWeight.w500,
                          size: !isTablet ? 20 : 22,
                          color: Colors.black,
                          align: TextAlign.start,
                        ),
                        6.space(),
                        ctrl.patientData.isEmpty
                            ? (LocaleKeys.dataNotFound.translateText)
                                .appCommonText(
                                weight: FontWeight.w400,
                                size: !isTablet ? 16 : 18,
                                color: Colors.black,
                                align: TextAlign.start,
                              )
                            : ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        8.space(),
                                itemCount: ctrl.patientData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Archive? patientData =
                                      ctrl.patientData[index];
                                  return AppPatientCard(
                                    isUnread: 0,
                                    isDraft: patientData?.isDraft ?? 0,
                                    // isShowBottomWidget: patientData?.isDraft == 1,
                                    isShowBottomWidget: false,
                                    clinicItem: patientData?.clinicItem ?? '',
                                    isEditCard: false,
                                    title1: LocaleKeys.statusCom,
                                    title2: LocaleKeys.patientIdCom,
                                    title3: LocaleKeys.productCom,
                                    data1: getClinicItemStatus(patientData),
                                    data2: patientData?.patientUniqueId ?? '',
                                    data3: patientData?.caseName ?? '',
                                    patientName:
                                        '${patientData?.firstName ?? ''} ${patientData?.lastName ?? ''}',
                                    deleteOnTap: () {},
                                    editOrSubmitOnTap: () {},
                                    patientImagePath:
                                        patientData?.patientProfile ?? '',
                                  ).onClick(
                                    () {
                                      Get.toNamed(Routes.patientsDetailsScreen,
                                          arguments: [
                                            {
                                              patientIdString:
                                                  patientData?.patientId,
                                            }
                                          ])?.then(
                                        (value) {
                                          ctrl.globalSearch();
                                          ctrl.update();
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                        20.space(),
                        (LocaleKeys.archive.translateText).appCommonText(
                          weight: FontWeight.w500,
                          size: !isTablet ? 20 : 22,
                          color: Colors.black,
                          align: TextAlign.start,
                        ),
                        6.space(),
                        ctrl.archiveData.isEmpty
                            ? (LocaleKeys.dataNotFound.translateText)
                                .appCommonText(
                                weight: FontWeight.w400,
                                size: !isTablet ? 16 : 18,
                                color: Colors.black,
                                align: TextAlign.start,
                              )
                            : ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        8.space(),
                                itemCount: ctrl.archiveData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Archive? patientData =
                                      ctrl.archiveData[index];
                                  return AppPatientCard(
                                    isUnread: 0,
                                    isDraft: patientData?.isDraft ?? 0,
                                    // isShowBottomWidget: patientData?.isDraft == 1,
                                    isShowBottomWidget: false,
                                    clinicItem: patientData?.clinicItem ?? '',
                                    isEditCard: false,
                                    title1: LocaleKeys.statusCom,
                                    title2: LocaleKeys.patientIdCom,
                                    title3: LocaleKeys.productCom,
                                    data1: getClinicItemStatus(patientData),
                                    data2: patientData?.patientUniqueId ?? '',
                                    data3: patientData?.caseName ?? '',
                                    patientName:
                                        '${patientData?.firstName ?? ''} ${patientData?.lastName ?? ''}',
                                    deleteOnTap: () {},
                                    editOrSubmitOnTap: () {},
                                    patientImagePath:
                                        patientData?.patientProfile ?? '',
                                  ).onClick(
                                    () {
                                      Get.toNamed(Routes.patientsDetailsScreen,
                                          arguments: [
                                            {
                                              patientIdString:
                                                  patientData?.patientId,
                                              commentString: "archived",
                                            }
                                          ])?.then(
                                        (value) {
                                          ctrl.globalSearch();
                                          ctrl.update();
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                        20.space(),
                        (LocaleKeys.lynerConnect.translateText).appCommonText(
                          weight: FontWeight.w500,
                          size: !isTablet ? 20 : 22,
                          color: Colors.black,
                          align: TextAlign.start,
                        ),
                        6.space(),
                        ctrl.lynerConnectData.isEmpty
                            ? (LocaleKeys.dataNotFound.translateText)
                                .appCommonText(
                                weight: FontWeight.w400,
                                size: !isTablet ? 16 : 18,
                                color: Colors.black,
                                align: TextAlign.start,
                              )
                            : ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        8.space(),
                                itemCount: ctrl.lynerConnectData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  LynerConnectList? lynerConnectListData =
                                      ctrl.lynerConnectData[index];
                                  return EditPatientCard(
                                    title1: LocaleKeys.alignerStagesCom,
                                    title2: LocaleKeys.alignerDaysCom,
                                    title3: LocaleKeys.caseCom,
                                    data1: lynerConnectListData?.alignerStage
                                            .toString() ??
                                        '',
                                    data2: lynerConnectListData?.alignerDay
                                            .toString() ??
                                        '',
                                    data3: lynerConnectListData?.caseName
                                            .toString() ??
                                        '',
                                    treatmentStartDate: lynerConnectListData
                                        ?.treatmentStartDate
                                        ?.ddMMYYYYFormat(),
                                    patientName:
                                        "${lynerConnectListData?.firstName} ${lynerConnectListData?.lastName}",
                                    deleteOnTap: () {
                                      ctrl.deletePatient(
                                          lynerConnectListData?.userId ?? 0);
                                    },
                                    editOrSubmitOnTap: () {
                                      Get.toNamed(Routes.addEditLynerConnect,
                                          arguments: [
                                            false,
                                            lynerConnectListData,
                                            null
                                          ]);
                                    },
                                    patientImagePath:
                                        "${lynerConnectListData?.userProfilePhoto}",
                                  ).onClick(
                                    () {
                                      Get.toNamed(Routes.lynerConnectDetails,
                                          arguments:
                                              lynerConnectListData?.userId);
                                    },
                                  );
                                },
                              ),
                        20.space(),
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

String getClinicItemStatus(Archive? patientResponseData) {
  if (patientResponseData?.isDraft == 1) {
    return 'Brouillon';
  } else {
    switch (patientResponseData?.clinicItem) {
      case 'Lyner Working':
        return 'En cours de planification';
      case 'Delivered':
        return 'Expédié';
      case 'In-Production':
        return 'En production';
      case 'Review Modification':
        return 'Modification de la révision';
      case 'Lyner Review Modification':
        return "Modification de l'examen Lyner";
      case 'Approved By Doctor':
        return 'Approuvé par le Docteur';
      default:
        if ((patientResponseData?.clinicItem ?? '').contains('Review Plan')) {
          return (patientResponseData?.clinicItem ?? '')
              .replaceFirst('Review ', '');
        } else {
          return patientResponseData?.clinicItem ?? '';
        }
    }
  }
}
