// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) => json.encode(data.toJson());

class ProductListModel {
  int status;
  String msg;
  List<ProductListData> data;

  ProductListModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
    status: json["status"],
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
  int isActive;
  int isDeleted;
  DateTime createdAt;
  DateTime updatedAt;

  ProductListData({
    required this.toothCaseId,
    required this.caseName,
    required this.casePrice,
    required this.caseDesc,
    required this.caseSteps,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductListData.fromJson(Map<String, dynamic> json) => ProductListData(
    toothCaseId: json["tooth_case_id"],
    caseName: json["case_name"],
    casePrice: json["case_price"],
    caseDesc: json["case_desc"],
    caseSteps: json["case_steps"],
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "tooth_case_id": toothCaseId,
    "case_name": caseName,
    "case_price": casePrice,
    "case_desc": caseDesc,
    "case_steps": caseSteps,
    "is_active": isActive,
    "is_deleted": isDeleted,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
