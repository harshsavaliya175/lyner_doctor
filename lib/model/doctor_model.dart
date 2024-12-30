import 'dart:convert';

import 'package:lynerdoctor/core/utils/extension.dart';

class DoctorResponseModel {
  final List<DoctorData> doctorData;
  final int status;
  final String msg;

  DoctorResponseModel({
    required this.doctorData,
    required this.status,
    required this.msg,
  });

  DoctorResponseModel copyWith({
    List<DoctorData>? data,
    int? status,
    String? msg,
  }) =>
      DoctorResponseModel(
        doctorData: data ?? this.doctorData,
        status: status ?? this.status,
        msg: msg ?? this.msg,
      );

  factory DoctorResponseModel.fromRawJson(String str) =>
      DoctorResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DoctorResponseModel.fromJson(Map<String, dynamic> json) =>
      DoctorResponseModel(
        doctorData: List<DoctorData>.from(
            json["data"].map((x) => DoctorData.fromJson(x))),
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(doctorData.map((x) => x.toJson())),
        "status": status,
        "msg": msg,
      };
}

class DoctorData {
  final int doctorId;
  final String doctorUniqueId;
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String doctorProfile;
  final dynamic country;
  final String language;
  final int clinicId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DoctorData({
    required this.doctorId,
    required this.doctorUniqueId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    required this.doctorProfile,
    required this.country,
    required this.language,
    required this.clinicId,
    this.createdAt,
    this.updatedAt,
  });

  DoctorData copyWith({
    int? doctorId,
    String? doctorUniqueId,
    String? firstName,
    String? lastName,
    String? email,
    String? mobileNumber,
    String? doctorProfile,
    dynamic country,
    String? language,
    int? clinicId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      DoctorData(
        doctorId: doctorId ?? this.doctorId,
        doctorUniqueId: doctorUniqueId ?? this.doctorUniqueId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        doctorProfile: doctorProfile ?? this.doctorProfile,
        country: country ?? this.country,
        language: language ?? this.language,
        clinicId: clinicId ?? this.clinicId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory DoctorData.fromRawJson(String str) =>
      DoctorData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DoctorData.fromJson(Map<String, dynamic> json) => DoctorData(
        doctorId: json["doctor_id"],
        doctorUniqueId: json["doctor_unique_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        mobileNumber: json["mobile_number"],
        doctorProfile: json["doctor_profile"],
        country: json["country"],
        language: json["language"],
        clinicId: json["clinic_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(convertUtcToLocal(json["created_at"])).toLocal(),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(convertUtcToLocal(json["updated_at"])).toLocal(),
      );

  Map<String, dynamic> toJson() => {
        "doctor_id": doctorId,
        "doctor_unique_id": doctorUniqueId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "mobile_number": mobileNumber,
        "doctor_profile": doctorProfile,
        "country": country,
        "language": language,
        "clinic_id": clinicId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
