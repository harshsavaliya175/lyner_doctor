import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:lynerdoctor/api/api_helpers.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/model/productListModel.dart';
import 'package:mime/mime.dart';

class AddPatientRepo {
  static AddPatientRepo? _instance;

  // late RestClient restClient;
  AddPatientRepo._();

  static AddPatientRepo get instance => _instance ??= AddPatientRepo._();

  String apiUrl = '';

  Future<ProductListModel> getProductsFromAssets() async {
    try {
      // Load JSON from assets
      final String response =
          await rootBundle.loadString(Assets.json.lynerCases);
      final data = await json.decode(response);
      final ProductListModel productList = ProductListModel.fromJson(data);
      return productList;
    } catch (e) {
      return ProductListModel(
          status: true, msg: 'Something went wrong', data: []);
    }
  }

  static Future<ResponseItem> getProductsList() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, int> params = {};
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.getProductList,
      RequestParam.showError: SHOW_ERROR,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, params,
        passAuthToken: true);
    status = result.status;
    data = result.data;
    msg = result.msg;
    return ResponseItem(data: data, msg: msg, status: status);
  }

  static Future<ResponseItem> addNewPatientStep1Step2({
    required int toothCaseId,
    required String firstName,
    required String lastName,
    String? doctorId,
    String? dateOfBirth,
    String? clinicBillingId,
    String? clinicLocationId,
    String? email,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, dynamic> params = {
      "tooth_case_id": toothCaseId,
      "first_name": firstName,
      "last_name": lastName,
      "doctor_id": doctorId,
      "date_of_birth": dateOfBirth,
      "clinic_billing_id": clinicBillingId,
      "clinic_location_id": clinicLocationId,
      "email": email,
    };
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.addNewPatientStep1Step2,
      RequestParam.showError: SHOW_ERROR,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, params,
        passAuthToken: true);
    status = result.status;
    data = result.data;
    msg = result.msg;
    return ResponseItem(data: data, msg: msg, status: status);
  }

  static Future<ResponseItem> uploadPatientSingleImage({
    required File? file,
    required String? paramName,
    required String? patientId,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";


    http.MultipartFile? imageFile;
    if (file != null) {
      File compressedFile = file;
      final List<String> mimeType =
      lookupMimeType(compressedFile.path)!.split("/");
      final images = http.MultipartFile.fromBytes(
        "$paramName",
        compressedFile.readAsBytesSync(),
        filename: compressedFile.path.split("/").last,
        contentType: MediaType(mimeType[0], mimeType[1]),
      );
      imageFile = images;
    }
    final Map<String, dynamic> params = {
      "patient_id": patientId,
    };
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.uploadPatientSingleImage,
      RequestParam.showError: SHOW_ERROR,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result = await BaseApiHelper.uploadFile(requestUrl,imageFile,null, params, true);
    status = result.status;
    data = result.data;
    msg = result.msg;
    return ResponseItem(data: data, msg: msg, status: status);
  }
}
