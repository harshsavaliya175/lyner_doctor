import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/add_patient_repo/add_patient_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
  List numberOfSemester = ["1", "2", "3", "4", "5", "6", "7", "8"];
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
          Get.back();
          String url = "${ApiUrl.estimateQuotesPdf}${result.data}";
          // controller.setProgressValue(showDialogProgress: true);
          Directory? baseStorage;
          PermissionStatus status = await Permission.notification.request();

          String ext = url.split('.').last;
          String name = url.split('/').last.split('.').first;
          String fileName =
              '${name}_${DateTime.now().millisecondsSinceEpoch}.$ext';

          if (status.isGranted) {
            if (Platform.isIOS) {
              baseStorage = await getApplicationDocumentsDirectory();
            } else {
              baseStorage = await getExternalStorageDirectory();
            }
            String? taskId = await FlutterDownloader.enqueue(
              url: url,
              savedDir: baseStorage!.path,
              showNotification: true,
              openFileFromNotification: true,
              saveInPublicStorage: true,
              fileName: fileName,
            );

            downloadTaskId['taskId'] = taskId;
            downloadTaskId['path'] = '${baseStorage.path}/$fileName';
            File file = File("${baseStorage.path}/$fileName");
            final RandomAccessFile raf = file.openSync(mode: FileMode.read);
            // raf.writeFromSync(buffer);
            if (taskId != null) {
              downloadTaskId.putIfAbsent(
                taskId,
                () => downloadTaskId['path'],
              );
            }
            isDownloadRunning = true;
            downloadProgress = 0.0;
          } else if (status.isDenied) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  LocaleKeys
                      .withoutThisPermissionAppCanNotDownloadFile.translateText,
                ),
                action: SnackBarAction(
                  label: LocaleKeys.setting.translateText,
                  textColor: Colors.white,
                  onPressed: () {
                    openAppSettings();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
                backgroundColor: primaryBrown,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (status.isPermanentlyDenied) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  LocaleKeys
                      .toAccessThisFeaturePleaseGrantPermissionFromSettings
                      .translateText,
                ),
                action: SnackBarAction(
                  label: LocaleKeys.setting.translateText,
                  textColor: Colors.white,
                  onPressed: () {
                    openAppSettings();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
                backgroundColor: primaryBrown,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }

          await OpenFile.open(baseStorage?.path ?? "");
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
}
