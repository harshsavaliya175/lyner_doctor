import 'package:lynerdoctor/core/utils/shared_prefs.dart';

class ApiUrl {
  static const bool IS_LIVE = true;
  static const String API_DEV_URL =
      "https://lynertech.com/lyner-doctor-api/production/";
  static const String API_LIVE_URL =
      "https://lynertech.com/lyner-doctor-api/production/";
  static const String baseUrl =
      "${IS_LIVE ? API_LIVE_URL : API_DEV_URL}Service.php?";
  static const String imagePath =
      "http://codonnier.tech/ghanshyam/lyner/app_images/profile_images/";
  static const String galleryImage =
      "https://lynertech.com/mobile/app_images/gallery_images/";
}

class MethodNames {
  static const String clinicLogin = "clinicLogin";
  static const String clinicRegistrationRequest = "clinicRegistrationRequest";
  static const String forgotPassword = "forgotPassword";
  static const String changePasswordWithVerifyCode =
      "changePasswordWithVerifyCode";
  static const String updateDeviceToken = "updateDeviceToken";
  static const String getDoctorListByClinicId = "getDoctorListByClinicId";
  static const String getProductList = "getProductList";
  static const String getClinicBillingAddresList = "getClinicBillingAddresList";
  static const String addNewPatientStep1Step2 = "addNewPatientStep1Step2";
  static const String uploadPatientSingleImage = "uploadPatientSingleImage";
  static const String getClinicLocationList = "getClinicLocationList";
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
