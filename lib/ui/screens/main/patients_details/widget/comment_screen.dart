import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/image_picker.dart';
import 'package:lynerdoctor/core/utils/push_notification_utils.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/model/comment_model.dart';
import 'package:lynerdoctor/ui/screens/main/patients_details/patients_details_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_button.dart';
import 'package:lynerdoctor/ui/widgets/common_dialog.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CommentScreen extends StatefulWidget {
  CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final ScrollController scrollController = ScrollController();
  final PatientsDetailsController controller =
      Get.put(PatientsDetailsController());

  @override
  void initState() {
    super.initState();
    // Scroll to the bottom after a short delay to ensure the UI is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void showConfirmationDialog(
      BuildContext context, PatientsDetailsController ctrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          titlePadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          content: Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: LocaleKeys.caseValidation.translateText
                      .normalText(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )
                      .center,
                ),
                Divider(color: Colors.grey, height: 0),
                20.space(),
                ("Veuillez prendre connaissance des conditions suivantes")
                    .normalText(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      textAlign: TextAlign.center,
                    )
                    .paddingSymmetric(horizontal: 16),
                20.space(),
                ("J’autorise Lyner Technology, conformément aux lois et réglementations en vigueur, à traiter ces informations. En outre, je consens à obtenir un formulaire de consentement du patient signé avant la soumission, qui autorise Lyner Technology à gérer et à traiter les informations du cas.Je comprends et j’accepte que le plan de traitement 3D fourni par Lyner Technology est conçu conformément aux informations que j’ai fournies. J’ai toujours le droit d’approuver le plan de traitement 3D et j’assume l’entière responsabilité du résultat final du traitement.")
                    .normalText(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      textAlign: TextAlign.center,
                    )
                    .paddingSymmetric(horizontal: 16)
                    .center,
                20.space(),
                Row(
                  children: [
                    GetBuilder<PatientsDetailsController>(
                        builder: (PatientsDetailsController ctrl) {
                      return Checkbox(
                        value: ctrl.isCheck,
                        onChanged: (bool? value) {
                          ctrl.isCheck = !ctrl.isCheck;
                          ctrl.update();
                        },
                      );
                    }),
                    Expanded(
                        child:
                            ("J’ai obtenu le formulaire de consentement du patient pour ce cas.")
                                .normalText(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      textAlign: TextAlign.center,
                    )),
                  ],
                ),
                20.space(),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        btnHeight: !isTablet ? 55 : 60,
                        text: LocaleKeys.back.translateText,
                        fontColor: Colors.red,
                        onTap: () {
                          Get.back();
                        },
                        bgColor: Colors.white,
                        buttonBorderColor: primaryBrown,
                      ),
                    ),
                    20.space(),
                    Expanded(
                      child: AppButton(
                        btnHeight: !isTablet ? 55 : 60,
                        text: LocaleKeys.continueText.translateText,
                        fontColor: Colors.white,
                        onTap: () async {
                          if (ctrl.bondDateController.text.trim().isNotEmpty) {
                            if (ctrl.isCheck) {
                              Get.back();
                              ctrl.approveOrder(context);
                            } else {
                              showAppSnackBar(
                                  LocaleKeys.pleaseCheckTheBox.translateText);
                            }
                          } else {
                            showAppSnackBar(
                                LocaleKeys.pleaseSelectBondDate.translateText);
                          }
                        },
                        bgColor: primaryBrown,
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 20),
                20.space(),
              ],
            ),
          ),
        );
      },
    );
  }

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
            scrollToBottom();
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.space(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LocaleKeys.lyner_ortho.translateText.normalText(
                      fontWeight: FontWeight.w600,
                      fontSize: !isTablet ? 20 : 24,
                    ),
                    if (controller
                            .patientDetailsModel?.latestPassword?.isNotEmpty ??
                        false)
                      Row(
                        children: [
                          controller.patientDetailsModel!.latestPassword!
                              .normalText(
                            fontWeight: FontWeight.w500,
                            fontSize: !isTablet ? 16 : 19,
                          ),
                          if (isTablet) 5.space(),
                          InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(
                                  text: controller
                                      .patientDetailsModel!.latestPassword!,
                                ),
                              );
                              showAppSnackBar(
                                  LocaleKeys.password_copied.translateText);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Icon(
                                Icons.copy,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                if (controller
                        .patientDetailsModel?.latestPassword?.isNotEmpty ??
                    false)
                  Row(
                    children: [
                      Spacer(),
                      Icon(Icons.info_outline, size: 14),
                      2.space(),
                      (LocaleKeys.clickOnItToCopyThePassword.translateText)
                          .normalText(
                        fontSize: !isTablet ? 10 : 12,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
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
                          reverse: true,
                          // controller: scrollController,
                          itemCount: controller.commentModelList.length,
                          padding: EdgeInsets.only(top: 5, bottom: 50),
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
                                              ? "${commentModel?.docFirstName ?? ""} ${commentModel?.docLastName ?? ""}"
                                              : LocaleKeys.lyner)
                                          .translateText
                                          .normalText(
                                            fontWeight: FontWeight.w500,
                                            fontSize: !isTablet ? 16 : 19,
                                            color: blackColor,
                                          ),
                                      ((commentModel?.createdAt
                                                  ?.ddMMYyyyHhMmA() ??
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
                                                  if (Platform.isIOS) {
                                                    String url = ApiUrl
                                                            .commentFile +
                                                        (commentModel
                                                                ?.fileName ??
                                                            '');
                                                    await initDownLoadService();
                                                    await downloadFile(
                                                            downLoadUrl: url,
                                                            fileName: commentModel
                                                                    ?.fileName ??
                                                                '')
                                                        .then(
                                                      (value) async {
                                                        if (value != null) {
                                                          if (Platform.isIOS) {
                                                            await OpenFile.open(
                                                                value);
                                                          } else {
                                                            await OpenFile.open(
                                                                value);
                                                          }
                                                        } else {}
                                                      },
                                                    );
                                                  } else {
                                                    String url = ApiUrl
                                                            .commentFile +
                                                        (commentModel
                                                                ?.fileName ??
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
                                                        saveInPublicStorage:
                                                            true,
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
                                                    } else if (status
                                                        .isDenied) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            LocaleKeys
                                                                .withoutThisPermissionAppCanNotDownloadFile
                                                                .translateText,
                                                          ),
                                                          action:
                                                              SnackBarAction(
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
                                                          action:
                                                              SnackBarAction(
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
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                  6.space(),
                                  (commentModel?.sentByClinic == 0)
                                      ? (commentModel?.planLink?.isNotEmpty ??
                                              false)
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: InkWell(
                                                        child:
                                                            ("Plan ${commentModel?.planNumber ?? ""}")
                                                                .normalText(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: !isTablet
                                                              ? 14
                                                              : 16,
                                                          color: Colors.blue,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                        ),
                                                        onTap: () {
                                                          Get.toNamed(
                                                            Routes
                                                                .treatmentPlanning,
                                                            arguments: {
                                                              link: commentModel
                                                                      ?.planLink ??
                                                                  "",
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(
                                                            Icons.lock,
                                                            size: !isTablet
                                                                ? 16
                                                                : 20,
                                                          ),
                                                          Expanded(
                                                            child:
                                                                ("${commentModel?.linkPassword ?? ""}")
                                                                    .normalText(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize:
                                                                  !isTablet
                                                                      ? 14
                                                                      : 16,
                                                              color: blackColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                          : SizedBox()
                                      : SizedBox()
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                Visibility(
                  visible: ctrl.isShowModificationButton,
                  child: Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          btnHeight: !isTablet ? 40 : 45,
                          fontSize: 16,
                          text: LocaleKeys.sendModification.translateText,
                          fontColor: controller.commentController.text
                                  .trim()
                                  .isNotEmpty
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                          onTap: () async {
                            if (ctrl.commentController.text.trim().isNotEmpty) {
                              ctrl.sendModification();
                            }
                          },
                          bgColor: controller.commentController.text
                                  .trim()
                                  .isNotEmpty
                              ? primaryBrown
                              : primaryBrown.withOpacity(0.5),
                        ),
                      ),
                      5.space(),
                      Expanded(
                        child: AppButton(
                          btnHeight: !isTablet ? 40 : 45,
                          fontSize: 16,
                          text: LocaleKeys.approveOrder.translateText,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  insetPadding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  titlePadding: EdgeInsets.zero,
                                  actionsPadding: EdgeInsets.zero,
                                  surfaceTintColor: Colors.white,
                                  backgroundColor: Colors.white,
                                  content: Container(
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: LocaleKeys
                                              .approveOrder.translateText
                                              .normalText(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              )
                                              .center,
                                        ),
                                        Divider(color: Colors.grey, height: 0),
                                        20.space(),
                                        AppTextField(
                                          textEditingController:
                                              ctrl.bondDateController,
                                          readOnly: true,
                                          showCursor: false,
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              ctrl.emailError = true;
                                              ctrl.update();
                                              return "Please select bond date.";
                                            }
                                            ctrl.update();
                                            return null;
                                          },
                                          onTap: () async {
                                            ctrl.bondDate =
                                                await bondingDatePickerDialog(
                                              context: context,
                                              currentTime: ctrl.bondDate == null
                                                  ? ctrl.bondDateController.text
                                                          .isNotEmpty
                                                      ? DateFormat(
                                                          "dd/MM/yyyy",
                                                          (preferences.getString(
                                                                          SharedPreference
                                                                              .LANGUAGE_CODE) ??
                                                                      '')
                                                                  .isNotEmpty
                                                              ? preferences.getString(
                                                                  SharedPreference
                                                                      .LANGUAGE_CODE)
                                                              : 'fr',
                                                        ).parse(ctrl
                                                          .bondDateController
                                                          .text)
                                                      : null
                                                  : ctrl.bondDate,
                                            );
                                            // ctrl.bondDate =
                                            //     await datePickerDialog(
                                            //   context: Get.context!,
                                            //   isDateOfBirth: false,
                                            //   currentTime: ctrl.bondDate == null
                                            //       ? ctrl.bondDateController.text
                                            //               .isNotEmpty
                                            //           ? DateFormat(
                                            //               "dd/MM/yyyy",
                                            //               (preferences.getString(
                                            //                               SharedPreference
                                            //                                   .LANGUAGE_CODE) ??
                                            //                           '')
                                            //                       .isNotEmpty
                                            //                   ? preferences.getString(
                                            //                       SharedPreference
                                            //                           .LANGUAGE_CODE)
                                            //                   : 'fr',
                                            //             ).parse(ctrl
                                            //               .bondDateController
                                            //               .text)
                                            //           : null
                                            //       : ctrl.bondDate,
                                            // );
                                            if (ctrl.bondDate != null) {
                                              ctrl.bondDateController.text =
                                                  DateFormat(
                                                'dd/MM/yyyy',
                                                (preferences.getString(
                                                                SharedPreference
                                                                    .LANGUAGE_CODE) ??
                                                            '')
                                                        .isNotEmpty
                                                    ? preferences.getString(
                                                        SharedPreference
                                                            .LANGUAGE_CODE)
                                                    : 'fr',
                                              ).format(ctrl.bondDate!);
                                            }
                                            ctrl.update();
                                          },
                                          textFieldPadding: EdgeInsets.zero,
                                          keyboardType: TextInputType.text,
                                          // isError: ctrl.emailError,
                                          hintText: LocaleKeys
                                              .dateField.translateText,
                                          labelText: LocaleKeys
                                              .bondingDate.translateText,
                                          showPrefixIcon: false,
                                        ).paddingSymmetric(horizontal: 20),
                                        20.space(),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: AppButton(
                                                btnHeight: !isTablet ? 55 : 60,
                                                text: LocaleKeys
                                                    .save.translateText,
                                                fontColor: Colors.white,
                                                onTap: () async {
                                                  if (ctrl
                                                      .bondDateController.text
                                                      .trim()
                                                      .isNotEmpty) {
                                                    Get.back();
                                                    showConfirmationDialog(
                                                        context, ctrl);
                                                    // ctrl.approveOrder(context);
                                                  } else {
                                                    showAppSnackBar(LocaleKeys
                                                        .pleaseSelectBondDate
                                                        .translateText);
                                                  }
                                                },
                                                bgColor: primaryBrown,
                                              ),
                                            ),
                                            20.space(),
                                            Expanded(
                                              child: AppButton(
                                                btnHeight: !isTablet ? 55 : 60,
                                                text: LocaleKeys
                                                    .cancel.translateText,
                                                fontColor: Colors.red,
                                                onTap: () {
                                                  Get.back();
                                                },
                                                bgColor: Colors.white,
                                                buttonBorderColor: primaryBrown,
                                              ),
                                            ),
                                          ],
                                        ).paddingSymmetric(horizontal: 20),
                                        20.space(),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          bgColor: Colors.white,
                          buttonBorderColor: primaryBrown,
                        ),
                      ),
                    ],
                  ).paddingOnly(top: 5),
                ),
                if (ctrl.isShowAddCommentFiled)
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          controller: controller.commentController,
                          hintText: LocaleKeys
                              .please_note_your_comments.translateText,
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
                      Visibility(
                        visible: !(ctrl.isShowModificationButton),
                        child: FloatingActionButton(
                          onPressed: () async {
                            if (controller.commentController.text.isNotEmpty) {
                              context.hideKeyBoard(context);
                              if (!(ctrl.isCallCommentApi)) {
                                bool isDone =
                                    await controller.addTextPatientComments();
                                if (isDone) {
                                  controller.getPatientCommentsDetails();
                                }
                              } else {
                                ctrl.sendModification();
                              }
                            }
                          },
                          child: Assets.icons.icSend.svg(),
                          shape: CircleBorder(),
                          backgroundColor: primaryBrown,
                        ).paddingOnly(left: 12),
                      ),
                    ],
                  ).paddingOnly(top: 5, bottom: 15),
              ],
            );
          },
        ),
      ),
    );
  }

  String? _localPath;

  Future initDownLoadService() async {
    _localPath = await _prepareSaveDir();
  }

  Future<String?> _prepareSaveDir() async {
    String path = (await _findLocalPath())!;
    final savedDir = Directory(path);
    final hasExisted = savedDir.existsSync();
    if (!hasExisted) {
      await savedDir.create();
    }
    if (path.substring(path.length - 1) != "/") {
      return "$path/";
    }
    return path;
  }

  Future<String?> _findLocalPath() async {
    String? externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }

  Future<String?> downloadFile({
    required String downLoadUrl,
    required String fileName,
  }) async {
    ValueNotifier<String> valueNotifier = ValueNotifier("");
    if (_localPath == null) {
      return null;
    }
    try {
      File file = File(_localPath! + fileName);
      valueNotifier.addListener(() {
        NotificationUtils.sendDownloadNotification(
          // valueNotifier.value != '100' ? "downloading..." : 'download complete',
          // "${valueNotifier.value} / 100%",
          "Download file successful.", // Title
          "Successfully uploaded", // Content
        );
      });

      await Dio().download(Uri.parse(downLoadUrl).toString(), file.path,
          onReceiveProgress: (int count, int total) async {
        var percent = (count / total * 100).toStringAsFixed(0).toString();
        print('Downloaded: $percent');
        valueNotifier.value = percent;
      });
      return file.path;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
