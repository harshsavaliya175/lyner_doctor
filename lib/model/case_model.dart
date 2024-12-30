import 'package:lynerdoctor/core/utils/extension.dart';

class CaseSelectionModel {
  CaseModel? caseModel;
  bool? status;
  String? msg;

  CaseSelectionModel({this.caseModel, this.status, this.msg});

  CaseSelectionModel.fromJson(Map<String, dynamic> json) {
    caseModel =
        json['data'] != null ? new CaseModel.fromJson(json['data']) : null;
    status = json['status'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.caseModel != null) {
      data['data'] = this.caseModel!.toJson();
    }
    data['status'] = this.status;
    data['msg'] = this.msg;
    return data;
  }
}

class CaseModel {
  int? id;
  String? profile;
  String? firstName;
  String? lastName;
  DateTime? dateOfBirth;
  String? patientRequest;
  String? treatmentObjectives;
  int? clinicId;
  int? orthodontistId;
  String? status;
  String? orthodontistDiagnosis;
  String? diagnosisPdf;
  int? isDraft;
  int? isConvertedToPatient;
  DateTime? createdAt;
  DateTime? updatedAt;
  Photos? photos;

  CaseModel({
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
    this.photos,
  });

  CaseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profile = json['profile'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    dateOfBirth = json["date_of_birth"] == null
        ? null
        : DateTime.parse(json["date_of_birth"]);
    patientRequest = json['patient_request'];
    treatmentObjectives = json['treatment_objectives'];
    clinicId = json['clinic_id'];
    orthodontistId = json['orthodontist_id'];
    status = json['status'];
    orthodontistDiagnosis = json['orthodontist_diagnosis'];
    diagnosisPdf = json['diagnosis_pdf'];
    isDraft = json['is_draft'];
    isConvertedToPatient = json['is_converted_to_patient'];
    createdAt = json["created_at"] == null
        ? null
        : DateTime.parse(convertUtcToLocal(json["created_at"])).toLocal();
    updatedAt = json["updated_at"] == null
        ? null
        : DateTime.parse(convertUtcToLocal(json["updated_at"])).toLocal();
    photos =
        json['photos'] != null ? new Photos.fromJson(json['photos']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['profile'] = this.profile;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['date_of_birth'] =
        "${this.dateOfBirth!.year.toString().padLeft(4, '0')}-${this.dateOfBirth!.month.toString().padLeft(2, '0')}-${this.dateOfBirth!.day.toString().padLeft(2, '0')}";
    data['patient_request'] = this.patientRequest;
    data['treatment_objectives'] = this.treatmentObjectives;
    data['clinic_id'] = this.clinicId;
    data['orthodontist_id'] = this.orthodontistId;
    data['status'] = this.status;
    data['orthodontist_diagnosis'] = this.orthodontistDiagnosis;
    data['diagnosis_pdf'] = this.diagnosisPdf;
    data['is_draft'] = this.isDraft;
    data['is_converted_to_patient'] = this.isConvertedToPatient;
    data['created_at'] = this.createdAt?.toIso8601String();
    data['updated_at'] = this.updatedAt?.toIso8601String();
    if (this.photos != null) {
      data['photos'] = this.photos!.toJson();
    }
    return data;
  }
}

class Photos {
  int? id;
  int? caseSelectionId;
  String? gauche;
  String? face;
  String? sourire;
  String? interGauche;
  String? interFace;
  String? interDroite;
  String? interMax;
  String? interMandi;
  String? paramiqueRadio;
  String? cephalRadio;
  String? dcomFileName;
  String? upperJawStlFile;
  String? lowerJawStlFile;
  String? droite;
  String? maxScan;
  String? mandiScan;
  String? stlFileLink;
  DateTime? createdAt;
  DateTime? updatedAt;

  Photos({
    this.id,
    this.caseSelectionId,
    this.gauche,
    this.face,
    this.sourire,
    this.interGauche,
    this.interFace,
    this.interDroite,
    this.interMax,
    this.interMandi,
    this.paramiqueRadio,
    this.cephalRadio,
    this.dcomFileName,
    this.upperJawStlFile,
    this.lowerJawStlFile,
    this.droite,
    this.maxScan,
    this.mandiScan,
    this.stlFileLink,
    this.createdAt,
    this.updatedAt,
  });

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    caseSelectionId = json['case_selection_id'];
    gauche = json['gauche'];
    face = json['face'];
    sourire = json['sourire'];
    interGauche = json['inter_gauche'];
    interFace = json['inter_face'];
    interDroite = json['inter_droite'];
    interMax = json['inter_max'];
    interMandi = json['inter_mandi'];
    paramiqueRadio = json['paramique_radio'];
    cephalRadio = json['cephal_radio'];
    dcomFileName = json['dcom_file_name'];
    upperJawStlFile = json['upper_jaw_stl_file'];
    lowerJawStlFile = json['lower_jaw_stl_file'];
    droite = json['droite'];
    maxScan = json['max_scan'];
    mandiScan = json['mandi_scan'];
    stlFileLink = json['stl_file_link'];
    createdAt = json["created_at"] == null
        ? null
        : DateTime.parse(convertUtcToLocal(json["created_at"])).toLocal();
    updatedAt = json["updated_at"] == null
        ? null
        : DateTime.parse(convertUtcToLocal(json["updated_at"])).toLocal();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['case_selection_id'] = this.caseSelectionId;
    data['gauche'] = this.gauche;
    data['face'] = this.face;
    data['sourire'] = this.sourire;
    data['inter_gauche'] = this.interGauche;
    data['inter_face'] = this.interFace;
    data['inter_droite'] = this.interDroite;
    data['inter_max'] = this.interMax;
    data['inter_mandi'] = this.interMandi;
    data['paramique_radio'] = this.paramiqueRadio;
    data['cephal_radio'] = this.cephalRadio;
    data['dcom_file_name'] = this.dcomFileName;
    data['upper_jaw_stl_file'] = this.upperJawStlFile;
    data['lower_jaw_stl_file'] = this.lowerJawStlFile;
    data['droite'] = this.droite;
    data['max_scan'] = this.maxScan;
    data['mandi_scan'] = this.mandiScan;
    data['stl_file_link'] = this.stlFileLink;
    data['created_at'] = this.createdAt?.toIso8601String();
    data['updated_at'] = this.updatedAt?.toIso8601String();
    return data;
  }
}
