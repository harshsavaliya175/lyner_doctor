import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:lynerdoctor/api/api_helpers.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:mime/mime.dart';

class PatientsRepo {
  static Future<ResponseItem> getDoctorListByClinicId({
    required int clinicId,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, int> params = {"clinic_id": clinicId};
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.getDoctorListByClinicId,
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

  static Future<ResponseItem> getClinicLocationList({
    required int clinicId,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, int> params = {"clinic_id": clinicId};
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.getClinicLocationList,
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

  static Future<ResponseItem> getLibraryList() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, int> params = {};
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.getLibraryList,
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

  static Future<ResponseItem> getClinicBillingList({
    required int clinicId,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, int> params = {"clinic_id": clinicId};
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.getClinicBillingAddresList,
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

  static Future<ResponseItem> deletePatient({
    required String patientId,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, dynamic> params = {"patient_id": patientId};
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.deletePatient,
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

  static Future<ResponseItem> getLynerConnectList({
    String searchText = '',
    String sessionDoctorId = '',
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, dynamic> params = {
      "search_text": searchText,
      "session_doctor_id": sessionDoctorId
    };
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.getLynerConnectList,
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

  static Future<ResponseItem> getLynerConnectDetails({
    required int userId,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, dynamic> params = {
      "user_id": userId,
    };
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.getLynerConnectDetails,
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

  static Future<ResponseItem> getLynerConnectPatientsList({
    String searchText = '',
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, dynamic> params = {
      "search_text": searchText,
    };
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.getLynerConnectPatientsList,
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

  static Future<ResponseItem> addLynerConnectDetails({
    required String? patientId,
    String? email,
    String? phoneNo,
    required String? currentAlignerStage,
    required String? alignerStage,
    required String? alignerDay,
    required String? treatmentStartDate,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, dynamic> params = {
      "patient_id": patientId,
      "email": email,
      "phone_no": phoneNo,
      "current_aligner_stage": currentAlignerStage,
      "aligner_stage": alignerStage,
      "aligner_day": alignerDay,
      "treatment_start_date": treatmentStartDate,
    };
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.addLynerConnectDetails,
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

  static Future<ResponseItem> editLynerConnectDetails({
    required String? userId,
    String? email,
    String? phoneNo,
    required String? firstName,
    required String? lastName,
    required String? currentAlignerStage,
    required String? alignerStage,
    required String? alignerDay,
    required String? treatmentStartDate,
    required String? treatmentModificationDate,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, dynamic> params = {
      "user_id": userId,
      "email": email,
      "phone_no": phoneNo,
      "first_name": firstName,
      "last_name": lastName,
      "current_aligner_stage": currentAlignerStage,
      "aligner_stage": alignerStage,
      "aligner_day": alignerDay,
      "treatment_start_date": treatmentStartDate,
      "modification_date": treatmentModificationDate,
    };
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.editLynerConnectDetails,
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

  static Future<ResponseItem> getClinicListBySearchOrFilter({
    required String treatmentStatus,
    required String searchText,
    required String filterType,
    required String sessionDoctorId,
    required String clinicLocationId,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, String> params = {
      "treatment_status": treatmentStatus,
      "search_text": searchText,
      "filter_type": filterType,
      "session_doctor_id": sessionDoctorId,
      "clinic_location_id": clinicLocationId,
    };
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.getClinicListBySearchOrFilter,
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

  static Future<ResponseItem> getGlobalSearchData(
      {required String searchText}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, String> params = {"search_txt": searchText};
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.getGlobalSearchData,
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

  static Future<ResponseItem> getPatientInformationDetails({
    required int patientId,
  }) async {
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

  static Future<ResponseItem> getPatientTreatmentsDetails({
    required int patientId,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, int> params = {"patient_id": patientId};
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.getPatientTreatmentsDetails,
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

  static Future<ResponseItem> getPatientCommentsDetails({
    required int patientId,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, int> params = {"patient_id": patientId};
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.getPatientCommentsDetails,
      RequestParam.showError: SHOW_ERROR,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result = await BaseApiHelper.postRequest(
      requestUrl,
      params,
      passAuthToken: true,
    );
    log("==> $result");
    status = result.status;
    data = result.data;
    msg = result.msg;
    return ResponseItem(data: data, msg: msg, status: status);
  }

  static Future<ResponseItem> sendModification({
    required int patientId,
    required String comment,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, dynamic> params = {
      "patient_id": patientId,
      "comment": comment,
    };
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.sendModification,
      RequestParam.showError: SHOW_ERROR,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result = await BaseApiHelper.postRequest(
      requestUrl,
      params,
      passAuthToken: true,
    );
    log("==> $result");
    status = result.status;
    data = result.data;
    msg = result.msg;
    return ResponseItem(data: data, msg: msg, status: status);
  }

  static Future<ResponseItem> approveOrder({
    required int patientId,
    required String bondDate,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, dynamic> params = {
      "patient_id": patientId,
      "bond_date": bondDate,
    };
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.approveOrder,
      RequestParam.showError: SHOW_ERROR,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result = await BaseApiHelper.postRequest(
      requestUrl,
      params,
      passAuthToken: true,
    );
    log("==> $result");
    status = result.status;
    data = result.data;
    msg = result.msg;
    return ResponseItem(data: data, msg: msg, status: status);
  }

  static Future<ResponseItem> addTextPatientComments({
    required int patientId,
    required String comment,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, dynamic> params = {
      "patient_id": patientId,
      "comment": comment,
    };
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.addTextPatientComments,
      RequestParam.showError: SHOW_ERROR,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result = await BaseApiHelper.postRequest(
      requestUrl,
      params,
      passAuthToken: true,
    );
    log("==> $result");
    status = result.status;
    data = result.data;
    msg = result.msg;
    return ResponseItem(data: data, msg: msg, status: status);
  }

  static Future<ResponseItem> deletePatientTreatments({
    required int patientTreatmentId,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, int> params = {
      "patient_treatment_id": patientTreatmentId
    };
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.deletePatientTreatments,
      RequestParam.showError: SHOW_ERROR,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result = await BaseApiHelper.postRequest(
      requestUrl,
      params,
      passAuthToken: true,
    );
    log("==> $result");
    status = result.status;
    data = result.data;
    msg = result.msg;
    return ResponseItem(data: data, msg: msg, status: status);
  }

  static Future<ResponseItem> deleteLynerConnect({
    required int userId,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, int> params = {"user_id": userId};
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.deleteLynerConnect,
      RequestParam.showError: SHOW_ERROR,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result = await BaseApiHelper.postRequest(
      requestUrl,
      params,
      passAuthToken: true,
    );
    log("==> $result");
    status = result.status;
    data = result.data;
    msg = result.msg;
    return ResponseItem(data: data, msg: msg, status: status);
  }

  static Future<ResponseItem> addEditPatientTreatments({
    bool isEdit = false,
    required String treatmentNotes,
    required String nextVisit,
    required int patientId,
    int? patientTreatmentId,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    final Map<String, dynamic> params = {
      "type": isEdit ? "edit" : "add",
      "patient_id": patientId,
      "patient_treatment_id": patientTreatmentId,
      "treatment_notes": treatmentNotes,
      "next_visit": nextVisit,
    };
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.addEditPatientTreatments,
      RequestParam.showError: SHOW_ERROR,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result = await BaseApiHelper.postRequest(
      requestUrl,
      params,
      passAuthToken: true,
    );
    log("==> $result");
    status = result.status;
    data = result.data;
    msg = result.msg;
    return ResponseItem(data: data, msg: msg, status: status);
  }

  static Future<ResponseItem> uploadCommentFileFile({
    required File? file,
    required String? patientId,
    required String? uploadId,
    required String? chunkIndex,
    required String? totalChunks,
    required String? extension,
    // required String? fileType,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String msg = "";

    http.MultipartFile? commentFileType;
    if (file != null) {
      File compressedFile = file;
      final String? mimeTypeString = lookupMimeType(compressedFile.path);
      final mimeType = mimeTypeString?.split("/") ??
          ["application", "octet-stream"]; // Default MIME type

      commentFileType = http.MultipartFile.fromBytes(
        "file",
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
      "fileType": extension,
    };
    final Map<String, String> queryParameters = {
      RequestParam.service: MethodNames.addFilePatientComments,
      RequestParam.showError: SHOW_ERROR,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = ApiUrl.baseUrl + queryString;
    result = await BaseApiHelper.uploadFile(
        requestUrl, commentFileType, null, params, true);
    status = result.status;
    data = result.data;
    msg = result.msg;
    return ResponseItem(data: data, msg: msg, status: status);
  }
}
