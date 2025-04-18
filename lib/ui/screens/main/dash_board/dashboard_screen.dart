import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/notif_util.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/dash_board/dashboard_controller.dart';
import 'package:lynerdoctor/ui/screens/main/patients/patients_controller.dart';
import 'package:lynerdoctor/ui/widgets/bottom_bar_item.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    registerIsolateProgress();
    super.initState();
  }

  Future<void> registerIsolateProgress() async {
    IsolateNameServer.registerPortWithName(
      receivePort.sendPort,
      'downloader_send_port',
    );

    receivePort.listen(
      (message) async {
        String id = message[0];
        String status = message[1].toString();
        int progress = int.tryParse(message[2].toString()) ?? 0;
        downloadProgress = progress.toDouble();
        // ctrl.setProgressValue(downloadProgress: downloadProgress);

        if (downloadProgress == 100) {
          receivePort.sendPort.send('Done');

          await NotificationUtil.showProgressBarNotification(
            11, // Notification ID
            "Download file successful.",
            "Successfully uploaded",
            100, // Current progress
            100, // Max progress
          ).then((value) async {
            await NotificationUtil.instance().cancel(1);
            Future.delayed(const Duration(minutes: 1), () {
              NotificationUtil.instance().cancel(11);
            });
          });
        }
        if (status == DownloadTaskStatus.complete.index) {
          if (Platform.isIOS) {
            File file = File(downloadTaskId[id]);
            if (file.path.isImageFileName) {
              Uint8List imageBytes = file.readAsBytesSync();
              await ImageGallerySaver.saveImage(imageBytes, quality: 100);
            }
          }
          // showAppSnackBar("File download successfully.");
          downloadTaskId.remove(id);
          if (downloadTaskId.keys.isEmpty) {
            isDownloadRunning = false;
            downloadProgress = 0.0;
          }
        }
        if (status == DownloadTaskStatus.failed.index) {
          downloadTaskId.remove(id);
          if (downloadTaskId.keys.isEmpty) {
            downloadProgress = 0.0;
            isDownloadRunning = false;
          }
        }
      },
    );
    await FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    receivePort.close();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: appBgColor,
      body: GetBuilder<DashboardController>(
        builder: (DashboardController controller) {
          return controller.screen[controller.currentIndex];
        },
      ).paddingOnly(bottom: !isTablet ? 35 : 45),
      bottomNavigationBar: GetBuilder<DashboardController>(
        builder: (DashboardController ctrl) {
          return BottomAppBar(
            height: !isTablet ? 75.h : 85.h,
            padding: EdgeInsets.zero,
            notchMargin: 12.w,
            color: Colors.white,
            shape: CircularNotchedRectangle(),
            elevation: 20,
            shadowColor: Colors.grey,
            child: Row(
              children: [
                Expanded(
                  child: BottomBarItem(
                    currentIndex: ctrl.currentIndex,
                    itemIcon: Assets.icons.icPatients,
                    itemIndex: 0,
                    itemText: LocaleKeys.caseSelection,
                    onTap: () {
                      ctrl.changeData(currentIdx: 0);
                      // Get.find<PatientsController>()
                      //     .getClinicListBySearchOrFilter();
                    },
                  ),
                ),
                Expanded(
                  child: BottomBarItem(
                    currentIndex: ctrl.currentIndex,
                    itemIcon: Assets.icons.icPatients,
                    itemIndex: 1,
                    itemText: LocaleKeys.patients,
                    onTap: () {
                      ctrl.changeData(currentIdx: 1);
                      Get.find<PatientsController>()
                          .getClinicListBySearchOrFilter();
                    },
                  ),
                ),
                Expanded(child: SizedBox()),
                Expanded(
                  child: BottomBarItem(
                    currentIndex: ctrl.currentIndex,
                    itemIcon: Assets.icons.icLynerConnect,
                    itemIndex: 2,
                    itemText: LocaleKeys.lynerConnect,
                    onTap: () {
                      ctrl.changeData(currentIdx: 2);
                    },
                  ),
                ),
                Expanded(
                  child: BottomBarItem(
                    currentIndex: ctrl.currentIndex,
                    itemIcon: Assets.icons.icLibrary,
                    itemIndex: 3,
                    itemText: LocaleKeys.library,
                    onTap: () {
                      ctrl.changeData(currentIdx: 3);
                    },
                  ),
                ),
                // Expanded(
                //   child: BottomBarItem(
                //     currentIndex: ctrl.currentIndex,
                //     itemIcon: Assets.icons.icProfile,
                //     itemIndex: 4,
                //     itemText: LocaleKeys.profile,
                //     onTap: () {
                //       ctrl.changeData(currentIdx: 4);
                //     },
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          GetBuilder<DashboardController>(builder: (DashboardController ctrl) {
        return FloatingActionButton(
          onPressed: () {
            if (ctrl.currentIndex == 0) {
              Get.toNamed(Routes.addCaseSelection);
            } else {
              Get.toNamed(Routes.addPatientScreen, arguments: null);
            }
            // Get.toNamed(Routes.addPatientScreen, arguments: null);
          },
          child: Icon(Icons.add, size: 40, color: whiteColor),
          heroTag: Object(),
          shape: CircleBorder(),
          backgroundColor: primaryBrown,
        );
      }),
    );
  }
}
