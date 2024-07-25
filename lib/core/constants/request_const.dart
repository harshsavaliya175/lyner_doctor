import 'package:codonnier_network/network/api_type.dart';
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
  static const String getChefRecommendedList = "getChefRecommendedList";
}
class RequestHeaderKey {
  static const contentType = "Content-Type";
  static const userAgent = "User-Agent";
  static const appSecret = "App-Secret";
  static const appTrackVersion = "App-Track-Version";
  static const appDeviceType = "App-Device-Type";
  static const appStoreVersion = "App-Store-Version";
  static const appDeviceModel = "App-Device-Model";
  static const appOsVersion = "App-Os-Version";
  static const appStoreBuildNumber = "App-Store-Build-Number";
  static const authToken = "Auth-Token";
}

class RequestParam {
  static const service = "Service"; // -> pass method name
  static const showError = "show_error"; // -> bool in String
}

const String SHOW_ERROR = "false";

Map<String, String> requestHeader(APIType apiType) {
  return {
    RequestHeaderKey.contentType: "application/json",
    RequestHeaderKey.appSecret: "chefPop#App@2024",
    RequestHeaderKey.appTrackVersion: "v1",
    RequestHeaderKey.appDeviceType:
    preferences.getString(SharedPreference.APP_DEVICE_TYPE) ?? '',
    RequestHeaderKey.appStoreVersion:
    preferences.getString(SharedPreference.APP_STORE_VERSION) ?? '',
    RequestHeaderKey.appDeviceModel:
    preferences.getString(SharedPreference.APP_DEVICE_MODEL) ?? '',
    RequestHeaderKey.appOsVersion:
    preferences.getString(SharedPreference.APP_OS_VERSION) ?? '',
    RequestHeaderKey.appStoreBuildNumber:
    preferences.getString(SharedPreference.APP_STORE_BUILD_NUMBER) ?? '',
    if (apiType == APIType.protected)
      RequestHeaderKey.authToken:
      preferences.getString(SharedPreference.AUTH_TOKEN) ?? '',
  };
}

const int LIMIT = 10;

const USER_TYPE = "user";
