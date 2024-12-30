// To parse this JSON data, do
//
//     final getEstimateQuotesData = getEstimateQuotesDataFromJson(jsonString);

import 'dart:convert';

import 'package:lynerdoctor/core/utils/extension.dart';

GetEstimateQuotesData getEstimateQuotesDataFromJson(String str) =>
    GetEstimateQuotesData.fromJson(json.decode(str));

String getEstimateQuotesDataToJson(GetEstimateQuotesData data) =>
    json.encode(data.toJson());

class GetEstimateQuotesData {
  List<EstimateQuotesData>? data;
  bool? status;
  String? msg;

  GetEstimateQuotesData({
    this.data,
    this.status,
    this.msg,
  });

  factory GetEstimateQuotesData.fromJson(Map<String, dynamic> json) =>
      GetEstimateQuotesData(
        data: json["data"] == null
            ? []
            : List<EstimateQuotesData>.from(
                json["data"]!.map((x) => EstimateQuotesData.fromJson(x))),
        status: json["status"] == 1,
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
        "msg": msg,
      };
}

class EstimateQuotesData {
  int? eqId;
  int? clinicId;
  String? estimateQuoteTittle;
  int? doctorId;
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? email;
  int? totalAmount;
  int? numOfSemester;
  int? contentionPrice;
  String? fileName;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? doctorFirstName;
  String? doctorLastName;
  String? doctorProfile;

  EstimateQuotesData({
    this.eqId,
    this.clinicId,
    this.estimateQuoteTittle,
    this.doctorId,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.email,
    this.totalAmount,
    this.numOfSemester,
    this.contentionPrice,
    this.fileName,
    this.createdAt,
    this.updatedAt,
    this.doctorFirstName,
    this.doctorLastName,
    this.doctorProfile,
  });

  factory EstimateQuotesData.fromJson(Map<String, dynamic> json) =>
      EstimateQuotesData(
        eqId: json["eq_id"],
        clinicId: json["clinic_id"],
        estimateQuoteTittle: json["estimate_quote_tittle"],
        doctorId: json["doctor_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        dateOfBirth: json["date_of_birth"],
        email: json["email"],
        totalAmount: json["total_amount"],
        numOfSemester: json["num_of_semester"],
        contentionPrice: json["contention_price"],
        fileName: json["file_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(convertUtcToLocal(json["created_at"])).toLocal(),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(convertUtcToLocal(json["updated_at"])).toLocal(),
        doctorFirstName: json["doctor_first_name"],
        doctorLastName: json["doctor_last_name"],
        doctorProfile: json["doctor_profile"],
      );

  Map<String, dynamic> toJson() => {
        "eq_id": eqId,
        "clinic_id": clinicId,
        "estimate_quote_tittle": estimateQuoteTittle,
        "doctor_id": doctorId,
        "first_name": firstName,
        "last_name": lastName,
        "date_of_birth": dateOfBirth,
        "email": email,
        "total_amount": totalAmount,
        "num_of_semester": numOfSemester,
        "contention_price": contentionPrice,
        "file_name": fileName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "doctor_first_name": doctorFirstName,
        "doctor_last_name": doctorLastName,
        "doctor_profile": doctorProfile,
      };
}
