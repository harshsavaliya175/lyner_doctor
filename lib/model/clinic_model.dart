import 'dart:convert';

class ClinicResponseModel {
  final ClinicData clinicData;
  final String msg;
  final int status;

  ClinicResponseModel({
    required this.clinicData,
    required this.msg,
    required this.status,
  });

  ClinicResponseModel copyWith({
    ClinicData? data,
    String? msg,
    int? status,
  }) =>
      ClinicResponseModel(
        clinicData: data ?? this.clinicData,
        msg: msg ?? this.msg,
        status: status ?? this.status,
      );

  factory ClinicResponseModel.fromRawJson(String str) =>
      ClinicResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClinicResponseModel.fromJson(Map<String, dynamic> json) =>
      ClinicResponseModel(
        clinicData: ClinicData.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": clinicData.toJson(),
        "msg": msg,
        "status": status,
      };
}

class ClinicData {
  final int clinicId;
  final String clinicName;
  final String email;
  final String clinicMobileNumber;
  final String clinicPhoto;
  final dynamic emailVerifiedAt;
  final String rememberToken;
  final String authToken;
  final String verifyForgotCode;
  final int isEmailNotification;
  final int isPhoneNotification;
  final DateTime createdAt;
  final DateTime updatedAt;

  ClinicData({
    required this.clinicId,
    required this.clinicName,
    required this.email,
    required this.clinicMobileNumber,
    required this.clinicPhoto,
    required this.emailVerifiedAt,
    required this.rememberToken,
    required this.authToken,
    required this.verifyForgotCode,
    required this.isEmailNotification,
    required this.isPhoneNotification,
    required this.createdAt,
    required this.updatedAt,
  });

  ClinicData copyWith({
    int? clinicId,
    String? clinicName,
    String? email,
    String? clinicMobileNumber,
    String? clinicPhoto,
    dynamic emailVerifiedAt,
    String? rememberToken,
    String? authToken,
    String? verifyForgotCode,
    int? isEmailNotification,
    int? isPhoneNotification,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ClinicData(
        clinicId: clinicId ?? this.clinicId,
        clinicName: clinicName ?? this.clinicName,
        email: email ?? this.email,
        clinicMobileNumber: clinicMobileNumber ?? this.clinicMobileNumber,
        clinicPhoto: clinicPhoto ?? this.clinicPhoto,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        rememberToken: rememberToken ?? this.rememberToken,
        authToken: authToken ?? this.authToken,
        verifyForgotCode: verifyForgotCode ?? this.verifyForgotCode,
        isEmailNotification: isEmailNotification ?? this.isEmailNotification,
        isPhoneNotification: isPhoneNotification ?? this.isPhoneNotification,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ClinicData.fromRawJson(String str) =>
      ClinicData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClinicData.fromJson(Map<String, dynamic> json) => ClinicData(
        clinicId: json["clinic_id"],
        clinicName: json["clinic_name"],
        email: json["email"],
        clinicMobileNumber: json["clinic_mobile_number"],
        clinicPhoto: json["clinic_photo"],
        emailVerifiedAt: json["email_verified_at"],
        rememberToken: json["remember_token"],
        authToken: json["auth_token"],
        verifyForgotCode: json["verify_forgot_code"],
        isEmailNotification: json["is_email_notification"],
        isPhoneNotification: json["is_phone_notification"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "clinic_id": clinicId,
        "clinic_name": clinicName,
        "email": email,
        "clinic_mobile_number": clinicMobileNumber,
        "clinic_photo": clinicPhoto,
        "email_verified_at": emailVerifiedAt,
        "remember_token": rememberToken,
        "auth_token": authToken,
        "verify_forgot_code": verifyForgotCode,
        "is_email_notification": isEmailNotification,
        "is_phone_notification": isPhoneNotification,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
