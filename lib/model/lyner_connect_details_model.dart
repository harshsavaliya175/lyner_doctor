// To parse this JSON data, do
//
//     final lynerConnectDetailsModel = lynerConnectDetailsModelFromJson(jsonString);

import 'dart:convert';

LynerConnectDetailsModel lynerConnectDetailsModelFromJson(String str) => LynerConnectDetailsModel.fromJson(json.decode(str));

String lynerConnectDetailsModelToJson(LynerConnectDetailsModel data) => json.encode(data.toJson());

class LynerConnectDetailsModel {
  LynerConnectDetailsData? data;
  bool? status;
  String? msg;

  LynerConnectDetailsModel({
    this.data,
    this.status,
    this.msg,
  });

  factory LynerConnectDetailsModel.fromJson(Map<String, dynamic> json) => LynerConnectDetailsModel(
    data: json["data"] == null ? null : LynerConnectDetailsData.fromJson(json["data"]),
    status: json["status"]==1,
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "status": status,
    "msg": msg,
  };
}

class LynerConnectDetailsData {
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
  List<Gallery>? gallery;

  LynerConnectDetailsData({
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
    this.gallery,
  });

  factory LynerConnectDetailsData.fromJson(Map<String, dynamic> json) => LynerConnectDetailsData(
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
    gallery: json["gallery"] == null ? [] : List<Gallery>.from(json["gallery"]!.map((x) => Gallery.fromJson(x))),
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
    "gallery": gallery == null ? [] : List<dynamic>.from(gallery!.map((x) => x.toJson())),
  };
}

class Gallery {
  int? smileGalleryId;
  int? userId;
  int? alignerStage;
  DateTime? stageCompletedDate;
  String? straightWithLyner;
  String? leftWithLyner;
  String? rightWithLyner;
  String? straight;
  String? left;
  String? right;

  Gallery({
    this.smileGalleryId,
    this.userId,
    this.alignerStage,
    this.stageCompletedDate,
    this.straightWithLyner,
    this.leftWithLyner,
    this.rightWithLyner,
    this.straight,
    this.left,
    this.right,
  });

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
    smileGalleryId: json["smile_gallery_id"],
    userId: json["user_id"],
    alignerStage: json["aligner_stage"],
    stageCompletedDate: json["stage_completed_date"] == null ? null : DateTime.parse(json["stage_completed_date"]),
    straightWithLyner: json["straight_with_lyner"],
    leftWithLyner: json["left_with_lyner"],
    rightWithLyner: json["right_with_lyner"],
    straight: json["straight"],
    left: json["left"],
    right: json["right"],
  );

  Map<String, dynamic> toJson() => {
    "smile_gallery_id": smileGalleryId,
    "user_id": userId,
    "aligner_stage": alignerStage,
    "stage_completed_date": "${stageCompletedDate!.year.toString().padLeft(4, '0')}-${stageCompletedDate!.month.toString().padLeft(2, '0')}-${stageCompletedDate!.day.toString().padLeft(2, '0')}",
    "straight_with_lyner": straightWithLyner,
    "left_with_lyner": leftWithLyner,
    "right_with_lyner": rightWithLyner,
    "straight": straight,
    "left": left,
    "right": right,
  };
}
