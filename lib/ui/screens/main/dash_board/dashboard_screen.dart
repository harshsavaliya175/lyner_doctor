import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/dash_board/dashboard_controller.dart';
import 'package:lynerdoctor/ui/widgets/bottom_bar_item.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

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
                    itemText: LocaleKeys.patients,
                    onTap: () {
                      ctrl.changeData(currentIdx: 0);
                    },
                  ),
                ),
                Expanded(
                  child: BottomBarItem(
                    currentIndex: ctrl.currentIndex,
                    itemIcon: Assets.icons.icLynerConnect,
                    itemIndex: 1,
                    itemText: LocaleKeys.lynerConnect,
                    onTap: () {
                      ctrl.changeData(currentIdx: 1);
                    },
                  ),
                ),
                Expanded(child: SizedBox()),
                Expanded(
                  child: BottomBarItem(
                    currentIndex: ctrl.currentIndex,
                    itemIcon: Assets.icons.icLibrary,
                    itemIndex: 2,
                    itemText: LocaleKeys.library,
                    onTap: () {
                      ctrl.changeData(currentIdx: 2);
                    },
                  ),
                ),
                Expanded(
                  child: BottomBarItem(
                    currentIndex: ctrl.currentIndex,
                    itemIcon: Assets.icons.icProfile,
                    itemIndex: 3,
                    itemText: LocaleKeys.profile,
                    onTap: () {
                      ctrl.changeData(currentIdx: 3);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.addPatientScreen);
        },
        child: Icon(Icons.add, size: 40, color: whiteColor),
        heroTag: Object(),
        shape: CircleBorder(),
        backgroundColor: primaryBrown,
      ),
    );
  }
}
