import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
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
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({super.key});

  final PatientsDetailsController controller =
      Get.put(PatientsDetailsController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.hideKeyBoard(context);
      },
      child: Scaffold(
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
                    if (controller
                            .patientDetailsModel?.linkPassword?.isNotEmpty ??
                        false)
                      Row(
                        children: [
                          controller.patientDetailsModel!.linkPassword!
                              .normalText(
                            fontWeight: FontWeight.w500,
                            fontSize: !isTablet ? 16 : 19,
                          ),
                          5.space(),
                          IconButton(
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(
                                  text: controller
                                      .patientDetailsModel!.linkPassword!,
                                ),
                              );
                              showAppSnackBar(
                                  LocaleKeys.password_copied.translateText);
                            },
                            icon: Icon(
                              Icons.copy,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                6.space(),
                controller.commentModelList.isEmpty
                    ? Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: LocaleKeys.comment_not_found.translateText
                              .normalText(
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
                                            Expanded(
                                              child:
                                                  (commentModel?.fileName ?? "")
                                                      .normalText(
                                                fontWeight: FontWeight.w500,
                                                fontSize: !isTablet ? 16 : 19,
                                                color: Colors.blue,
                                                decoration:
                                                    TextDecoration.underline,
                                              )
                                                      .onClick(
                                                () async {
                                                  String url = ApiUrl
                                                          .commentFile +
                                                      (commentModel?.fileName ??
                                                          '');
                                                  Directory? baseStorage;
                                                  PermissionStatus status =
                                                      await Permission
                                                          .notification
                                                          .request();

                                                  String ext =
                                                      url.split('.').last;
                                                  String name = url
                                                      .split('/')
                                                      .last
                                                      .split('.')
                                                      .first;
                                                  String fileName =
                                                      '${name}_${DateTime.now().millisecondsSinceEpoch}.$ext';

                                                  if (status.isGranted) {
                                                    if (Platform.isIOS) {
                                                      baseStorage =
                                                          await getApplicationDocumentsDirectory();
                                                    } else {
                                                      baseStorage =
                                                          await getExternalStorageDirectory();
                                                    }
                                                    String? taskId =
                                                        await FlutterDownloader
                                                            .enqueue(
                                                      url: url,
                                                      savedDir:
                                                          baseStorage!.path,
                                                      showNotification: true,
                                                      openFileFromNotification:
                                                          true,
                                                      saveInPublicStorage: true,
                                                      fileName: fileName,
                                                    );

                                                    downloadTaskId['taskId'] =
                                                        taskId;
                                                    downloadTaskId['path'] =
                                                        '${baseStorage.path}/$fileName';

                                                    if (taskId != null) {
                                                      downloadTaskId
                                                          .putIfAbsent(
                                                        taskId,
                                                        () => downloadTaskId[
                                                            'path'],
                                                      );
                                                    }
                                                    isDownloadRunning = true;
                                                    downloadProgress = 0.0;
                                                  } else if (status.isDenied) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          LocaleKeys
                                                              .withoutThisPermissionAppCanNotDownloadFile
                                                              .translateText,
                                                        ),
                                                        action: SnackBarAction(
                                                          label: LocaleKeys
                                                              .setting
                                                              .translateText,
                                                          textColor:
                                                              Colors.white,
                                                          onPressed: () {
                                                            openAppSettings();
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .hideCurrentSnackBar();
                                                          },
                                                        ),
                                                        backgroundColor:
                                                            primaryBrown,
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                      ),
                                                    );
                                                  } else if (status
                                                      .isPermanentlyDenied) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          LocaleKeys
                                                              .toAccessThisFeaturePleaseGrantPermissionFromSettings
                                                              .translateText,
                                                        ),
                                                        action: SnackBarAction(
                                                          label: LocaleKeys
                                                              .setting
                                                              .translateText,
                                                          textColor:
                                                              Colors.white,
                                                          onPressed: () {
                                                            openAppSettings();
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .hideCurrentSnackBar();
                                                          },
                                                        ),
                                                        backgroundColor:
                                                            primaryBrown,
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
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
                        hintText:
                            LocaleKeys.please_note_your_comments.translateText,
                        suffixIcon: Assets.icons.icClip
                            .svg(
                          height: !isTablet ? 24 : 28,
                          width: !isTablet ? 24 : 28,
                          fit: BoxFit.scaleDown,
                        )
                            .onClick(
                          () {
                            context.hideKeyBoard(context);
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
                                bool isUploadFile = await ctrl
                                    .uploadCommentFile(file, ctrl.patientId);
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
                      onPressed: () async {
                        if (controller.commentController.text.isNotEmpty) {
                          context.hideKeyBoard(context);
                          bool isDone =
                              await controller.addTextPatientComments();
                          if (isDone) {
                            controller.getPatientCommentsDetails();
                          }
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
      ),
    );
  }
}
