import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/patients/patients_controller.dart';
import 'package:lynerdoctor/ui/widgets/app_patient_card.dart';
import 'package:lynerdoctor/ui/widgets/doctor_patients_all_filter_bottom_sheet.dart';
import 'package:lynerdoctor/ui/widgets/patients_screen_filter_bottom_sheet.dart';

class PatientsScreen extends StatelessWidget {
  PatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 70.w,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  preferences.getString(SharedPreference.CLINIC_NAME) ?? '',
                  style: hintTextStyle(
                    size: 20,
                    color: Colors.black,
                    weight: FontWeight.w700,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, size: 35),
              ],
            ).onClick(
              () {
                // PatientsRepo.getDoctorListByClinicId(
                //     clinicId:
                //         preferences.getInt(SharedPreference.CLINIC_ID) ?? 0);
                context.showAppBottomSheet(
                  contentWidget: DraggableScrollableSheet(
                    initialChildSize: 0.50,
                    minChildSize: 0.50,
                    maxChildSize: 0.95,
                    expand: false,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return DoctorPatientsAllFilterBottomSheet(
                        controller: scrollController,
                      );
                    },
                  ),
                );
              },
            ),
            GetBuilder<PatientsController>(
              builder: (PatientsController ctrl) {
                return Text(
                  ctrl.appbarSubTitle,
                  style: hintTextStyle(
                    size: 14,
                    color: hintColor,
                    weight: FontWeight.w400,
                  ),
                );
              },
            ),
          ],
        ),
        titleSpacing: 20,
      ),
      body: GetBuilder<PatientsController>(
        builder: (PatientsController ctrl) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.space(),
              Row(
                children: [
                  Expanded(
                    child: CommonTextField(
                      prefixIcon: Assets.icons.icSearch,
                      hintText: LocaleKeys.search.translateText,
                      controller: ctrl.searchController,
                      action: TextInputAction.done,
                    ),
                  ),
                  12.space(),
                  SizedBox(
                    width: 60.w,
                    height: 60.w,
                    child: FloatingActionButton(
                      elevation: 0,
                      onPressed: () {
                        context.showAppBottomSheet(
                          contentWidget:
                              const PatientsScreenFilterBottomSheet(),
                        );
                      },
                      child: Assets.icons.icFilter.svg(
                        height: 28,
                        width: 28,
                        fit: BoxFit.none,
                        colorFilter: ColorFilter.mode(
                          whiteColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      heroTag: Object(),
                      shape: CircleBorder(),
                      backgroundColor: primaryBrown,
                    ),
                  )
                ],
              ),
              24.space(),
              'Tasks (9)'.appCommonText(
                weight: FontWeight.w500,
                size: 20,
                color: Colors.black,
              ),
              6.space(),
              Expanded(
                child: ListView.separated(
                  padding: REdgeInsets.only(bottom: 150, top: 6),
                  itemBuilder: (BuildContext context, int index) {
                    return AppPatientCard(
                      isEditCard: false,
                      title1: LocaleKeys.statusCom,
                      title2: LocaleKeys.patientIdCom,
                      title3: LocaleKeys.productCom,
                      data1: ' Draft',
                      data2: ' EROK',
                      data3: ' LYNER 20',
                      treatmentStartDate: '12/07/2024',
                      patientName: 'Leslie Alexander',
                      deleteOnTap: () {},
                      editOrSubmitOnTap: () {},
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      12.space(),
                  itemCount: 10,
                ),
              ),
            ],
          ).paddingOnly(left: 20, right: 20);
        },
      ),
    );
  }
}
