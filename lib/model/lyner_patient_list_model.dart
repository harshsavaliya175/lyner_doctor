// To parse this JSON data, do
//
//     final lynerConnectPatientListModel = lynerConnectPatientListModelFromJson(jsonString);

import 'dart:convert';

import 'package:lynerdoctor/core/utils/extension.dart';

LynerConnectPatientListModel lynerConnectPatientListModelFromJson(String str) =>
    LynerConnectPatientListModel.fromJson(json.decode(str));

String lynerConnectPatientListModelToJson(LynerConnectPatientListModel data) =>
    json.encode(data.toJson());

class LynerConnectPatientListModel {
  List<LynerPatientListData>? data;
  bool? status;
  String? msg;

  LynerConnectPatientListModel({
    this.data,
    this.status,
    this.msg,
  });

  factory LynerConnectPatientListModel.fromJson(Map<String, dynamic> json) =>
      LynerConnectPatientListModel(
        data: json["data"] == null
            ? []
            : List<LynerPatientListData>.from(
                json["data"]!.map((x) => LynerPatientListData.fromJson(x))),
        status: json["status"] == 1,
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
        "msg": msg,
      };
}

class LynerPatientListData {
  int? patientId;
  String? patientUniqueId;
  String? firstName;
  String? lastName;
  dynamic email;
  DateTime? dateOfBirth;
  String? patientProfile;
  DateTime? bondDate;
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
  int? technicianId;
  DateTime? technicianStartDate;
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
  dynamic draftViewPage;
  DateTime? createdAt;
  DateTime? updatedAt;

  LynerPatientListData({
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
  });

  factory LynerPatientListData.fromJson(Map<String, dynamic> json) =>
      LynerPatientListData(
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
            : DateTime.parse(convertUtcToLocal(json["created_at"])).toLocal(),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(convertUtcToLocal(json["updated_at"])).toLocal(),
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
      };
}
