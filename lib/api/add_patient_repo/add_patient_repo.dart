
import 'dart:convert';

import 'package:codonnier_network/network.dart';
import 'package:codonnier_network/network/api_type.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/model/productListModel.dart';

class AddPatientRepo {
  static AddPatientRepo? _instance;
  late RestClient restClient;
  AddPatientRepo._();

  static AddPatientRepo get instance => _instance ??= AddPatientRepo._();

  String apiUrl =  '';

  Future<ResponseItem> getChefRecommendedList({
    required int pageCount,
    required int pageLimit,
    required double myLat,
    required double myLong,
  }) async {
    try {
      Response response = await restClient.post(
          APIType.public,
          path:apiUrl,
          {
            'page': pageCount,
            'limit': pageLimit,
            'lat': myLat,
            'long': myLong,
          },
          headers: requestHeader(APIType.protected),
          query: {
            RequestParam.service: MethodNames.getChefRecommendedList,
            'show_error': "false",
          });
      final ResponseItem responseData = ResponseItem.fromJson(response.data);
      return responseData;
    } on Failure catch (e) {
      return ResponseItem(
          msg: e.message ?? 'Something went wrong', status: false,);
    }
  }

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


}
