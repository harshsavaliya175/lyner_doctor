import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/image_picker.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/model/comment_model.dart';
import 'package:lynerdoctor/ui/screens/main/patients_details/patients_details_controller.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({super.key});

  final controller = Get.put(PatientsDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GetBuilder<PatientsDetailsController>(
        builder: (PatientsDetailsController ctrl) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.space(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LocaleKeys.comments.translateText.normalText(
                    fontWeight: FontWeight.w600,
                    fontSize: !isTablet ? 20 : 24,
                  ),
                  (controller.patientDetailsModel?.linkPassword != null
                          ? controller.patientDetailsModel?.linkPassword
                          : "19v8L5")
                      .toString()
                      .normalText(
                        fontWeight: FontWeight.w500,
                        fontSize: !isTablet ? 16 : 19,
                      )
                      .onClick(
                    () {
                      Clipboard.setData(ClipboardData(
                          text: controller.patientDetailsModel?.linkPassword ??
                              '19v8L5'));
                      showAppSnackBar('Password copied');
                    },
                  ),
                ],
              ),
              6.space(),
              controller.commentModelList.isEmpty
                  ? Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: "Comment Not Found".normalText(
                          color: Colors.black,
                          fontSize: !isTablet ? 20 : 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
                        itemCount: controller.commentModelList.length,
                        padding: EdgeInsets.only(top: 10, bottom: 50),
                        separatorBuilder: (BuildContext context, int index) =>
                            12.space(),
                        itemBuilder: (BuildContext context, int index) {
                          CommentModel? commentModel =
                              controller.commentModelList[index];
                          SvgGenImage image = Assets.icons.icDefaultFile;
                          switch (commentModel?.extension ?? '') {
                            case "jpeg":
                              image = Assets.icons.icJpgSvg;
                            case "png":
                              image = Assets.icons.icPng;
                            case "pdf":
                              image = Assets.icons.icPdfFile;
                            case "zip":
                              image = Assets.icons.icZip;
                            case "mp4":
                              image = Assets.icons.icVideoFile;
                            case "mp3":
                              image = Assets.icons.icMp3;
                            case "pptx":
                              image = Assets.icons.icPpt;
                            case "svg":
                              image = Assets.icons.icSvg;
                            default:
                              image = Assets.icons.icDefaultFile;
                          }

                          return Container(
                            width: Get.width,
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 16),
                            decoration: BoxDecoration(
                              color: (commentModel?.sentByClinic == 1)
                                  ? lightGreenColor
                                  : lightPinkColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(color: skyColor),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ((commentModel?.sentByClinic == 1)
                                            ? LocaleKeys.clinic
                                            : LocaleKeys.lyner)
                                        .translateText
                                        .normalText(
                                          fontWeight: FontWeight.w500,
                                          fontSize: !isTablet ? 16 : 19,
                                          color: blackColor,
                                        ),
                                    ((commentModel?.createdAt
                                                ?.ddMMMyyHhSssA() ??
                                            ""))
                                        .normalText(
                                      fontWeight: FontWeight.w500,
                                      color: hintStepColor,
                                      fontSize: !isTablet ? 12 : 15,
                                    ),
                                  ],
                                ),
                                6.space(),
                                (commentModel?.comment?.isNotEmpty ?? false)
                                    ? (commentModel!.comment)!.normalText(
                                        fontWeight: FontWeight.w500,
                                        fontSize: !isTablet ? 16 : 19,
                                        color: blackColor,
                                      )
                                    : Row(
                                        children: [
                                          image.svg(
                                            height: !isTablet ? 24 : 28,
                                            width: !isTablet ? 24 : 28,
                                            fit: BoxFit.scaleDown,
                                          ),
                                          10.space(),
                                          (commentModel?.fileName ?? "")
                                              .normalText(
                                            fontWeight: FontWeight.w500,
                                            fontSize: !isTablet ? 16 : 19,
                                            color: blackColor,
                                          )
                                        ],
                                      ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
              Row(
                children: [
                  Expanded(
                    child: CommonTextField(
                      controller: controller.commentController,
                      hintText: "Please note your comments",
                      suffixIcon: Assets.icons.icClip
                          .svg(
                        height: !isTablet ? 24 : 28,
                        width: !isTablet ? 24 : 28,
                        fit: BoxFit.scaleDown,
                      )
                          .onClick(
                        () {
                          imageUploadUtils.pickFileFormStorage(
                            context: Get.context!,
                            onFileChose: (File file) async {
                              // Handle the chosen file
                              ctrl.commentFile = file;
                              if (ctrl.commentFile != null) {
                                ctrl.commentFileName = ctrl.getFileName(
                                    ctrl.commentFile?.path, 15);
                              }
                              ctrl.update();
                              print('Chosen file path: ${file.path}');
                              bool isUploadFile = await ctrl.uploadCommentFile(
                                  file, ctrl.patientId);
                              if (isUploadFile) {
                                controller.getPatientCommentsDetails();
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  12.space(),
                  FloatingActionButton(
                    onPressed: () {
                      if (controller.commentController.text.isNotEmpty) {
                        context.hideKeyBoard(context);
                        controller.addTextPatientComments();
                      }
                    },
                    child: Assets.icons.icSend.svg(),
                    shape: CircleBorder(),
                    backgroundColor: primaryBrown,
                  ),
                ],
              ).paddingSymmetric(vertical: 15),
            ],
          );
        },
      ),
    );
  }
}
