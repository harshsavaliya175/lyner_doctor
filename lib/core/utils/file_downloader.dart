import 'dart:io';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

import '../../generated/locale_keys.g.dart';
import '../constants/app_color.dart';
import '../constants/request_const.dart';

Future<void> downloadFile(String url, BuildContext context) async {
  Directory? baseStorage;
  PermissionStatus status;

  if (Platform.isIOS) {
    status = await Permission.photos.request();
  } else {
    status = await Permission.storage.request();
  }

  String ext = url.split('.').last;
  String name = url.split('/').last.split('.').first;
  String fileName = '${name}_${DateTime.now().millisecondsSinceEpoch}.$ext';

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

    if (taskId != null) {
      downloadTaskId[taskId] = '${baseStorage.path}/$fileName';
    }

    isDownloadRunning = true;
    downloadProgress = 0.0;
  } else if (status.isDenied) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(LocaleKeys
            .withoutThisPermissionAppCanNotDownloadFile.translateText),
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
        content: Text(LocaleKeys
            .toAccessThisFeaturePleaseGrantPermissionFromSettings
            .translateText),
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
}
