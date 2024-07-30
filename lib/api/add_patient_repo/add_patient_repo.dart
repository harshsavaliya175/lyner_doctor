import 'dart:convert';

import 'package:flutter/services.dart';
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


}
