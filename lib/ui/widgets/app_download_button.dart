import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AppDownloadButton extends StatelessWidget {
  final String url;

  const AppDownloadButton({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: IconButton(
        onPressed: () async {
          // DashboardCubit dashBoardCubit =
          //     BlocProvider.of<DashboardCubit>(context);
          // dashBoardCubit.setProgressValue(showProgressDialog: true);
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
                  "Without this permission app can not download file.",
                ),
                action: SnackBarAction(
                  label: "Setting",
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
                  "To access this feature please grant permission from settings.",
                ),
                action: SnackBarAction(
                  label: "Setting",
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
      ),
    );
  }
}
