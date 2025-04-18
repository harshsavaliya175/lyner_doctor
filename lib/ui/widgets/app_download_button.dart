import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/patients_details/patients_details_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AppDownloadButton extends StatelessWidget {
  final String url;

  AppDownloadButton({
    super.key,
    required this.url,
  });

  final PatientsDetailsController controller =
      Get.put(PatientsDetailsController());

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        controller.setProgressValue(showDialogProgress: true);
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
                LocaleKeys.toAccessThisFeaturePleaseGrantPermissionFromSettings
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
      },
      icon: Icon(
        Icons.download,
        size: !isTablet ? 28 : 34,
        color: primaryBrown,
      ),
    );
  }
}
