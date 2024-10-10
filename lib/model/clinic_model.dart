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
  final String authToken;
  final String verifyForgotCode;
  final String type;
  final int isEmailNotification;
  final int isPhoneNotification;
  final DateTime createdAt;
  final DateTime updatedAt;
  DoctorData? doctorData;

  ClinicData({
    required this.clinicId,
    required this.clinicName,
    required this.email,
    required this.clinicMobileNumber,
    required this.clinicPhoto,
    required this.authToken,
    required this.verifyForgotCode,
    required this.type,
    required this.isEmailNotification,
    required this.isPhoneNotification,
    required this.createdAt,
    required this.updatedAt,
    this.doctorData,
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
    String? type,
    int? isEmailNotification,
    int? isPhoneNotification,
    DateTime? createdAt,
    DateTime? updatedAt,
    DoctorData? doctorData,
  }) =>
      ClinicData(
        clinicId: clinicId ?? this.clinicId,
        clinicName: clinicName ?? this.clinicName,
        email: email ?? this.email,
        clinicMobileNumber: clinicMobileNumber ?? this.clinicMobileNumber,
        clinicPhoto: clinicPhoto ?? this.clinicPhoto,
        authToken: authToken ?? this.authToken,
        verifyForgotCode: verifyForgotCode ?? this.verifyForgotCode,
        type: type ?? this.type,
        isEmailNotification: isEmailNotification ?? this.isEmailNotification,
        isPhoneNotification: isPhoneNotification ?? this.isPhoneNotification,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        doctorData: doctorData ?? this.doctorData,
      );

  factory ClinicData.fromRawJson(String str) =>
      ClinicData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClinicData.fromJson(Map<String, dynamic> json) => ClinicData(
        clinicId: json["clinic_id"] ?? 0,
        clinicName: json["clinic_name"] ?? '',
        email: json["email"] ?? '',
        clinicMobileNumber: json["clinic_mobile_number"] ?? '',
        clinicPhoto: json["clinic_photo"] ?? '',
        authToken: json["auth_token"] ?? '',
        verifyForgotCode: json["verify_forgot_code"] ?? '',
        type: json["type"] ?? '',
        isEmailNotification: json["is_email_notification"] ?? 0,
        isPhoneNotification: json["is_phone_notification"] ?? 0,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        doctorData: json["doctor_data"] == null
            ? null
            : DoctorData.fromJson(json["doctor_data"]),
      );

  Map<String, dynamic> toJson() => {
        "clinic_id": clinicId,
        "clinic_name": clinicName,
        "email": email,
        "clinic_mobile_number": clinicMobileNumber,
        "clinic_photo": clinicPhoto,
        "auth_token": authToken,
        "verify_forgot_code": verifyForgotCode,
        "type": type,
        "is_email_notification": isEmailNotification,
        "is_phone_notification": isPhoneNotification,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "doctor_data": doctorData?.toJson(),
      };
}

class DoctorData {
  int doctorId;
  int clinicId;
  String doctorUniqueId;
  String firstName;
  String lastName;
  String email;
  String mobileNumber;
  String doctorProfile;
  dynamic country;
  String language;
  int isDeleted;
  DateTime createdAt;
  DateTime updatedAt;

  DoctorData({
    required this.doctorId,
    required this.clinicId,
    required this.doctorUniqueId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    required this.doctorProfile,
    required this.country,
    required this.language,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DoctorData.fromJson(Map<String, dynamic> json) => DoctorData(
        doctorId: json["doctor_id"],
        clinicId: json["clinic_id"],
        doctorUniqueId: json["doctor_unique_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        mobileNumber: json["mobile_number"],
        doctorProfile: json["doctor_profile"],
        country: json["country"],
        language: json["language"],
        isDeleted: json["is_deleted"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "doctor_id": doctorId,
        "clinic_id": clinicId,
        "doctor_unique_id": doctorUniqueId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "mobile_number": mobileNumber,
        "doctor_profile": doctorProfile,
        "country": country,
        "language": language,
        "is_deleted": isDeleted,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
