import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/add_patient_repo/add_patient_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/notif_util.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class DevisController extends GetxController {
  bool firstNameError = false;
  bool lastNameError = false;
  bool emailError = false;
  bool totalAmountError = false;
  bool numberOfSemesterError = false;
  bool connectionError = false;
  bool isLoading = false;
  bool showNumberOfSemesterDropDown = false;
  String? dateTextField;
  String? selectedNumberOfSemester;
  DateTime? pickedDate;
  List numberOfSemester = ["1", "2", "3", "4", "5", "6"];
  GlobalKey<FormState> patientInformationFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController contentionPriceController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController numberOfSemesterController = TextEditingController();

  void getLynerConnectList(BuildContext context) async {
    isLoading = true;
    ResponseItem result = await AddPatientRepo.devisExport(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      dateOfBirth: dateOfBirthController.text.trim(),
      email: emailController.text.trim(),
      totalAmount: totalAmountController.text.trim(),
      numberOfSemester: numberOfSemesterController.text.trim(),
      contentionPrice: contentionPriceController.text.trim(),
    );
    try {
      if (result.status) {
        if (result.data != null) {
          String url = "${ApiUrl.estimateQuotesPdf}${result.data}";
          Get.back();
          await initDownLoadService().then(
            (value) async {
              await downloadFile(downLoadUrl: url).then((value) async {
                if (Platform.isIOS) {
                  await OpenFile.open(value);
                } else {
                  await OpenFile.open(value);
                }
              });
            },
          );

          // Future.delayed(
          //   Duration.zero,
          //   () async {
          //     if (await canLaunchUrl(Uri.parse(url))) {
          //       await launchUrl(Uri.parse(url));
          //     } else {
          //       throw 'Could not launch $url';
          //     }
          //   },
          // );
          // controller.setProgressValue(showDialogProgress: true);
          ///
          // Directory? baseStorage;
          // PermissionStatus status = await Permission.notification.request();
          //
          // String ext = url.split('.').last;
          // String name = url.split('/').last.split('.').first;
          // String fileName =
          //     '${name}_${DateTime.now().millisecondsSinceEpoch}.$ext';
          //
          // if (status.isGranted) {
          //   if (Platform.isIOS) {
          //     baseStorage = await getApplicationDocumentsDirectory();
          //   } else {
          //     baseStorage = await getExternalStorageDirectory();
          //   }
          //   String? taskId = await FlutterDownloader.enqueue(
          //     url: url,
          //     savedDir: baseStorage!.path,
          //     showNotification: true,
          //     openFileFromNotification: true,
          //     saveInPublicStorage: true,
          //     fileName: fileName,
          //   );
          //
          //   downloadTaskId['taskId'] = taskId;
          //   downloadTaskId['path'] = '${baseStorage.path}/$fileName';
          //   if (taskId != null) {
          //     downloadTaskId.putIfAbsent(
          //       taskId,
          //       () => downloadTaskId['path'],
          //     );
          //   }
          //   isDownloadRunning = true;
          //   downloadProgress = 0.0;
          // } else if (status.isDenied) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text(
          //         LocaleKeys
          //             .withoutThisPermissionAppCanNotDownloadFile.translateText,
          //       ),
          //       action: SnackBarAction(
          //         label: LocaleKeys.setting.translateText,
          //         textColor: Colors.white,
          //         onPressed: () {
          //           openAppSettings();
          //           ScaffoldMessenger.of(context).hideCurrentSnackBar();
          //         },
          //       ),
          //       backgroundColor: primaryBrown,
          //       behavior: SnackBarBehavior.floating,
          //     ),
          //   );
          // } else if (status.isPermanentlyDenied) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text(
          //         LocaleKeys
          //             .toAccessThisFeaturePleaseGrantPermissionFromSettings
          //             .translateText,
          //       ),
          //       action: SnackBarAction(
          //         label: LocaleKeys.setting.translateText,
          //         textColor: Colors.white,
          //         onPressed: () {
          //           openAppSettings();
          //           ScaffoldMessenger.of(context).hideCurrentSnackBar();
          //         },
          //       ),
          //       backgroundColor: primaryBrown,
          //       behavior: SnackBarBehavior.floating,
          //     ),
          //   );
          // }
          //
          // if (Platform.isIOS) {
          //   await OpenFile.open(value);
          // } else {
          //   await OpenFile.open(value);
          // }
          //
          // // await OpenFile.open('${baseStorage?.path}/$fileName');
          isLoading = false;
        }
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
    }
    update();
  }

  String? _localPath;

  Future initDownLoadService() async {
    _localPath = await _prepareSaveDir();
  }

  Future<String?> downloadFile({required String downLoadUrl}) async {
    String timestamp = DateTime.now().millisecond.toString();

    String appName = "lynerpro";
    String extension = downLoadUrl.split(".").last;
    String fileName = "$appName$timestamp.$extension";

    ValueNotifier<String> valueNotifier = ValueNotifier("");
    if (_localPath == null) {
      return null;
    }
    try {
      File file = File(_localPath! + fileName);
      valueNotifier.addListener(() {
        NotificationUtil.sendDownloadNotification(
          valueNotifier.value != '100' ? "Downloading..." : 'Download complete',
          "${valueNotifier.value} / 100%",
        );
      });

      await Dio().download(
        Uri.parse(downLoadUrl).toString(),
        file.path,
        onReceiveProgress: (int count, int total) async {
          var percent = (count / total * 100).toStringAsFixed(0).toString();
          percent.debugPrint;
          valueNotifier.value = percent;
        },
      );
      return file.path;
    } catch (e) {
      return null;
    }
  }

  Future<String?> _prepareSaveDir() async {
    String path = "";

    _findLocalPath().then(
      (String? value) async {
        path = value ?? '';
        if (value != null) {
          final savedDir = Directory(path);
          final hasExisted = savedDir.existsSync();
          if (!hasExisted) {
            await savedDir.create();
          }
          if (path.substring(path.length - 1) != "/") {
            return "$path/";
          }
        }
      },
    );
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
}
