import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/add_patient_repo/add_patient_repo.dart';
import 'package:lynerdoctor/api/patients_repo/patients_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/notif_util.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/model/clinic_location_model.dart';
import 'package:lynerdoctor/model/clinic_model.dart';
import 'package:lynerdoctor/model/reports_estimation.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class DevisController extends GetxController {
  @override
  void onInit() {
    getEstimateQuotesData();
    if (preferences.getString(SharedPreference.LOGIN_TYPE) ==
        SharedPreference.LOGIN_TYPE_CLINIC) {
      getDoctorList();
      getClinicLocationList();
    } else {
      clinicData = preferences.getClinicData();
    }
    super.onInit();
  }

  bool firstNameError = false;
  bool lastNameError = false;
  bool emailError = false;
  bool totalAmountError = false;
  bool numberOfSemesterError = false;
  bool connectionError = false;
  bool patientSocialSecurityNumberError = false;
  bool complementaryOrganizationNumberError = false;
  bool contractorMemberNumberError = false;
  bool fileReferenceError = false;
  bool addressError = false;
  bool isLoading = false;
  bool showNumberOfSemesterDropDown = false;
  bool addressDropDown = false;

  bool showDoctorDropDown = false;
  String? dateTextField;
  String? selectedNumberOfSemester;
  String? address;
  DateTime? pickedDate;
  List numberOfSemester = ["1", "2", "3", "4", "5", "6"];
  List<DoctorData?> doctorDataList = [];
  List<ClinicLocation?> clinicLocationList = [];
  List<EstimateQuotesData?> getEstimationReportList = [];
  DoctorData? selectedDoctorData;
  ClinicData? clinicData;
  GlobalKey<FormState> patientInformationFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController contentionPriceController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController numberOfSemesterController = TextEditingController();
  TextEditingController doctorController = TextEditingController();
  TextEditingController patientSocialSecurityNumber = TextEditingController();
  TextEditingController complementaryOrganizationNumber =
      TextEditingController();
  TextEditingController contractorMemberNumberController =
      TextEditingController();
  TextEditingController fileReferenceController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  void getLynerConnectList(BuildContext context) async {
    isLoading = true;
    ResponseItem result = await AddPatientRepo.devisExport(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      dateOfBirth: dateOfBirthController.text.trim().replaceAll("/", "-"),
      email: emailController.text.trim(),
      totalAmount: totalAmountController.text.trim(),
      numberOfSemester: numberOfSemesterController.text.trim(),
      contentionPrice: contentionPriceController.text.trim(),
      address: addressController.text.trim(),
      complementaryOrganizationName:
          complementaryOrganizationNumber.text.trim(),
      contractOrMemberNumber: contractorMemberNumberController.text.trim(),
      fileReference: fileReferenceController.text.trim(),
      patientSocialSecurityNumber: patientSocialSecurityNumber.text.trim(),
      doctorId: selectedDoctorData != null
          ? selectedDoctorData!.doctorId
          : clinicData!.doctorData!.doctorId,
    );
    try {
      if (result.status) {
        if (result.data != null) {
          getEstimateQuotesData();
          String url = "${ApiUrl.estimateQuotesPdf}${result.data}";
          Get.back();
          await initDownLoadService();
          await downloadFile(downLoadUrl: url).then(
            (String? value) async {
              if (value != null && await File(value).exists()) {
                if (Platform.isIOS) {
                  await OpenFile.open(value);
                } else {
                  await OpenFile.open(value);
                }
              } else {
                showAppSnackBar(LocaleKeys.fileHasNotDownloaded.translateText);
              }
            },
          );
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

  getClinicLocationList() async {
    clinicLocationList.clear();
    ResponseItem result = await PatientsRepo.getClinicLocationList(
        clinicId: preferences.getInt(SharedPreference.CLINIC_ID) ?? 0);
    try {
      if (result.status) {
        if (result.data != null) {
          result.data.forEach(
            (dynamic e) {
              ClinicLocation clinicLocation = ClinicLocation.fromJson(e);
              clinicLocationList.add(clinicLocation);
            },
          );
        }
      }
    } catch (e) {
      log('error --> $e');
    }
    update();
  }

  getEstimateQuotesData() async {
    isLoading = true;
    ResponseItem result = await AddPatientRepo.getEstimateQuotesData();
    try {
      if (result.status) {
        GetEstimateQuotesData res =
            GetEstimateQuotesData.fromJson(result.toJson());
        // List<EstimateQuotesData>.from(json["data"]!.map((x) => EstimateQuotesData.fromJson(x))),
        if (res.data != null) {
          getEstimationReportList = res.data ?? [];
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

  onShowTap(String data) async {
    String url = "${ApiUrl.estimateQuotesPdf}${data}";
    isLoading = true;
    try {
      await initDownLoadService();
      await downloadFile(downLoadUrl: url).then(
        (String? value) async {
          if (value != null && await File(value).exists()) {
            if (Platform.isIOS) {
              await OpenFile.open(value);
            } else {
              await OpenFile.open(value);
            }
          } else {
            showAppSnackBar(LocaleKeys.fileHasNotDownloaded.translateText);
          }
        },
      );
    } catch (e) {
      print("Error in Showing Report");
      isLoading = false;
    }
    isLoading = false;
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
    var value = await _findLocalPath();
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

  getDoctorList() async {
    doctorDataList.clear();
    isLoading = true;
    ResponseItem result = await PatientsRepo.getDoctorListByClinicId(
        clinicId: preferences.getInt(SharedPreference.CLINIC_ID) ?? 0);
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          result.data.forEach(
            (dynamic e) {
              DoctorData doctorData = DoctorData.fromJson(e);
              doctorDataList.add(doctorData);
            },
          );
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
