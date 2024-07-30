import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:lynerdoctor/api/api_helpers.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/model/productListModel.dart';

class AddPatientRepo {
  static AddPatientRepo? _instance;
  // late RestClient restClient;
  AddPatientRepo._();

  static AddPatientRepo get instance => _instance ??= AddPatientRepo._();

  String apiUrl =  '';
  Future<ProductListModel> getProductsFromAssets() async {
    try {
      // Load JSON from assets
      final String response = await rootBundle.loadString(Assets.json.lynerCases);
      final data = await json.decode(response);
      final ProductListModel productList = ProductListModel.fromJson(data);
      return productList;
    } catch (e) {
      return ProductListModel(status: 0, msg: 'Something went wrong', data: []);
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
}
