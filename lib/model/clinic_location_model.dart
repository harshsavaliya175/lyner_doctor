import 'dart:convert';

class ClinicLocationResponseModel {
  final List<ClinicLocation> clinicLocation;
  final int status;
  final String msg;

  ClinicLocationResponseModel({
    required this.clinicLocation,
    required this.status,
    required this.msg,
  });

  ClinicLocationResponseModel copyWith({
    List<ClinicLocation>? data,
    int? status,
    String? msg,
  }) =>
      ClinicLocationResponseModel(
        clinicLocation: data ?? this.clinicLocation,
        status: status ?? this.status,
        msg: msg ?? this.msg,
      );

  factory ClinicLocationResponseModel.fromRawJson(String str) =>
      ClinicLocationResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClinicLocationResponseModel.fromJson(Map<String, dynamic> json) =>
      ClinicLocationResponseModel(
        clinicLocation: List<ClinicLocation>.from(
            json["data"].map((x) => ClinicLocation.fromJson(x))),
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(clinicLocation.map((x) => x.toJson())),
        "status": status,
        "msg": msg,
      };
}

class ClinicLocation {
  final int clinicLocationId;
  final int clinicId;
  final String contactName;
  final String contactNumber;
  final String address;
  final String latitude;
  final String longitude;


  ClinicLocation({
    required this.clinicLocationId,
    required this.clinicId,
    required this.contactName,
    required this.contactNumber,
    required this.address,
    required this.latitude,
    required this.longitude,

  });

  ClinicLocation copyWith({
    int? clinicLocationId,
    int? clinicId,
    String? contactName,
    String? contactNumber,
    String? address,
    String? latitude,
    String? longitude,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ClinicLocation(
        clinicLocationId: clinicLocationId ?? this.clinicLocationId,
        clinicId: clinicId ?? this.clinicId,
        contactName: contactName ?? this.contactName,
        contactNumber: contactNumber ?? this.contactNumber,
        address: address ?? this.address,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,

      );

  factory ClinicLocation.fromRawJson(String str) =>
      ClinicLocation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClinicLocation.fromJson(Map<String, dynamic> json) => ClinicLocation(
        clinicLocationId: json["clinic_location_id"],
        clinicId: json["clinic_id"],
        contactName: json["contact_name"],
        contactNumber: json["contact_number"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],

      );

  Map<String, dynamic> toJson() => {
        "clinic_location_id": clinicLocationId,
        "clinic_id": clinicId,
        "contact_name": contactName,
        "contact_number": contactNumber,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,

      };
}
