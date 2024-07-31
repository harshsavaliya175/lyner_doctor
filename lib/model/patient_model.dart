// To parse this JSON data, do
//
//     final patientModel = patientModelFromJson(jsonString);

import 'dart:convert';

PatientModel patientModelFromJson(String str) => PatientModel.fromJson(json.decode(str));

String patientModelToJson(PatientModel data) => json.encode(data.toJson());

class PatientModel {
  PatientData data;
  bool status;
  String msg;

  PatientModel({
    required this.data,
    required this.status,
    required this.msg,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
    data: PatientData.fromJson(json["data"]),
    status: json["status"]==1,
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "status": status,
    "msg": msg,
  };
}

class PatientData {
  int? patientId;
  String? patientUniqueId;
  String? firstName;
  String? lastName;
  String? email;
  DateTime dateOfBirth;
  String? patientProfile;
  DateTime bondDate;
  String? patient3DModalLink;
  String? linkPassword;
  String? addPlanCount;
  String? clinicItem;
  String? adminItem;
  int? toothCaseId;
  int? doctorId;
  int? clinicId;
  int? clinicLocationId;
  int? clinicBillingId;
  String? technicianId;
  String? technicianStartDate;
  int? adminNewCase;
  int? technicianNewCase;
  int? adminTask;
  int? adminPatient;
  int? clinicTask;
  int? clinicPatient;
  int? isApproved;
  int? isProduction;
  int? isDelivered;
  int? isVirtual;
  String? trackingId;
  int? isDraft;
  String? draftViewPage;
  DateTime createdAt;
  DateTime updatedAt;

  PatientData({
    required this.patientId,
    required this.patientUniqueId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dateOfBirth,
    required this.patientProfile,
    required this.bondDate,
    required this.patient3DModalLink,
    required this.linkPassword,
    required this.addPlanCount,
    required this.clinicItem,
    required this.adminItem,
    required this.toothCaseId,
    required this.doctorId,
    required this.clinicId,
    required this.clinicLocationId,
    required this.clinicBillingId,
    required this.technicianId,
    required this.technicianStartDate,
    required this.adminNewCase,
    required this.technicianNewCase,
    required this.adminTask,
    required this.adminPatient,
    required this.clinicTask,
    required this.clinicPatient,
    required this.isApproved,
    required this.isProduction,
    required this.isDelivered,
    required this.isVirtual,
    required this.trackingId,
    required this.isDraft,
    required this.draftViewPage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PatientData.fromJson(Map<String, dynamic> json) => PatientData(
    patientId: json["patient_id"]??0,
    patientUniqueId: json["patient_unique_id"]??"",
    firstName: json["first_name"]??"",
    lastName: json["last_name"]??"",
    email: json["email"]??"",
    dateOfBirth: json["date_of_birth"] != null ? DateTime.parse(json["date_of_birth"]) : DateTime.now(),
    // dateOfBirth: DateTime.parse(json["date_of_birth"]),
    patientProfile: json["patient_profile"]??"",
    bondDate:json["bond_date"] != null ? DateTime.parse(json["bond_date"]) : DateTime.now(),
    patient3DModalLink: json["patient_3d_modal_link"]??"",
    linkPassword: json["link_password"]??"",
    addPlanCount: json["add_plan_count"]??"",
    clinicItem: json["clinic_item"]??"",
    adminItem: json["admin_item"]??"",
    toothCaseId: json["tooth_case_id"]??0,
    doctorId: json["doctor_id"]??0,
    clinicId: json["clinic_id"]??0,
    clinicLocationId: json["clinic_location_id"]??0,
    clinicBillingId: json["clinic_billing_id"]??0,
    technicianId: json["technician_id"]??"",
    technicianStartDate: json["technician_start_date"]??"",
    adminNewCase: json["admin_new_case"]??0,
    technicianNewCase: json["technician_new_case"]??0,
    adminTask: json["admin_task"]??0,
    adminPatient: json["admin_patient"]??0,
    clinicTask: json["clinic_task"]??0,
    clinicPatient: json["clinic_patient"]??0,
    isApproved: json["is_approved"]??0,
    isProduction: json["is_production"]??0,
    isDelivered: json["is_delivered"]??0,
    isVirtual: json["is_virtual"]??0,
    trackingId: json["tracking_id"]??"",
    isDraft: json["is_draft"]??0,
    draftViewPage: json["draft_view_page"]??"",
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
    updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "patient_id": patientId,
    "patient_unique_id": patientUniqueId,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "patient_profile": patientProfile,
    "bond_date": "${bondDate.year.toString().padLeft(4, '0')}-${bondDate.month.toString().padLeft(2, '0')}-${bondDate.day.toString().padLeft(2, '0')}",
    "patient_3d_modal_link": patient3DModalLink,
    "link_password": linkPassword,
    "add_plan_count": addPlanCount,
    "clinic_item": clinicItem,
    "admin_item": adminItem,
    "tooth_case_id": toothCaseId,
    "doctor_id": doctorId,
    "clinic_id": clinicId,
    "clinic_location_id": clinicLocationId,
    "clinic_billing_id": clinicBillingId,
    "technician_id": technicianId,
    "technician_start_date": technicianStartDate,
    "admin_new_case": adminNewCase,
    "technician_new_case": technicianNewCase,
    "admin_task": adminTask,
    "admin_patient": adminPatient,
    "clinic_task": clinicTask,
    "clinic_patient": clinicPatient,
    "is_approved": isApproved,
    "is_production": isProduction,
    "is_delivered": isDelivered,
    "is_virtual": isVirtual,
    "tracking_id": trackingId,
    "is_draft": isDraft,
    "draft_view_page": draftViewPage,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
/*
import 'dart:convert';

class PatientResponseModel {
  final List<PatientData>? patientData;
  final int? status;
  final String? msg;

  PatientResponseModel({
    this.patientData,
    this.status,
    this.msg,
  });

  PatientResponseModel copyWith({
    List<PatientData>? patientData,
    int? status,
    String? msg,
  }) =>
      PatientResponseModel(
        patientData: patientData ?? this.patientData,
        status: status ?? this.status,
        msg: msg ?? this.msg,
      );

  factory PatientResponseModel.fromRawJson(String str) =>
      PatientResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PatientResponseModel.fromJson(Map<String, dynamic> json) =>
      PatientResponseModel(
        patientData: json["data"] == null
            ? []
            : List<PatientData>.from(
                json["data"]!.map((x) => PatientData.fromJson(x))),
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "data": patientData == null
            ? []
            : List<dynamic>.from(patientData!.map((x) => x.toJson())),
        "status": status,
        "msg": msg,
      };
}

class PatientData {
  final int? patientId;
  final String? patientUniqueId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final DateTime? dateOfBirth;
  final String? patientProfile;
  final DateTime? bondDate;
  final String? patient3DModalLink;
  final String? linkPassword;
  final String? addPlanCount;
  final String? clinicItem;
  final String? adminItem;
  final int? toothCaseId;
  final int? doctorId;
  final int? clinicId;
  final int? clinicLocationId;
  final int? clinicBillingId;
  final int? technicianId;
  final DateTime? technicianStartDate;
  final int? adminNewCase;
  final int? technicianNewCase;
  final int? adminTask;
  final int? adminPatient;
  final int? clinicTask;
  final int? clinicPatient;
  final int? isApproved;
  final int? isProduction;
  final int? isDelivered;
  final int? isVirtual;
  final String? trackingId;
  final int? isDraft;
  final String? draftViewPage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? caseName;

  PatientData({
    this.patientId,
    this.patientUniqueId,
    this.firstName,
    this.lastName,
    this.email,
    this.dateOfBirth,
    this.patientProfile,
    this.bondDate,
    this.patient3DModalLink,
    this.linkPassword,
    this.addPlanCount,
    this.clinicItem,
    this.adminItem,
    this.toothCaseId,
    this.doctorId,
    this.clinicId,
    this.clinicLocationId,
    this.clinicBillingId,
    this.technicianId,
    this.technicianStartDate,
    this.adminNewCase,
    this.technicianNewCase,
    this.adminTask,
    this.adminPatient,
    this.clinicTask,
    this.clinicPatient,
    this.isApproved,
    this.isProduction,
    this.isDelivered,
    this.isVirtual,
    this.trackingId,
    this.isDraft,
    this.draftViewPage,
    this.createdAt,
    this.updatedAt,
    this.caseName,
  });

  PatientData copyWith({
    int? patientId,
    String? patientUniqueId,
    String? firstName,
    String? lastName,
    String? email,
    DateTime? dateOfBirth,
    String? patientProfile,
    DateTime? bondDate,
    String? patient3DModalLink,
    String? linkPassword,
    String? addPlanCount,
    String? clinicItem,
    String? adminItem,
    int? toothCaseId,
    int? doctorId,
    int? clinicId,
    int? clinicLocationId,
    int? clinicBillingId,
    int? technicianId,
    DateTime? technicianStartDate,
    int? adminNewCase,
    int? technicianNewCase,
    int? adminTask,
    int? adminPatient,
    int? clinicTask,
    int? clinicPatient,
    int? isApproved,
    int? isProduction,
    int? isDelivered,
    int? isVirtual,
    String? trackingId,
    int? isDraft,
    String? draftViewPage,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? caseName,
  }) =>
      PatientData(
        patientId: patientId ?? this.patientId,
        patientUniqueId: patientUniqueId ?? this.patientUniqueId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        patientProfile: patientProfile ?? this.patientProfile,
        bondDate: bondDate ?? this.bondDate,
        patient3DModalLink: patient3DModalLink ?? this.patient3DModalLink,
        linkPassword: linkPassword ?? this.linkPassword,
        addPlanCount: addPlanCount ?? this.addPlanCount,
        clinicItem: clinicItem ?? this.clinicItem,
        adminItem: adminItem ?? this.adminItem,
        toothCaseId: toothCaseId ?? this.toothCaseId,
        doctorId: doctorId ?? this.doctorId,
        clinicId: clinicId ?? this.clinicId,
        clinicLocationId: clinicLocationId ?? this.clinicLocationId,
        clinicBillingId: clinicBillingId ?? this.clinicBillingId,
        technicianId: technicianId ?? this.technicianId,
        technicianStartDate: technicianStartDate ?? this.technicianStartDate,
        adminNewCase: adminNewCase ?? this.adminNewCase,
        technicianNewCase: technicianNewCase ?? this.technicianNewCase,
        adminTask: adminTask ?? this.adminTask,
        adminPatient: adminPatient ?? this.adminPatient,
        clinicTask: clinicTask ?? this.clinicTask,
        clinicPatient: clinicPatient ?? this.clinicPatient,
        isApproved: isApproved ?? this.isApproved,
        isProduction: isProduction ?? this.isProduction,
        isDelivered: isDelivered ?? this.isDelivered,
        isVirtual: isVirtual ?? this.isVirtual,
        trackingId: trackingId ?? this.trackingId,
        isDraft: isDraft ?? this.isDraft,
        draftViewPage: draftViewPage ?? this.draftViewPage,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        caseName: caseName ?? this.caseName,
      );

  factory PatientData.fromRawJson(String str) =>
      PatientData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PatientData.fromJson(Map<String, dynamic> json) => PatientData(
        patientId: json["patient_id"],
        patientUniqueId: json["patient_unique_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        patientProfile: json["patient_profile"],
        bondDate: json["bond_date"] == null
            ? null
            : DateTime.parse(json["bond_date"]),
        patient3DModalLink: json["patient_3d_modal_link"],
        linkPassword: json["link_password"],
        addPlanCount: json["add_plan_count"],
        clinicItem: json["clinic_item"],
        adminItem: json["admin_item"],
        toothCaseId: json["tooth_case_id"],
        doctorId: json["doctor_id"],
        clinicId: json["clinic_id"],
        clinicLocationId: json["clinic_location_id"],
        clinicBillingId: json["clinic_billing_id"],
        technicianId: json["technician_id"],
        technicianStartDate: json["technician_start_date"] == null
            ? null
            : DateTime.parse(json["technician_start_date"]),
        adminNewCase: json["admin_new_case"],
        technicianNewCase: json["technician_new_case"],
        adminTask: json["admin_task"],
        adminPatient: json["admin_patient"],
        clinicTask: json["clinic_task"],
        clinicPatient: json["clinic_patient"],
        isApproved: json["is_approved"],
        isProduction: json["is_production"],
        isDelivered: json["is_delivered"],
        isVirtual: json["is_virtual"],
        trackingId: json["tracking_id"],
        isDraft: json["is_draft"],
        draftViewPage: json["draft_view_page"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        caseName: json["case_name"],
      );

  Map<String, dynamic> toJson() => {
        "patient_id": patientId,
        "patient_unique_id": patientUniqueId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "patient_profile": patientProfile,
        "bond_date":
            "${bondDate!.year.toString().padLeft(4, '0')}-${bondDate!.month.toString().padLeft(2, '0')}-${bondDate!.day.toString().padLeft(2, '0')}",
        "patient_3d_modal_link": patient3DModalLink,
        "link_password": linkPassword,
        "add_plan_count": addPlanCount,
        "clinic_item": clinicItem,
        "admin_item": adminItem,
        "tooth_case_id": toothCaseId,
        "doctor_id": doctorId,
        "clinic_id": clinicId,
        "clinic_location_id": clinicLocationId,
        "clinic_billing_id": clinicBillingId,
        "technician_id": technicianId,
        "technician_start_date":
            "${technicianStartDate!.year.toString().padLeft(4, '0')}-${technicianStartDate!.month.toString().padLeft(2, '0')}-${technicianStartDate!.day.toString().padLeft(2, '0')}",
        "admin_new_case": adminNewCase,
        "technician_new_case": technicianNewCase,
        "admin_task": adminTask,
        "admin_patient": adminPatient,
        "clinic_task": clinicTask,
        "clinic_patient": clinicPatient,
        "is_approved": isApproved,
        "is_production": isProduction,
        "is_delivered": isDelivered,
        "is_virtual": isVirtual,
        "tracking_id": trackingId,
        "is_draft": isDraft,
        "draft_view_page": draftViewPage,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "case_name": caseName,
      };

*/
}