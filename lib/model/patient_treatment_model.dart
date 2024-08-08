import 'dart:convert';

class PatientTreatmentResponseModel {
  final List<PatientTreatmentModel>? patientTreatmentModel;
  final bool? status;
  final String? msg;

  PatientTreatmentResponseModel({
    this.patientTreatmentModel,
    this.status,
    this.msg,
  });

  PatientTreatmentResponseModel copyWith({
    List<PatientTreatmentModel>? data,
    bool? status,
    String? msg,
  }) =>
      PatientTreatmentResponseModel(
        patientTreatmentModel: data ?? this.patientTreatmentModel,
        status: status ?? this.status,
        msg: msg ?? this.msg,
      );

  factory PatientTreatmentResponseModel.fromRawJson(String str) =>
      PatientTreatmentResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PatientTreatmentResponseModel.fromJson(Map<String, dynamic> json) =>
      PatientTreatmentResponseModel(
        patientTreatmentModel: json["data"] == null
            ? []
            : List<PatientTreatmentModel>.from(
                json["data"]!.map((x) => PatientTreatmentModel.fromJson(x))),
        status: json["status"] == 1,
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "data": patientTreatmentModel == null
            ? []
            : List<dynamic>.from(patientTreatmentModel!.map((x) => x.toJson())),
        "status": status,
        "msg": msg,
      };
}

class PatientTreatmentModel {
  final int? patientTreatmentId;
  final int? patientId;
  final DateTime? treatmentDate;
  final String? treatmentNotes;
  final String? nextVisit;
  final int? sentByLyner;
  final int? sentByClinic;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PatientTreatmentModel({
    this.patientTreatmentId,
    this.patientId,
    this.treatmentDate,
    this.treatmentNotes,
    this.nextVisit,
    this.sentByLyner,
    this.sentByClinic,
    this.createdAt,
    this.updatedAt,
  });

  PatientTreatmentModel copyWith({
    int? patientTreatmentId,
    int? patientId,
    DateTime? treatmentDate,
    String? treatmentNotes,
    String? nextVisit,
    int? sentByLyner,
    int? sentByClinic,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      PatientTreatmentModel(
        patientTreatmentId: patientTreatmentId ?? this.patientTreatmentId,
        patientId: patientId ?? this.patientId,
        treatmentDate: treatmentDate ?? this.treatmentDate,
        treatmentNotes: treatmentNotes ?? this.treatmentNotes,
        nextVisit: nextVisit ?? this.nextVisit,
        sentByLyner: sentByLyner ?? this.sentByLyner,
        sentByClinic: sentByClinic ?? this.sentByClinic,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory PatientTreatmentModel.fromRawJson(String str) =>
      PatientTreatmentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PatientTreatmentModel.fromJson(Map<String, dynamic> json) =>
      PatientTreatmentModel(
        patientTreatmentId: json["patient_treatment_id"],
        patientId: json["patient_id"],
        treatmentDate: json["treatment_date"] == null
            ? null
            : DateTime.parse(json["treatment_date"]),
        treatmentNotes: json["treatment_notes"],
        nextVisit: json["next_visit"],
        sentByLyner: json["sent_by_lyner"],
        sentByClinic: json["sent_by_clinic"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "patient_treatment_id": patientTreatmentId,
        "patient_id": patientId,
        "treatment_date":
            "${treatmentDate!.year.toString().padLeft(4, '0')}-${treatmentDate!.month.toString().padLeft(2, '0')}-${treatmentDate!.day.toString().padLeft(2, '0')}",
        "treatment_notes": treatmentNotes,
        "next_visit": nextVisit,
        "sent_by_lyner": sentByLyner,
        "sent_by_clinic": sentByClinic,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
