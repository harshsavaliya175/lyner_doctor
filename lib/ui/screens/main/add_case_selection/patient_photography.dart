import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/home_image.dart';
import 'package:lynerdoctor/core/utils/image_picker.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/add_case_selection/add_case_selection_controller.dart';
import 'package:lynerdoctor/ui/screens/main/add_patient/add_patient.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';

class PatientPhotography extends StatelessWidget {
  const PatientPhotography({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCaseSelectionController>(
        builder: (AddCaseSelectionController ctrl) {
      return Stack(
        children: [
          ListView(
            children: [
              5.space(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LocaleKeys.uploadPhotographs.translateText
                            .appCommonText(
                          align: TextAlign.start,
                          size: !isTablet ? 24 : 27,
                          maxLine: 2,
                          overflow: TextOverflow.ellipsis,
                          weight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        (LocaleKeys.jpgAndHeifFormat.translateText)
                            .appCommonText(
                          align: TextAlign.start,
                          size: !isTablet ? 16 : 19,
                          maxLine: 2,
                          overflow: TextOverflow.ellipsis,
                          weight: FontWeight.w400,
                          color: hintStepColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // !isTablet ? 10.space() : 15.space(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  photoCardWidget(
                    image: Assets.images.imgInterRight.path,
                    urlPath: "patient_inter_gauche",
                    urlImage: "",
                    fontSize: 12,
                    fileImage: ctrl.intraRightImageFile ?? File(''),
                    title: LocaleKeys.intraRight.translateText,
                    onTap: () {
                      imageUploadUtils.faceDetectingOpenImageChooser(
                        context: Get.context!,
                        imageCount: 5,
                        title: LocaleKeys.intraRight.translateText,
                        onImageChose: (File? file) async {
                          ctrl.intraRightImageFile = file!;

                          ctrl.uploadPatientSingleImage(
                              paramName: 'patient_inter_gauche', file: file);
                          ctrl.update();
                        },
                      );
                    },
                  ),
                  10.space(),
                  photoCardWidget(
                    urlImage: "",
                    fileImage: ctrl.intraFaceImageFile ?? File(''),
                    urlPath: "patient_inter_face",
                    image: Assets.images.imgInterFace.path,
                    title: LocaleKeys.intraFace.translateText,
                    fontSize: 12,
                    onTap: () {
                      imageUploadUtils.faceDetectingOpenImageChooser(
                        context: Get.context!,
                        imageCount: 6,
                        title: LocaleKeys.intraFace.translateText,
                        onImageChose: (File? file) async {
                          // ctrl.cuisinePhoto?[0] =(file!);
                          ctrl.intraFaceImageFile = file!;
                          ctrl.uploadPatientSingleImage(
                              paramName: 'patient_inter_face', file: file);

                          ctrl.update();
                        },
                      );
                    },
                  ),
                  10.space(),
                  photoCardWidget(
                    urlImage: "",
                    fileImage: ctrl.intraLeftImageFile ?? File(''),
                    urlPath: "patient_intra_droite",
                    image: Assets.images.imgInterLeft.path,
                    title: LocaleKeys.intraLeft.translateText,
                    fontSize: 12,
                    onTap: () {
                      imageUploadUtils.faceDetectingOpenImageChooser(
                        context: Get.context!,
                        imageCount: 7,
                        title: LocaleKeys.intraLeft.translateText,
                        onImageChose: (File file) async {
                          // ctrl.cuisinePhoto?[0] =(file!);
                          ctrl.intraLeftImageFile = file;
                          ctrl.uploadPatientSingleImage(
                            paramName: 'patient_intra_droite',
                            file: file,
                          );
                          ctrl.update();
                        },
                      );
                    },
                  ),
                  10.space(),
                  photoCardWidget(
                    image: Assets.images.imgFace.path,
                    title: LocaleKeys.face.translateText,
                    urlImage: "",
                    urlPath: "patient_face",
                    fontSize: 12,
                    fileImage: ctrl.faceImageFile ?? File(''),
                    onTap: () {
                      imageUploadUtils.faceDetectingOpenImageChooser(
                        context: Get.context!,
                        imageCount: 1,
                        title: LocaleKeys.face.translateText,
                        onImageChose: (File? file) async {
                          // ctrl.cuisinePhoto?[0] =(file!);
                          ctrl.faceImageFile = file!;
                          ctrl.uploadPatientSingleImage(
                              paramName: 'patient_face', file: file);
                          ctrl.update();
                        },
                      );
                    },
                  ),
                ],
              ),
              5.space(),
              LocaleKeys.radios.translateText.appCommonText(
                align: TextAlign.start,
                size: !isTablet ? 24 : 27,
                maxLine: 2,
                overflow: TextOverflow.ellipsis,
                weight: FontWeight.w500,
                color: Colors.black,
              ),
              LocaleKeys.jpgAndHeifFormat.translateText.appCommonText(
                align: TextAlign.start,
                size: !isTablet ? 16 : 19,
                maxLine: 2,
                overflow: TextOverflow.ellipsis,
                weight: FontWeight.w400,
                color: hintStepColor,
              ),
              15.space(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          imageUploadUtils.openImageChooser(
                            context: Get.context!,
                            onImageChose: (File? file) async {
                              // ctrl.cuisinePhoto?[0] =(file!);
                              ctrl.radiosFirstImageFile = file!;
                              ctrl.uploadPatientSingleImage(
                                  paramName: 'patient_panoramique', file: file);
                              ctrl.update();
                            },
                          );
                        },
                        child: (ctrl.radiosFirstImageFile != null &&
                                ctrl.radiosFirstImageFile?.path != "")
                            ? HomeImage.fileImage(
                                path: ctrl.radiosFirstImageFile!.path,
                                height: !isTablet ? 121 : 215,
                                width: !isTablet ? 200 : 230,
                                shape: BoxShape.rectangle,
                                fit: BoxFit.cover,
                                radius: BorderRadius.circular(10),
                              )
                            : HomeImage.assetImage(
                                path: Assets.images.imgTab.path,
                                height: !isTablet ? 135 : 230,
                                width: !isTablet ? 200 : 230,
                                shape: BoxShape.rectangle,
                                // fit: BoxFit.cover,
                              )),
                  ),
                  15.space(),
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          imageUploadUtils.openImageChooser(
                            context: Get.context!,
                            onImageChose: (File? file) async {
                              // ctrl.cuisinePhoto?[0] =(file!);
                              ctrl.radiosSecondImageFile = file!;
                              ctrl.uploadPatientSingleImage(
                                paramName: 'patient_cephalometrique',
                                file: file,
                              );
                              ctrl.update();
                            },
                          );
                        },
                        child: (ctrl.radiosSecondImageFile != null &&
                                ctrl.radiosSecondImageFile?.path != "")
                            ? HomeImage.fileImage(
                                path: ctrl.radiosSecondImageFile!.path,
                                height: !isTablet ? 121 : 215,
                                width: !isTablet ? 200 : 230,
                                shape: BoxShape.rectangle,
                                fit: BoxFit.cover,
                                radius: BorderRadius.circular(10),
                              )
                            : HomeImage.assetImage(
                                path: Assets.images.imgTab.path,
                                height: !isTablet ? 135 : 230,
                                width: !isTablet ? 200 : 230,
                                shape: BoxShape.rectangle,
                                // fit: BoxFit.cover,
                              )),
                  ),
                ],
              ),
              10.space(),
              LocaleKeys.stlFiles.translateText.appCommonText(
                align: TextAlign.start,
                size: !isTablet ? 24 : 27,
                maxLine: 2,
                overflow: TextOverflow.ellipsis,
                weight: FontWeight.w500,
                color: Colors.black,
              ),
              10.space(),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: !isTablet ? 50 : 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: ctrl.isUploadStl ? primaryBrown : Colors.white,
                          border: Border.all(
                              color: ctrl.isUploadStl ? Colors.white : skyColor,
                              width: 1),
                          borderRadius:
                              BorderRadius.circular(!isTablet ? 25 : 40)),
                      child: Padding(
                        padding: !isTablet
                            ? EdgeInsets.symmetric(horizontal: 10)
                            : EdgeInsets.zero,
                        child: LocaleKeys.uploadStl.translateText.appCommonText(
                          align: TextAlign.center,
                          color: ctrl.isUploadStl ? Colors.white : darkSkyColor,
                          size: !isTablet ? 16 : 20,
                        ),
                      ),
                    ).onClick(
                      () {
                        ctrl.isUploadStl = true;
                        ctrl.update();
                      },
                    ),
                  ),
                  25.space(),
                  Expanded(
                    child: Container(
                      height: !isTablet ? 50 : 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color:
                              !ctrl.isUploadStl ? primaryBrown : Colors.white,
                          borderRadius:
                              BorderRadius.circular(!isTablet ? 25 : 40),
                          border: Border.all(
                              color:
                                  !ctrl.isUploadStl ? Colors.white : skyColor,
                              width: 1)),
                      child: LocaleKeys.postedBy3shape.translateText
                          .appCommonText(
                              align: TextAlign.center,
                              color: !ctrl.isUploadStl
                                  ? Colors.white
                                  : darkSkyColor,
                              size: !isTablet ? 16 : 20,
                              weight: FontWeight.w500),
                    ).onClick(
                      () {
                        ctrl.isUploadStl = false;
                        ctrl.update();
                      },
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: ctrl.isUploadStl,
                child: Column(
                  children: [
                    10.space(),
                    Row(
                      children: [
                        LocaleKeys.upperJawStlFile.translateText.appCommonText(
                            size: !isTablet ? 14 : 18,
                            weight: FontWeight.w400,
                            align: TextAlign.start),
                        3.space(),
                        "*"
                            .appCommonText(
                                size: !isTablet ? 14 : 16,
                                weight: FontWeight.w400,
                                color: Colors.red,
                                align: TextAlign.start)
                            .paddingOnly(bottom: 5)
                      ],
                    ),
                    AppTextField(
                      textEditingController: ctrl.upperJawImageFileTextCtrl,
                      onChanged: (String value) {},
                      validator: (String value) {},
                      textFieldPadding: EdgeInsets.zero,
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      readOnly: true,
                      showCursor: false,
                      onTap: () {
                        imageUploadUtils.pickStlFileFormStorage(
                          context: Get.context!,
                          onFileChose: (File? file) async {
                            // ctrl.cuisinePhoto?[0] =(file!);
                            ctrl.upperJawImageFile = file!;
                            ctrl.upperJawImageFileTextCtrl.text =
                                ctrl.upperJawImageFile != null
                                    ? ctrl.upperJawImageFile!.path
                                        .split('/')
                                        .last
                                    : '';
                            ctrl.uploadPatientSingleImage(
                                paramName: 'upper_jaw_stl_file', file: file);
                            ctrl.update();
                          },
                        );
                      },
                      // isError: ctrl.lastNameError,
                      prefixIcon: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        alignment: Alignment.center,
                        width: !isTablet ? 100 : 135,
                        decoration: BoxDecoration(
                            color: primaryBrown,
                            borderRadius: BorderRadius.circular(25)),
                        child: LocaleKeys.chooseFile.translateText
                            .appCommonText(
                                size: !isTablet ? 14 : 18,
                                color: Colors.white,
                                align: TextAlign.center),
                      )
                          .paddingSymmetric(vertical: 7)
                          .paddingOnly(left: 10, right: 6),
                      hintText: LocaleKeys.noFileChosen.translateText,
                      // labelText: "Upper Jaw STL File*",
                      showPrefixIcon: false,
                    ),
                    10.space(),
                    Row(
                      children: [
                        LocaleKeys.lowerJawStlFile.translateText.appCommonText(
                            size: !isTablet ? 14 : 18,
                            weight: FontWeight.w400,
                            align: TextAlign.start),
                        3.space(),
                        "*"
                            .appCommonText(
                                size: !isTablet ? 14 : 16,
                                weight: FontWeight.w400,
                                color: Colors.red,
                                align: TextAlign.start)
                            .paddingOnly(bottom: 5)
                      ],
                    ),
                    AppTextField(
                      textEditingController: ctrl.lowerJawImageFileTextCtrl,
                      onChanged: (value) {},
                      validator: (value) {},
                      textFieldPadding: EdgeInsets.zero,
                      keyboardType: TextInputType.text,
                      readOnly: true,
                      maxLines: 1,
                      showCursor: false,
                      onTap: () {
                        imageUploadUtils.pickStlFileFormStorage(
                          context: Get.context!,
                          onFileChose: (File? file) async {
                            // ctrl.cuisinePhoto?[0] =(file!);
                            ctrl.lowerJawImageFile = file!;
                            ctrl.lowerJawImageFileTextCtrl.text =
                                ctrl.lowerJawImageFile != null
                                    ? ctrl.lowerJawImageFile!.path
                                        .split('/')
                                        .last
                                    : '';
                            //ctrl.uploadPatientSingleImage(paramName: 'lower_jaw_stl_file', file: file);
                            ctrl.uploadPatientSingleImage(
                                paramName: 'lower_jaw_stl_file', file: file);
                            ctrl.update();
                          },
                        );
                      },
                      prefixIcon: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        alignment: Alignment.center,
                        width: !isTablet ? 100 : 135,
                        decoration: BoxDecoration(
                            color: primaryBrown,
                            borderRadius: BorderRadius.circular(25)),
                        child: LocaleKeys.chooseFile.translateText
                            .appCommonText(
                                size: !isTablet ? 14 : 18,
                                color: Colors.white,
                                align: TextAlign.center),
                      )
                          .paddingSymmetric(vertical: 7)
                          .paddingOnly(left: 10, right: 6),
                      hintText: LocaleKeys.noFileChosen.translateText,
                      // labelText: "Upper Jaw STL File*",
                      showPrefixIcon: false,
                    ),
                  ],
                ),
              ),
              10.space(),
              LocaleKeys.cbctDICOM.translateText.appCommonText(
                align: TextAlign.start,
                size: !isTablet ? 24 : 27,
                maxLine: 2,
                overflow: TextOverflow.ellipsis,
                weight: FontWeight.w500,
                color: Colors.black,
              ),
              10.space(),
              Stack(
                children: [
                  DottedBorder(
                    borderType: BorderType.RRect,
                    color: primaryBrown,
                    padding: EdgeInsets.zero,
                    radius: Radius.circular(35),
                    dashPattern: [5, 5, 5, 5],
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(!isTablet ? 35 : 40),
                          color: primaryBrown.withOpacity(0.08)),
                      height: !isTablet ? 55 : 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.icons.icDocument
                              .svg(height: !isTablet ? 23 : 30),
                          10.space(),
                          ctrl.dicomFileName.appCommonText(
                            size: !isTablet ? 16 : 20,
                            weight: FontWeight.w400,
                            color: primaryBrown,
                          ),
                        ],
                      ),
                    ),
                  ).onClick(
                    () {
                      imageUploadUtils.pickFileFormStorage(
                        context: Get.context!,
                        onFileChose: (File file) {
                          // Handle the chosen file
                          ctrl.dicomFile = file;
                          if (ctrl.dicomFile != null) {
                            ctrl.dicomFileName =
                                ctrl.getFileName(ctrl.dicomFile?.path, 15);
                          }
                          ctrl.update();
                          ctrl.uploadDicomFile(file, "patient");
                          print('Chosen file path: ${file.path}');
                        },
                      );
                    },
                  ),
                  Visibility(
                    visible: ctrl.isDcomFileLoading,
                    child: Container(
                      width: double.infinity,
                      height: !isTablet ? 55 : 70,
                      decoration: BoxDecoration(
                          color: lightBrown.withOpacity(0.4),
                          borderRadius:
                              BorderRadius.circular(!isTablet ? 25 : 40)),
                      child: Center(
                        child: Text(
                          '${(ctrl.uploadProgress * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            color: primaryBrown,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ).paddingSymmetric(horizontal: 3),
                  )
                ],
              ),
              10.space(),
              Visibility(
                visible: ctrl.isDcomFileLoading,
                child: LinearProgressIndicator(
                  value: ctrl.uploadProgress,
                  backgroundColor: Colors.white.withOpacity(0.5),
                  color: primaryBrown,
                ).paddingSymmetric(horizontal: 10),
              ),
              100.space(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: !isTablet ? 80 : 100,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: AppBorderButton(
                      btnHeight: !isTablet ? 55 : 70,
                      text: LocaleKeys.finishLatter.translateText,
                      onTap: () {
                        // ctrl.addUpdatePatientDetails(
                        //   isFromFinishStep: true,
                        //   draftViewPage: "upload_photo_page",
                        // );
                      },
                      radius: !isTablet ? 25 : 40,
                      fontSize: !isTablet ? 18 : 22,
                      borderColor: primaryBrown,
                      fontColor: primaryBrown,
                    ).paddingOnly(top: 10, right: 5),
                  ),
                  Expanded(
                    child: AppButton(
                      btnHeight: !isTablet ? 55 : 70,
                      text: LocaleKeys.next.translateText,
                      onTap: () {
                        if (1 == 1) {
                          // if (ctrl.validateUploadPhotoFiles()) {
                        } else {
                          showAppSnackBar(LocaleKeys
                              .pleaseSelectAllRequiredPhotos.translateText);
                        }
                      },
                      boxShadow: [],
                      radius: !isTablet ? 25 : 40,
                      fontSize: !isTablet ? 18 : 22,
                      bgColor: primaryBrown,
                      fontColor: Colors.white,
                    ).paddingOnly(top: 10, left: 5),
                  ),
                ],
              ).paddingOnly(bottom: 10),
            ),
          ),
        ],
      );
    });
  }
}
