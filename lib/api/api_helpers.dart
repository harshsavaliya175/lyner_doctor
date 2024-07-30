import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';

import 'api_exceptions.dart';

class BaseApiHelper {
  static Future<ResponseItem> postRequest(
      String requestUrl, Map<String, dynamic> requestData,
      {bool passAuthToken = false}) async {
    printData(tittle: "request", val: requestUrl);
    printData(
        tittle: "headers:", val: requestHeaders(passAuthToken).toString());
    printData(tittle: "body:", val: json.encode(requestData));
    return await http
        .post(Uri.parse(requestUrl),
            body: json.encode(requestData),
            headers: requestHeaders(passAuthToken))
        .then((response) => onValue(response))
        .onError((error, stackTrace) => onError(error, requestUrl));
  }

  static Future<ResponseItem> getRequest(
    String requestUrl, {
    bool isPassAuthToken = false,
  }) async {
    printData(tittle: "request", val: requestUrl);
    return await http
        .get(
          Uri.parse(requestUrl),
          headers: requestHeaders(isPassAuthToken),
        )
        .then((response) => onValue(response))
        .onError((error, stackTrace) => onError(error, requestUrl));
  }

  static Future baseOnValue(http.Response response) async {
    ResponseItem result;

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool status = false;
    String message;
    dynamic data = responseData;

    printData(tittle: "responseCode:", val: response.statusCode.toString());
    if (response.statusCode == 200) {
      message = "Ok";
      status = true;
      data = responseData;
    } else {
      printData(tittle: "Error in", val: data);
      message = "Something went wrong.";
    }
    result = ResponseItem(data: data, msg: message, status: status);
    log("response: ${response.body}");
    printData(
        tittle: "response",
        val: "{data: ${result.data}, message: $message, status: $status}");
    return result;
  }

  static onError(error, url) {
    log(url);
    printData(tittle: "Error caused: ", val: error.toString());
    bool status = false;
    String message = "Unsuccessful request";
    if (error is SocketException) {
      message = ResponseException("No internet connection").toString();
    } else if (error is FormatException) {
      message = ResponseException("Something wrong in response.").toString() +
          error.toString();
    }
    return ResponseItem(data: null, msg: message, status: status);
  }

  static Future<ResponseItem> uploadFile(
      String requestUrl,
      http.MultipartFile? profileImage,
      List<http.MultipartFile>? faceImg,
      Map<String, dynamic> requestData,
      [bool isPassAuthToken = false]) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(requestUrl),
    );
    request.headers.addAll(requestHeaders(isPassAuthToken));
    if (profileImage != null) {
      request.files.add(profileImage);
    }

    if (faceImg != null) {
      request.files.addAll(faceImg);
    }

    Map<String, String> convertedMap = requestData.map((key, value) {
      return MapEntry(key, value.toString());
    });
    // request.fields.addAll(requestData);
    request.fields.addAll(convertedMap);

    printData(tittle: "REQUEST", val: request.toString());
    printData(tittle: "Request body", val: json.encode(requestData));

    return await request.send().then((streamedResponse) {
      return http.Response.fromStream(streamedResponse)
          .then((value) => onValue(value));
    }).onError((error, stackTrace) => onError(error, requestUrl));
  }

  static Future onValue(http.Response response) async {
    ResponseItem result;

    final ResponseItem responseData =
        ResponseItem.fromJson(json.decode(response.body));
    bool status = false;
    String message;
    String? refreshToken;

    dynamic data = responseData;

    log("responseCode: ${response.statusCode.toString()}", name: "response");
    log("fullResponse: ${response.body}", name: "response");
    if (response.statusCode >= 200 && response.statusCode <= 205) {
      refreshToken = responseData.refreshToken!;
      message = responseData.msg;
      if (responseData.status) {
        status = true;
        data = responseData.data;
      } else {
        printData(tittle: "logout", val: responseData.forceLogout);
        if (responseData.forceLogout) {
          preferences.clearUserItem();
        }
      }
    } else {
      log("response: $data");
      message = "Something went wrong.";
    }
    result = ResponseItem(
      data: data,
      msg: message,
      status: status,
      refreshToken: refreshToken,
    );
    printData(
        tittle: "response",
        val:
            "data ${result.data}, message: $message, status: $status,refreshToken:$refreshToken");
    printData(
      tittle: "message",
      val: " ${result.msg}",
    );

    return result;
  }
}
