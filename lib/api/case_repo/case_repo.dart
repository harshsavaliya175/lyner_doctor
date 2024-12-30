import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:lynerdoctor/api/api_helpers.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:mime/mime.dart';

class AddCaseRepo {
  static AddCaseRepo? _instance;

  AddCaseRepo._();

  static AddCaseRepo get instance => _instance ??= AddCaseRepo._();

  static Future<ResponseItem> addCase({
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String patientRequest,
    required String treatmentGoal,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, dynamic> params = {
      "first_name": firstName,
      "last_name": lastName,
      "date_of_birth": dateOfBirth,
      "patient_request": patientRequest,
      "treatment_objectives": treatmentGoal,
    };
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.addCaseSelection,
      RequestParam.showError: SHOW_ERROR,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
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

  static Future<ResponseItem> editCase({
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String patientRequest,
    required String treatmentGoal,
    String? id,
    int isDraft = 1,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";
    http.MultipartFile? imageFile;

    final Map<String, dynamic> params = {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "date_of_birth": dateOfBirth,
      "patient_request": patientRequest,
      "treatment_objectives": treatmentGoal,
      "is_draft": isDraft,
    };
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.editCaseSelection,
      RequestParam.showError: SHOW_ERROR,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result = await BaseApiHelper.uploadFile(
        requestUrl, imageFile, null, params, true);
    status = result.status;
    data = result.data;
    msg = result.msg;
    return ResponseItem(data: data, msg: msg, status: status);
  }

  static Future<ResponseItem> uploadCaseSingleImage({
    required File? file,
    required String paramName,
    required String id,
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String patientRequest,
    required String treatmentObjectives,
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
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "date_of_birth": dateOfBirth,
      "patient_request": patientRequest,
      "treatment_objectives": treatmentObjectives,
      "is_draft": 1,
    };
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.editCaseSelection,
      RequestParam.showError: SHOW_ERROR,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result = await BaseApiHelper.uploadFile(
        requestUrl, imageFile, null, params, true);
    status = result.status;
    data = result.data;
    msg = result.msg;
    return ResponseItem(data: data, msg: msg, status: status);
  }

  static Future<ResponseItem> uploadCaseMultipleImage({
    required List<File> imageList,
    required String id,
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String patientRequest,
    required String treatmentObjectives,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, dynamic> params = {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "date_of_birth": dateOfBirth,
      "patient_request": patientRequest,
      "treatment_objectives": treatmentObjectives,
      "is_draft": 1,
    };

    List<http.MultipartFile> faceImg = [];
    List<String> keys = [
      "patient_gauche",
      "patient_face",
      "patient_sourire",
      "patient_intra_max",
      "patient_intra_gauche",
      "patient_inter_gauche",
      "patient_inter_face",
      "patient_intra_droite",
    ];

    for (int i = 0; i < imageList.length; i++) {
      File compressedFile = imageList[i];
      List<String> mimeType = lookupMimeType(compressedFile.path)!.split("/");
      http.MultipartFile plantImage = http.MultipartFile.fromBytes(
        keys[i],
        compressedFile.readAsBytesSync(),
        filename: compressedFile.path.split("/").last,
        contentType: MediaType(mimeType[0], mimeType[1]),
      );
      faceImg.add(plantImage);
    }

    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.editCaseSelection,
      RequestParam.showError: SHOW_ERROR,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result =
        await BaseApiHelper.uploadFile(requestUrl, null, faceImg, params, true);
    status = result.status;
    data = result.data;
    msg = result.msg;
    return ResponseItem(data: data, msg: msg, status: status);
  }

  static Future<ResponseItem> uploadCaseDcomFile({
    required File? file,
    required String? caseSelectionId,
    required String? uploadId,
    required String? chunkIndex,
    required String? totalChunks,
    required String? extension,
    // required String forWhat,
    int? refinementNumber,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    http.MultipartFile? dicomFileType;
    if (file != null) {
      File compressedFile = file;
      final String? mimeTypeString = lookupMimeType(compressedFile.path);
      final mimeType = mimeTypeString?.split("/") ??
          ["application", "octet-stream"]; // Default MIME type

      dicomFileType = http.MultipartFile.fromBytes(
        "dcom_file",
        compressedFile.readAsBytesSync(),
        filename: compressedFile.path.split("/").last,
        contentType: MediaType(mimeType[0], mimeType[1]),
      );
    } else {
      return ResponseItem(
        data: null,
        msg: 'File is null',
        status: false,
      );
    }

    final Map<String, dynamic> params = {
      "patient_id": 0,
      "upload_id": uploadId,
      "chunkIndex": chunkIndex,
      "totalChunks": totalChunks,
      "extension": extension,
      "case_selection_id": caseSelectionId,
      "for_what": "case_selection",
    };
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.uploadPatientDcomFile,
      RequestParam.showError: SHOW_ERROR,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result = await BaseApiHelper.uploadFile(
        requestUrl, dicomFileType, null, params, true);
    status = result.status;
    data = result.data;
    msg = result.msg;
    return ResponseItem(data: data, msg: msg, status: status);
  }

  static Future<ResponseItem> getCaseSelectionListByStatus({
    required String caseStatus,
    required String searchText,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, String> params = {
      "status": caseStatus,
      "search_text": searchText,
    };
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.getCaseSelectionListByStatus,
      RequestParam.showError: SHOW_ERROR,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
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

  static Future<ResponseItem> getCaseSelection({required int id}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, int> params = {"id": id};
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.getCaseSelection,
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
}
