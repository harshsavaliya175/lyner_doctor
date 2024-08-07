// To parse this JSON data, do
//
//     final lynerConnectListModel = lynerConnectListModelFromJson(jsonString);

import 'dart:convert';

LynerConnectListModel lynerConnectListModelFromJson(String str) => LynerConnectListModel.fromJson(json.decode(str));

String lynerConnectListModelToJson(LynerConnectListModel data) => json.encode(data.toJson());

class LynerConnectListModel {
  List<LynerConnectList>? data;
  bool? status;
  String? msg;

  LynerConnectListModel({
    this.data,
    this.status,
    this.msg,
  });

  factory LynerConnectListModel.fromJson(Map<String, dynamic> json) => LynerConnectListModel(
    data: json["data"] == null ? [] : List<LynerConnectList>.from(json["data"]!.map((x) => LynerConnectList.fromJson(x))),
    status: json["status"]==1,
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "status": status,
    "msg": msg,
  };
}

class LynerConnectList {
  int? userId;
  int? doctorId;
  int? patientId;
  int? clinicId;
  String? userToken;
  String? doctorUniqId;
  String? firstName;
  String? lastName;
  String? email;
  String? userProfilePhoto;
  String? phoneNo;
  DateTime? emailVerifiedAt;
  String? referenceCode;
  int? alignerStage;
  int? currentAlignerStage;
  int? alignerDay;
  DateTime? treatmentStartDate;
  String? authToken;
  String? devicePushToken;
  String? deviceType;
  String? verifyForgotCode;
  String? timeZone;
  int? isLoggedOut;
  int? isBlock;

  LynerConnectList({
    this.userId,
    this.doctorId,
    this.patientId,
    this.clinicId,
    this.userToken,
    this.doctorUniqId,
    this.firstName,
    this.lastName,
    this.email,
    this.userProfilePhoto,
    this.phoneNo,
    this.emailVerifiedAt,
    this.referenceCode,
    this.alignerStage,
    this.currentAlignerStage,
    this.alignerDay,
    this.treatmentStartDate,
    this.authToken,
    this.devicePushToken,
    this.deviceType,
    this.verifyForgotCode,
    this.timeZone,
    this.isLoggedOut,
    this.isBlock,
  });

  factory LynerConnectList.fromJson(Map<String, dynamic> json) => LynerConnectList(
    userId: json["user_id"],
    doctorId: json["doctor_id"],
    patientId: json["patient_id"],
    clinicId: json["clinic_id"],
    userToken: json["user_token"],
    doctorUniqId: json["doctor_uniq_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    userProfilePhoto: json["user_profile_photo"],
    phoneNo: json["phone_no"],
    emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
    referenceCode: json["reference_code"],
    alignerStage: json["aligner_stage"],
    currentAlignerStage: json["current_aligner_stage"],
    alignerDay: json["aligner_day"],
    treatmentStartDate: json["treatment_start_date"] == null ? null : DateTime.parse(json["treatment_start_date"]),
    authToken: json["auth_token"],
    devicePushToken: json["device_push_token"],
    deviceType: json["device_type"],
    verifyForgotCode: json["verify_forgot_code"],
    timeZone: json["time_zone"],
    isLoggedOut: json["is_logged_out"],
    isBlock: json["is_block"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "doctor_id": doctorId,
    "patient_id": patientId,
    "clinic_id": clinicId,
    "user_token": userToken,
    "doctor_uniq_id": doctorUniqId,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "user_profile_photo": userProfilePhoto,
    "phone_no": phoneNo,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "reference_code": referenceCode,
    "aligner_stage": alignerStage,
    "current_aligner_stage": currentAlignerStage,
    "aligner_day": alignerDay,
    "treatment_start_date": treatmentStartDate?.toIso8601String(),
    "auth_token": authToken,
    "device_push_token": devicePushToken,
    "device_type": deviceType,
    "verify_forgot_code": verifyForgotCode,
    "time_zone": timeZone,
    "is_logged_out": isLoggedOut,
    "is_block": isBlock,
  };
}
