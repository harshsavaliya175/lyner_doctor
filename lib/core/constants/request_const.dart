import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';

class ApiUrl {
  static const bool IS_LIVE = true;
  static const String API_DEV_URL =
      "https://lynertech.com/lyner-doctor-api/production/";
  static const String API_LIVE_URL =
      "https://lynertech.com/lyner-doctor-api/production/";
  static const String baseUrl =
      "${IS_LIVE ? API_LIVE_URL : API_DEV_URL}Service.php?";
  static const String baseImagePath = "https://lynertech.com/app_images/";
  static const String baseImagePatientPath = "${baseImagePath}patient/";
  static const String estimateQuotesPdf =
      "${baseImagePath}estimate_quotes_pdf/";
  static const String imageBasePath = "https://lynertech.com/app_images/";
  static const String clinicProfileImagePath = "${imageBasePath}clinic_photo/";
  //https://lynertech.com/app_images/doctor_profile/
  static const String doctorProfileImagePath =
      "${imageBasePath}doctor_profile/";
  static const String galleryImage = "${imageBasePath}gallery_images/";
  static const String patientImage = "${imageBasePath}patient/";
  static const String patientProfileImage = "${patientImage}patient_profile/";
  static const String patientGauche = "${patientImage}patient_gauche/";
  static const String patientFace = "${patientImage}patient_face/";
  static const String patientSourire = "${patientImage}patient_sourire/";
  static const String patientInterGauche =
      "${patientImage}patient_inter_gauche/";
  static const String patientInterFace = "${patientImage}patient_inter_face/";
  static const String lynerDetailsBaseUrl =
      "https://lynertech.com/mobile/app_images/gallery_images/";

  static const String lynerLibraryUrl =
      "https://lynertech.com/app_images/library_file/";
  static const String patientIntraDroite =
      "${patientImage}patient_intra_droite/";
  static const String patientIntraMax = "${patientImage}patient_intra_max/";
  static const String patientInterMandi =
      "${patientImage}patient_intra_gauche/";
  static const String patientPanoramique =
      "${patientImage}patient_panoramique/";
  static const String patientCephalometrique =
      "${patientImage}patient_cephalometrique/";
  static const String lowerJawStlFile = "${patientImage}lower_jaw_stl_file/";
  static const String upperJawStlFile = "${patientImage}upper_jaw_stl_file/";
  static const String dicomFile = "${baseImagePath}dcom_files/final/";
  static const String commentFile = "${baseImagePath}comment_files/final/";
}

class MethodNames {
  static const String clinicLogin = "clinicLogin";
  static const String clinicRegistrationRequest = "clinicRegistrationRequest";
  static const String forgotPassword = "forgotPassword";
  static const String updateClinicDetails = "updateClinicDetails";
  static const String changePasswordWithVerifyCode =
      "changePasswordWithVerifyCode";
  static const String changePassword = "changePassword";
  static const String updateDeviceToken = "updateDeviceToken";
  static const String getDoctorListByClinicId = "getDoctorListByClinicId";
  static const String getProductList = "getProductList";
  static const String getPatientInformationDetails =
      "getPatientInformationDetails";
  static const String getPatientRefinementImage = "getPatientRefinementImage";
  static const String getPatientContainmentImage = "getPatientContainmentImage";
  static const String exportEstimateQuotesPdf = "exportEstimateQuotesPdf";
  static const String getEstimateQuotesData = "getEstimateQuotesData";
  static const String getPatientPrescriptionDetails =
      "getPatientPrescriptionDetails";
  static const String getClinicBillingAddresList = "getClinicBillingAddresList";
  static const String deletePatient = "deletePatient";
  static const String getLynerConnectList = "getLynerConnectList";
  static const String getLynerConnectDetails = "getLynerConnectDetails";
  static const String getLynerConnectPatientsList =
      "getLynerConnectPatientsList";
  static const String addLynerConnectDetails = "addLynerConnectDetails";
  static const String editLynerConnectDetails = "editLynerConnectDetails";
  static const String addNewPatientStep1Step2 = "addNewPatientStep1Step2";
  static const String updatePatientDetails = "updatePatientDetails";
  static const String uploadPatientSingleImage = "uploadPatientSingleImage";
  static const String editPatientRefinementDetails =
      "editPatientRefinementDetails";
  static const String editPatientContainmentDetails =
      "editPatientContainmentDetails";
  static const String uploadPatientDcomFile = "uploadPatientDcomFile";
  static const String getClinicLocationList = "getClinicLocationList";
  static const String getLibraryList = "getLibraryList";
  static const String getPatientCommentsDetails = "getPatientCommentsDetails";
  static const String addTextPatientComments = "addTextPatientComments";
  static const String addFilePatientComments = "addFilePatientComments";
  static const String deletePatientTreatments = "deletePatientTreatments";
  static const String deleteLynerConnect = "deleteLynerConnect";
  static const String addEditPatientTreatments = "addEditPatientTreatments";
  static const String getPatientTreatmentsDetails =
      "getPatientTreatmentsDetails";
  static const String getClinicListBySearchOrFilter =
      "getClinicListBySearchOrFilter";
  static const String getGlobalSearchData = "getGlobalSearchData";
  static const String sendModification = "sendModification";
  static const String approveOrder = "approveOrder";
  static const String getFinancialList = "getFinancialList";
  static const String logout = "logout";
}

class RequestHeaderKey {
  static const String contentType = "Content-Type";
  static const String userAgent = "User-Agent";
  static const String appSecret = "App-Secret";
  static const String appTrackVersion = "App-Track-Version";
  static const String appDeviceType = "App-Device-Type";
  static const String appStoreVersion = "App-Store-Version";
  static const String appDeviceModel = "App-Device-Model";
  static const String appOsVersion = "App-Os-Version";
  static const String appStoreBuildNumber = "App-Store-Build-Number";
  static const String authToken = "Auth-Token";
}

class RequestParam {
  static const String service = "Service"; // -> pass method name
  static const String showError = "show_error"; // -> bool in String
}

const String SHOW_ERROR = "false";

Map<String, String> requestHeaders(bool passAuthToken) {
  return {
    "Content-Type": "application/json",
    "App-Secret": "LyDoctor@2024",
    "App-Track-Version": "v1",
    "App-Device-Type":
        preferences.getString(SharedPreference.APP_DEVICE_TYPE) ?? '',
    "App-Store-Version":
        preferences.getString(SharedPreference.APP_STORE_VERSION) ?? '',
    "App-Device-Model":
        preferences.getString(SharedPreference.APP_DEVICE_MODEL) ?? '',
    "App-Os-Version":
        preferences.getString(SharedPreference.APP_OS_VERSION) ?? '',
    "App-Store-Build-Number":
        preferences.getString(SharedPreference.APP_STORE_BUILD_NUMBER) ?? '',
    "App-TimeZone": preferences.getString(SharedPreference.TIME_ZONE) ?? '',
    if (passAuthToken)
      "Auth-Token": preferences.getString(SharedPreference.AUTH_TOKEN) ?? '',
  };
}

const int LIMIT = 10;

const USER_TYPE = "user";
const String patientIdString = "patientId";
const String commentString = "commentString";
const String refinementIdString = "refinementIdString";
const String isShowCheckModificationButtonString =
    "isShowCheckModificationButton";
const String reviewModification = "Review Modification";
const String isCallCommentApiString = "isCallCommentApiString";

bool isTablet = MediaQuery.of(Get.context!).size.width >= 500 ? true : false;

Map<String, dynamic> downloadTaskId = {};
ReceivePort receivePort = ReceivePort();
double downloadProgress = 0.0;
bool isDownloadRunning = false;
int isUploadRunning = 0;
const String channelId = "doctorApp_app_channel";
const String channelName = "doctorApp_app";
const String channelDes = "doctorApp_app_channel_des";

@pragma('vm:entry-point')
void downloadCallback(String id, int status, int progress) {
  final SendPort? send =
      IsolateNameServer.lookupPortByName('downloader_send_port');
  send?.send([id, status, progress]);
}

//const String patientId = "patient_id";
const String isRefinementString = "isRefinement";
const String isRetentionString = "isRetention";
