import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:lynerdoctor/api/api_helpers.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';
import 'package:mime/mime.dart';

class AuthRepo {
  static Future<ResponseItem> clinicLogin({
    required String email,
    required String password,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, String> params = {
      "email": email,
      "password": password,
    };
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.clinicLogin,
      RequestParam.showError: SHOW_ERROR,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, params);
    status = result.status;
    data = result.data;
    msg = result.msg;
    return ResponseItem(data: data, msg: msg, status: status);
  }

  static Future<ResponseItem> requestToRegister({
    required String email,
    required String clinicName,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";
    final Map<String, String> params = {
      "email": email,
      "clinic_name": clinicName,
      "first_name": firstName,
      "last_name": lastName,
      "phone_number": phoneNumber
    };

    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.clinicRegistrationRequest,
      RequestParam.showError: SHOW_ERROR
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, params);
    status = result.status;
    data = result.data;
    msg = result.msg;

    return ResponseItem(data: data, msg: msg, status: status);
  }

  static Future<ResponseItem> forgotPassword({required String email}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";
    final Map<String, String> params = {"email": email};

    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.forgotPassword,
      RequestParam.showError: SHOW_ERROR
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, params);
    status = result.status;
    data = result.data;
    msg = result.msg;

    return ResponseItem(data: data, msg: msg, status: status);
  }

  static Future<ResponseItem> changePasswordWithVerifyCode({
    required String email,
    required String verifyCode,
    required String newPassword,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";
    final Map<String, String> params = {
      "email": email,
      "verify_code": verifyCode,
      "new_password": newPassword,
    };

    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.changePasswordWithVerifyCode,
      RequestParam.showError: SHOW_ERROR
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, params);
    status = result.status;
    data = result.data;
    msg = result.msg;
    return ResponseItem(data: data, msg: msg, status: status);
  }

  static Future<ResponseItem> checkEmailExistsOrNot(
      {required String email}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";
    final Map<String, String> params = {"email": email};

    // String requestUrl = ApiUrl.baseUrl + MethodNames.checkEmailExistsOrNot;
    String requestUrl = ApiUrl.baseUrl;
    result = await BaseApiHelper.postRequest(requestUrl, params);
    status = result.status;
    data = result.data;
    msg = result.msg;

    return ResponseItem(data: data, msg: msg, status: status);
  }

  Future<ResponseItem> updateDeviceToken({
    String devicePushToken = '',
    String deviceId = '',
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";
    final Map<String, dynamic> params = {
      "device_id": deviceId,
      "device_push_token": devicePushToken,
    };
    String requestUrl = ApiUrl.baseUrl;
    result = await BaseApiHelper.postRequest(requestUrl, params);
    status = result.status;
    data = result.data;
    msg = result.msg;
    return ResponseItem(data: data, msg: msg, status: status);
  }

  static Future<ResponseItem> changePassword(
      {required String oldPassword, required String newPassword}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";
    String refreshToken;

    final Map<String, String> params = {
      "old_password": oldPassword,
      "new_password": newPassword
    };

    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.changePassword,
      RequestParam.showError: SHOW_ERROR
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;

    result = await BaseApiHelper.postRequest(requestUrl, params,
        passAuthToken: true);
    status = result.status;
    data = result.data;
    message = result.msg;
    refreshToken = result.refreshToken ?? '';

    return ResponseItem(
        data: data, status: status, refreshToken: refreshToken, msg: message);
  }

  static Future<ResponseItem> editProfile({
    required String fullName,
    required String email,
    required String phoneNumber,
    required int isEmailNotification,
    required int isMobileNotification,
    File? profileImage,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, dynamic> params = {
      "first_name": fullName,
      "email": email,
      "phone_number": phoneNumber,
      "is_email_notification": isEmailNotification,
      "is_mobile_notification": isMobileNotification,
    };

    http.MultipartFile? profileImageFile;
    if (profileImage != null) {
      File compressedFile = profileImage;
      final List<String> mimeType =
          lookupMimeType(compressedFile.path)!.split("/");
      final profileImages = http.MultipartFile.fromBytes(
        "clinic_photo",
        compressedFile.readAsBytesSync(),
        filename: compressedFile.path.split("/").last,
        contentType: MediaType(mimeType[0], mimeType[1]),
      );
      profileImageFile = profileImages;
    }

    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.updateClinicDetails,
      RequestParam.showError: SHOW_ERROR
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result = await BaseApiHelper.uploadFile(
        requestUrl, profileImageFile, null, params, true);
    status = result.status;
    data = result.data;
    msg = result.msg;

    return ResponseItem(data: data, msg: msg, status: status);
  }

  static Future<ResponseItem> deleteAccount() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, String> queryParameters = {
      // RequestParam.service: MethodNames.deleteAccount,
      RequestParam.showError: SHOW_ERROR
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result =
        await BaseApiHelper.postRequest(requestUrl, {}, passAuthToken: true);
    status = result.status;
    data = result.data;
    msg = result.msg;

    return ResponseItem(data: data, msg: msg, status: status);
  }

  static Future<ResponseItem> logout() async {
    String deviceId =
        preferences.getString(SharedPreference.APP_DEVICE_ID) ?? '';
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, String> params = {"device_id": deviceId};
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.logout,
      RequestParam.showError: SHOW_ERROR,
    };
    String queryString = Uri(
      queryParameters: queryParameters,
    ).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result = await BaseApiHelper.postRequest(
      requestUrl,
      params,
      passAuthToken: true,
    );
    status = result.status;
    data = result.data;
    msg = result.msg;
    return ResponseItem(data: data, msg: msg, status: status);
  }
}
