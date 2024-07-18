import 'package:lynerdoctor/core/utils/shared_prefs.dart';

class ApiUrl {
  static const bool IS_LIVE = true;
  static const String API_DEV_URL = "http://codonnier.tech/ghanshyam/lyner/dev";
  static const String API_LIVE_URL = "https://lynertech.com/mobile/dev";
  static const String baseUrl =
      "${IS_LIVE ? API_LIVE_URL : API_DEV_URL}/Service.php?";
  static const String imagePath =
      "http://codonnier.tech/ghanshyam/lyner/app_images/profile_images/";
  static const String galleryImage =
      "https://lynertech.com/mobile/app_images/gallery_images/";
}

class MethodNames {
  static const String updateDeviceToken = "updateDeviceToken";
  static const String registration = "registration";
  static const String login = "login";
  static const String forgotPassword = "forgotPassword";
  static const String changePassword = "changePassword";
  static const String updateUserDetails = "updateUserDetails";
  static const String getUserDetails = "getUserDetailsFromId";
  static const String saveUserLatLng = "saveUserLatLng";
  static const String checkEmailExistsOrNot = "checkEmailExistsOrNot";
  static const String getAllStateList = "getAllStateList";
  static const String getAllCompaniesList = "getAllCompaniesList";
  static const String stateNotifyOnOff = "stateNotifyOnOff";
  static const String changePasswordWithVerifyCode =
      "changePasswordWithVerifyCode";
  static const String logOut = "logout";
  static const String deleteAccount = "deleteAccount";
  static const String addAlignerSchedule = "addAlignerSchedule";
  static const String getAlignerScheduleList = "getAlignerScheduleList";
  static const String editAlignerSchedule = "editAlignerSchedule";
  static const String getAlignerDetails = "getAlignerDetails";
  static const String getUserChatList = "getUserChatList";
  static const String addSmileGallery = "addSmileGallery";
  static const String getSmileGallery = "getSmileGallery";
  static const String getMessageHistoryList = "getMessageHistoryList";
  static const String sendMessage = "sendMessage";
}

class RequestParam {
  static const String service = "Service"; // -> pass method name
  static const String showError = "show_error"; // -> bool in String
}

const String SHOW_ERROR = "false";

Map<String, String> requestHeaders(bool passAuthToken) {
  return {
    "Content-Type": "application/json",
    "App-Secret": "LYNERAPP@GK2023#",
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
