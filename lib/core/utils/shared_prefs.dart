import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:lynerdoctor/config/routes/routes.dart';
import 'package:lynerdoctor/model/clinic_model.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

final SharedPreference preferences = SharedPreference();

class SharedPreference {
  SharedPreferences? _preferences;

  init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  static const String IS_LOGGED_IN = "IS_LOGGED_IN";
  static const String APP_DEVICE_TYPE = "APP_DEVICE_TYPE";
  static const String APP_STORE_VERSION = "APP_STORE_VERSION";
  static const String APP_DEVICE_MODEL = "APP_DEVICE_MODEL";
  static const String APP_OS_VERSION = "APP_OS_VERSION";
  static const String APP_STORE_BUILD_NUMBER = "APP_STORE_BUILD_NUMBER";
  static const String AUTH_TOKEN = "AUTH_TOKEN";
  static const String USER_TOKEN = "USER_TOKEN";
  static const String FIRST_NAME = "FIRST_NAME";
  static const String USER_TYPE = "USER_TYPE";
  static const String CUR_LAT = "CUR_LAT";
  static const String CUR_LONG = "CUR_LONG";
  static const String USER_EMAIL = "USER_EMAIL";
  static const String USER_ID = "USER_ID";
  static const String USER_IMG = "USER_IMG";
  static const String TIME_ZONE = "TIME_ZONE";
  static const String REFERENCE_CODE = "REFERENCE_CODE";
  static const String CURRENT_ALIGNER_STAGE = "CURRENT_ALIGNER_STAGE";
  static const String TOTAL_ALIGNER_STAGE = "TOTAL_ALIGNER_STAGE";
  static const String CLINIC_ID = "CLINIC_ID";
  static const String CLINIC_NAME = "CLINIC_NAME";
  static const String EMAIL = "EMAIL";
  static const String CLINIC_MOBILE_NUMBER = "CLINIC_MOBILE_NUMBER";
  static const String CLINIC_PHOTO = "CLINIC_PHOTO";
  static const String EMAIL_VERIFICATION_AT = "EMAIL_VERIFICATION_AT";
  static const String REMEMBER_TOKEN = "REMEMBER_TOKEN";
  static const String VERIFY_FORGOT_CODE = "VERIFY_FORGOT_CODE";
  static const String IS_EMAIL_NOTIFICATION = "IS_EMAIL_NOTIFICATION";
  static const String IS_PHONE_NOTIFICATION = "IS_PHONE_NOTIFICATION";
  static const String CREATE_AT = "CREATE_AT";

  saveClinicItem(ClinicData data) {
    preferences.putBool(SharedPreference.IS_LOGGED_IN, true);
    _preferences?.setInt(CLINIC_ID, data.clinicId);
    _preferences?.setString(CLINIC_NAME, data.clinicName);
    _preferences?.setString(EMAIL, data.email);
    _preferences?.setString(CLINIC_MOBILE_NUMBER, data.clinicMobileNumber);
    _preferences?.setString(USER_EMAIL, data.email);
    _preferences?.setString(CLINIC_PHOTO, data.clinicPhoto);
    _preferences?.setString(REMEMBER_TOKEN, data.rememberToken);
    _preferences?.setString(AUTH_TOKEN, data.authToken);
    _preferences?.setString(VERIFY_FORGOT_CODE, data.verifyForgotCode);
    _preferences?.setInt(IS_EMAIL_NOTIFICATION, data.isEmailNotification);
    _preferences?.setInt(IS_PHONE_NOTIFICATION, data.isPhoneNotification);
  }

  putAppDeviceInfo() async {
    bool isiOS = Platform.isIOS;
    putString(APP_DEVICE_TYPE, isiOS ? "iOS" : "android");
    final deviceInfo = await appDeviceInfo();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    putString(TIME_ZONE, currentTimeZone);
    if (isiOS) {
      IosDeviceInfo iosDeviceInfo = (deviceInfo as IosDeviceInfo);
      putString(APP_DEVICE_MODEL, "Test");
      putString(APP_OS_VERSION, "iOS ${iosDeviceInfo.systemVersion}");
    } else {
      AndroidDeviceInfo androidDeviceInfo = (deviceInfo as AndroidDeviceInfo);
      putString(APP_DEVICE_MODEL, androidDeviceInfo.model);
      putString(APP_OS_VERSION, androidDeviceInfo.version.release);
    }
    putString(APP_STORE_VERSION, packageInfo.version);
    putString(APP_STORE_BUILD_NUMBER, packageInfo.buildNumber);
  }

  Future<dynamic> appDeviceInfo() async {
    return Platform.isIOS
        ? await DeviceInfoPlugin().iosInfo
        : await DeviceInfoPlugin().androidInfo;
  }

  void clearUserItem() async {
    _preferences?.clear();
    _preferences = null;
    await init();
    await putAppDeviceInfo();
    Get.offAllNamed(Routes.signUpSignInScreen);
  }

  Future<bool?> putString(String key, String value) async {
    return _preferences == null ? null : _preferences?.setString(key, value);
  }

  Future<bool?> putList(String key, List<String> value) async {
    return _preferences == null
        ? null
        : _preferences!.setStringList(key, value);
  }

  List<String>? getList(String key, {List<String> defValue = const []}) {
    return _preferences == null
        ? defValue
        : _preferences?.getStringList(key) ?? defValue;
  }

  String? getString(String key, {String defValue = ""}) {
    return _preferences == null
        ? defValue
        : _preferences?.getString(key) ?? defValue;
  }

  Future<bool?> putInt(String key, int value) async {
    return _preferences == null ? null : _preferences?.setInt(key, value);
  }

  int? getInt(String key, {int defValue = 0}) {
    return _preferences == null
        ? defValue
        : _preferences?.getInt(key) ?? defValue;
  }

  Future<bool?> putDouble(String key, double value) async {
    return _preferences == null ? null : _preferences?.setDouble(key, value);
  }

  double getDouble(String key, {double defValue = 0.0}) {
    return _preferences == null
        ? defValue
        : _preferences?.getDouble(key) ?? defValue;
  }

  Future<bool?> putBool(String key, bool value) async {
    return _preferences == null ? null : _preferences?.setBool(key, value);
  }

  bool? getBool(String key, {bool defValue = false}) {
    return _preferences == null
        ? defValue
        : _preferences?.getBool(key) ?? defValue;
  }
}
