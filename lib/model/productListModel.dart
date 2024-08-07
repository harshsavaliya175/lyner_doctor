import 'dart:convert';

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) => json.encode(data.toJson());

class ProductListModel {
  bool status;
  String msg;
  List<ProductListData> data;

  ProductListModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
    status: json["status"]==1,
    msg: json["msg"],
    data: List<ProductListData>.from(json["data"].map((x) => ProductListData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ProductListData {
  int toothCaseId;
  String caseName;
  String casePrice;
  String caseDesc;
  String caseSteps;


  ProductListData({
    required this.toothCaseId,
    required this.caseName,
    required this.casePrice,
    required this.caseDesc,
    required this.caseSteps,
  });

  factory ProductListData.fromJson(Map<String, dynamic> json) => ProductListData(
    toothCaseId: json["tooth_case_id"] ?? 0,
    caseName: json["case_name"] ?? "",
    casePrice: json["case_price"] ?? "",
    caseDesc: json["case_desc"] ?? "",
    caseSteps: json["case_steps"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "tooth_case_id": toothCaseId,
    "case_name": caseName,
    "case_price": casePrice,
    "case_desc": caseDesc,
    "case_steps": caseSteps,
  };
}
