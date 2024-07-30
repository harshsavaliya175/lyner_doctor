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
}
