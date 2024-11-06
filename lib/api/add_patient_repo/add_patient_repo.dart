import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
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

  static Future<ResponseItem> getPatientInformationDetails(
      int patientId) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, int> params = {"patient_id": patientId};
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.getPatientInformationDetails,
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

  static Future<ResponseItem> getPatientRefinementImage(
      int patientId, int refinementNumber) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, int> params = {
      "patient_id": patientId,
      "refinement_number": refinementNumber,
    };
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.getPatientRefinementImage,
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

  static Future<ResponseItem> getPatientPrescriptionDetails(
      int patientId) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, int> params = {"patient_id": patientId};
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.getPatientPrescriptionDetails,
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

  static Future<ResponseItem> addUpdatePatientDetails({
    required int toothCaseId,
    required int patientId,
    required String firstName,
    required String lastName,
    required int saveAsDraft,
    required int is3shape,
    String? doctorId,
    String? dateOfBirth,
    String? clinicBillingId,
    String? clinicLocationId,
    String? email,
    String? arcadeToBeTreated,
    String? treatmentObjectives,
    String? acceptedTechniques,
    String? dentalHistory,
    String? dentalClass,
    String? maxillaryIncisalMiddle,
    String? incisiveCovering,
    String? treatmentNotes,
    String? dentalNote,
    String? acceptedTechniqueNote,
    String? dentalHistoryNote,
    String? maxillaryIncisalNote,
    String? incisiveCoveringNote,
    String? otherRecommendations,
    String? draftViewPage,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, dynamic> params = {
      "tooth_case_id": toothCaseId,
      "patient_id": patientId,
      "save_as_draft": saveAsDraft,
      "is_3shape": is3shape,
      "first_name": firstName,
      "last_name": lastName,
      "doctor_id": doctorId,
      "date_of_birth": dateOfBirth,
      "clinic_billing_id": clinicBillingId,
      "clinic_location_id": clinicLocationId,
      "email": email,
      "arcade_to_be_treated": arcadeToBeTreated,
      "treatment_objectives": treatmentObjectives,
      "accepted_techniques": acceptedTechniques,
      "dental_history": dentalHistory,
      "dental_class": dentalClass,
      "maxillary_incisal_middle": maxillaryIncisalMiddle,
      "incisive_covering": incisiveCovering,
      "treatment_notes": treatmentNotes,
      "dental_note": dentalNote,
      "maxillary_incisal_note": maxillaryIncisalNote,
      "accepted_technique_note": acceptedTechniqueNote,
      "dental_history_note": dentalHistoryNote,
      "incisive_covering_note": incisiveCoveringNote,
      "other_recommendations": otherRecommendations,
      "draft_view_page": draftViewPage,
    };
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.updatePatientDetails,
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
    result = await BaseApiHelper.uploadFile(
        requestUrl, imageFile, null, params, true);
    status = result.status;
    data = result.data;
    msg = result.msg;
    return ResponseItem(data: data, msg: msg, status: status);
  }

  static Future<ResponseItem> editPatientRefinementDetails({
    required File? file,
    required String? paramName,
    required String? patientId,
    required Map<String, dynamic>? params,
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
    /*final Map<String, dynamic> params = {
      "patient_id": patientId,
    };*/
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.editPatientRefinementDetails,
      RequestParam.showError: SHOW_ERROR,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result = await BaseApiHelper.uploadFile(
        requestUrl, imageFile, null, params!, true);
    status = result.status;
    data = result.data;
    msg = result.msg;
    return ResponseItem(data: data, msg: msg, status: status);
  }

  static Future<ResponseItem> uploadPatientMultipleImage({
    required List<File> imageList,
    required String? patientId,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, dynamic> params = {
      "patient_id": patientId,
    };

    List<http.MultipartFile> faceImg = [];
    List<String> keys = [
      "patient_gauche",
      "patient_face",
      "patient_sourire",
      "patient_intra_max",
      "patient_inter_gauche",
      "patient_intra_droite",
      "patient_inter_face",
      "patient_intra_gauche",
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
      RequestParam.service: MethodNames.uploadPatientSingleImage,
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

  /*static Future<ResponseItem> uploadPatientDcomFile({
    required File? file,
    required String? patientId,
    required String? uploadId,
    required String? chunkIndex,
    required String? totalChunks,
    required String? extension,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";


    http.MultipartFile? dicomFileType;
    if (file != null) {
      File compressedFile = file;
      final List<String> mimeType =
      lookupMimeType(compressedFile.path)!.split("/");
      final dicomFile = http.MultipartFile.fromBytes(
        "dcom_file",
        compressedFile.readAsBytesSync(),
        filename: compressedFile.path.split("/").last,
        contentType: MediaType(mimeType[0], mimeType[1]),
      );
      dicomFileType = dicomFile;
    }
    final Map<String, dynamic> params = {
      "patient_id": patientId,
      "upload_id": uploadId,
      "chunkIndex": chunkIndex,
      "totalChunks":totalChunks,
      "extension":  extension,
    };
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.uploadPatientDcomFile,
      RequestParam.showError: SHOW_ERROR,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result = await BaseApiHelper.uploadFile(requestUrl,dicomFileType,null, params, true);
    status = result.status;
    data = result.data;
    msg = result.msg;
    return ResponseItem(data: data, msg: msg, status: status);
  }*/
  static Future<ResponseItem> uploadPatientDcomFile({
    required File? file,
    required String? patientId,
    required String? uploadId,
    required String? chunkIndex,
    required String? totalChunks,
    required String? extension,
    required int? isForRefinements,
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
      "patient_id": patientId,
      "upload_id": uploadId,
      "chunkIndex": chunkIndex,
      "totalChunks": totalChunks,
      "extension": extension,
      "is_for_refinements": isForRefinements,
      if (isForRefinements == 1) "refinement_number": refinementNumber,
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
}
