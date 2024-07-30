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
}
