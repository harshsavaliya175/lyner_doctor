import 'dart:developer';

import 'package:lynerdoctor/api/api_helpers.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';

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
}
