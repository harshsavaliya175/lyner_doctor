// To parse this JSON data, do
//
//     final prescriptionModel = prescriptionModelFromJson(jsonString);

import 'dart:convert';

PrescriptionModel prescriptionModelFromJson(String str) => PrescriptionModel.fromJson(json.decode(str));

String prescriptionModelToJson(PrescriptionModel data) => json.encode(data.toJson());

class PrescriptionModel {
  PrescriptionData? data;
  bool? status;
  String? msg;

  PrescriptionModel({
    this.data,
    this.status,
    this.msg,
  });

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) => PrescriptionModel(
    data: json["data"] == null ? null : PrescriptionData.fromJson(json["data"]),
    status: json["status"]==1,
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "status": status,
    "msg": msg,
  };
}

class PrescriptionData {
  int? patientPrescriptionId;
  int? patientId;
  String? arcadeToBeTreated;
  String? treatmentObjectives;
  String? dentalClass;
  String? maxillaryIncisalMiddle;
  String? acceptedTechniques;
  String? dentalHistory;
  String? incisiveCovering;
  String? arcadeNote;
  String? treatmentNotes;
  String? dentalNote;
  String? maxillaryIncisalNote;
  String? acceptedTechniqueNote;
  String? dentalHistoryNote;
  String? incisiveCoveringNote;
  String? otherRecommendations;

  PrescriptionData({
    this.patientPrescriptionId,
    this.patientId,
    this.arcadeToBeTreated,
    this.treatmentObjectives,
    this.dentalClass,
    this.maxillaryIncisalMiddle,
    this.acceptedTechniques,
    this.dentalHistory,
    this.incisiveCovering,
    this.arcadeNote,
    this.treatmentNotes,
    this.dentalNote,
    this.maxillaryIncisalNote,
    this.acceptedTechniqueNote,
    this.dentalHistoryNote,
    this.incisiveCoveringNote,
    this.otherRecommendations,
  });

  factory PrescriptionData.fromJson(Map<String, dynamic> json) => PrescriptionData(
    patientPrescriptionId: json["patient_prescription_id"],
    patientId: json["patient_id"],
    arcadeToBeTreated: json["arcade_to_be_treated"],
    treatmentObjectives: json["treatment_objectives"],
    dentalClass: json["dental_class"],
    maxillaryIncisalMiddle: json["maxillary_incisal_middle"],
    acceptedTechniques: json["accepted_techniques"],
    dentalHistory: json["dental_history"],
    incisiveCovering: json["incisive_covering"],
    arcadeNote: json["arcade_note"],
    treatmentNotes: json["treatment_notes"],
    dentalNote: json["dental_note"],
    maxillaryIncisalNote: json["maxillary_incisal_note"],
    acceptedTechniqueNote: json["accepted_technique_note"],
    dentalHistoryNote: json["dental_history_note"],
    incisiveCoveringNote: json["incisive_covering_note"],
    otherRecommendations: json["other_recommendations"],
  );

  Map<String, dynamic> toJson() => {
    "patient_prescription_id": patientPrescriptionId,
    "patient_id": patientId,
    "arcade_to_be_treated": arcadeToBeTreated,
    "treatment_objectives": treatmentObjectives,
    "dental_class": dentalClass,
    "maxillary_incisal_middle": maxillaryIncisalMiddle,
    "accepted_techniques": acceptedTechniques,
    "dental_history": dentalHistory,
    "incisive_covering": incisiveCovering,
    "arcade_note": arcadeNote,
    "treatment_notes": treatmentNotes,
    "dental_note": dentalNote,
    "maxillary_incisal_note": maxillaryIncisalNote,
    "accepted_technique_note": acceptedTechniqueNote,
    "dental_history_note": dentalHistoryNote,
    "incisive_covering_note": incisiveCoveringNote,
    "other_recommendations": otherRecommendations,
  };
}
