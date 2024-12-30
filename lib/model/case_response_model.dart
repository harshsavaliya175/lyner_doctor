import 'dart:convert';

class CaseSelectionResponseModel {
  final List<CaseSelectionData>? data;
  final bool? status;
  final String? msg;

  CaseSelectionResponseModel({
    this.data,
    this.status,
    this.msg,
  });

  factory CaseSelectionResponseModel.fromRawJson(String str) =>
      CaseSelectionResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CaseSelectionResponseModel.fromJson(Map<String, dynamic> json) =>
      CaseSelectionResponseModel(
        data: json["data"] == null
            ? []
            : List<CaseSelectionData>.from(
                json["data"].map((x) => CaseSelectionData.fromJson(x))),
        status: json["status"] == 1, // Assuming 1 means true
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status == true ? 1 : 0,
        "msg": msg,
      };
}

class CaseSelectionData {
  final int? id;
  final String? profile;
  final String? firstName;
  final String? lastName;
  final DateTime? dateOfBirth;
  final String? patientRequest;
  final String? treatmentObjectives;
  final int? clinicId;
  final int? orthodontistId;
  final String? status;
  final String? orthodontistDiagnosis;
  final String? diagnosisPdf;
  final bool? isDraft;
  final bool? isConvertedToPatient;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CaseSelectionData({
    this.id,
    this.profile,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.patientRequest,
    this.treatmentObjectives,
    this.clinicId,
    this.orthodontistId,
    this.status,
    this.orthodontistDiagnosis,
    this.diagnosisPdf,
    this.isDraft,
    this.isConvertedToPatient,
    this.createdAt,
    this.updatedAt,
  });

  factory CaseSelectionData.fromRawJson(String str) =>
      CaseSelectionData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CaseSelectionData.fromJson(Map<String, dynamic> json) =>
      CaseSelectionData(
        id: json["id"],
        profile: json["profile"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        patientRequest: json["patient_request"],
        treatmentObjectives: json["treatment_objectives"],
        clinicId: json["clinic_id"],
        orthodontistId: json["orthodontist_id"],
        status: json["status"],
        orthodontistDiagnosis: json["orthodontist_diagnosis"],
        diagnosisPdf: json["diagnosis_pdf"],
        isDraft: json["is_draft"] == 1,
        isConvertedToPatient: json["is_converted_to_patient"] == 1,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "profile": profile,
        "first_name": firstName,
        "last_name": lastName,
        "date_of_birth": dateOfBirth?.toIso8601String(), // ISO 8601 date format
        "patient_request": patientRequest,
        "treatment_objectives": treatmentObjectives,
        "clinic_id": clinicId,
        "orthodontist_id": orthodontistId,
        "status": status,
        "orthodontist_diagnosis": orthodontistDiagnosis,
        "diagnosis_pdf": diagnosisPdf,
        "is_draft": isDraft == true ? 1 : 0,
        "is_converted_to_patient": isConvertedToPatient == true ? 1 : 0,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
