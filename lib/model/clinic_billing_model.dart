// To parse this JSON data, do
//
//     final clinicBillingListModel = clinicBillingListModelFromJson(jsonString);

import 'dart:convert';

ClinicBillingListModel clinicBillingListModelFromJson(String str) => ClinicBillingListModel.fromJson(json.decode(str));

String clinicBillingListModelToJson(ClinicBillingListModel data) => json.encode(data.toJson());

class ClinicBillingListModel {
  List<ClinicBillingData> data;
  int status;
  String msg;

  ClinicBillingListModel({
    required this.data,
    required this.status,
    required this.msg,
  });

  factory ClinicBillingListModel.fromJson(Map<String, dynamic> json) => ClinicBillingListModel(
    data: List<ClinicBillingData>.from(json["data"].map((x) => ClinicBillingData.fromJson(x))),
    status: json["status"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
    "msg": msg,
  };
}

class ClinicBillingData {
  int clinicBillingId;
  int clinicId;
  String billingName;
  String billingAddress;
  String billingLatitude;
  String billingLongitude;
  String billingMail;
  String billingVat;


  ClinicBillingData({
    required this.clinicBillingId,
    required this.clinicId,
    required this.billingName,
    required this.billingAddress,
    required this.billingLatitude,
    required this.billingLongitude,
    required this.billingMail,
    required this.billingVat,

  });

  factory ClinicBillingData.fromJson(Map<String, dynamic> json) => ClinicBillingData(
    clinicBillingId: json["clinic_billing_id"]??0,
    clinicId: json["clinic_id"]??0,
    billingName: json["billing_name"]??'',
    billingAddress: json["billing_address"]??'',
    billingLatitude: json["billing_latitude"]??'',
    billingLongitude: json["billing_longitude"]??'',
    billingMail: json["billing_mail"]??'',
    billingVat: json["billing_vat"]??'',

  );

  Map<String, dynamic> toJson() => {
    "clinic_billing_id": clinicBillingId,
    "clinic_id": clinicId,
    "billing_name": billingName,
    "billing_address": billingAddress,
    "billing_latitude": billingLatitude,
    "billing_longitude": billingLongitude,
    "billing_mail": billingMail,
    "billing_vat": billingVat,

  };
}
