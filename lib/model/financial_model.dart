import 'dart:convert';

class FinancialResponseModel {
  final FinancialModel? financialModel;
  final int? status;
  final String? msg;

  FinancialResponseModel({
    this.financialModel,
    this.status,
    this.msg,
  });

  factory FinancialResponseModel.fromRawJson(String str) =>
      FinancialResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FinancialResponseModel.fromJson(Map<String, dynamic> json) =>
      FinancialResponseModel(
        financialModel:
            json["data"] == null ? null : FinancialModel.fromJson(json["data"]),
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "data": financialModel?.toJson(),
        "status": status,
        "msg": msg,
      };
}

class FinancialModel {
  final ClinicBillingAddresses? clinicBillingAddresses;
  final List<PatientList>? patientList;

  FinancialModel({
    this.clinicBillingAddresses,
    this.patientList,
  });

  factory FinancialModel.fromRawJson(String str) =>
      FinancialModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FinancialModel.fromJson(Map<String, dynamic> json) => FinancialModel(
        clinicBillingAddresses: json["clinic_billing_addresses"] == null
            ? null
            : ClinicBillingAddresses.fromJson(json["clinic_billing_addresses"]),
        patientList: json["patient_list"] == null
            ? []
            : List<PatientList>.from(
                json["patient_list"]!.map((x) => PatientList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "clinic_billing_addresses": clinicBillingAddresses?.toJson(),
        "patient_list": patientList == null
            ? []
            : List<dynamic>.from(patientList!.map((x) => x.toJson())),
      };
}

class ClinicBillingAddresses {
  final int? clinicBillingId;
  final int? clinicId;
  final String? billingName;
  final String? billingAddress;
  final String? billingLatitude;
  final String? billingLongitude;
  final String? billingMail;
  final String? billingVat;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ClinicBillingAddresses({
    this.clinicBillingId,
    this.clinicId,
    this.billingName,
    this.billingAddress,
    this.billingLatitude,
    this.billingLongitude,
    this.billingMail,
    this.billingVat,
    this.createdAt,
    this.updatedAt,
  });

  factory ClinicBillingAddresses.fromRawJson(String str) =>
      ClinicBillingAddresses.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClinicBillingAddresses.fromJson(Map<String, dynamic> json) =>
      ClinicBillingAddresses(
        clinicBillingId: json["clinic_billing_id"],
        clinicId: json["clinic_id"],
        billingName: json["billing_name"],
        billingAddress: json["billing_address"],
        billingLatitude: json["billing_latitude"],
        billingLongitude: json["billing_longitude"],
        billingMail: json["billing_mail"],
        billingVat: json["billing_vat"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "clinic_billing_id": clinicBillingId,
        "clinic_id": clinicId,
        "billing_name": billingName,
        "billing_address": billingAddress,
        "billing_latitude": billingLatitude,
        "billing_longitude": billingLongitude,
        "billing_mail": billingMail,
        "billing_vat": billingVat,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class PatientList {
  final int? patientId;
  final String? patientUniqueId;
  final String? firstName;
  final String? lastName;
  final dynamic email;
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
  final int? adminArchive;
  final int? isDraft;
  final dynamic draftViewPage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? caseName;

  PatientList({
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
    this.adminArchive,
    this.isDraft,
    this.draftViewPage,
    this.createdAt,
    this.updatedAt,
    this.caseName,
  });

  factory PatientList.fromRawJson(String str) =>
      PatientList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PatientList.fromJson(Map<String, dynamic> json) => PatientList(
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
        adminArchive: json["admin_archive"],
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
        "admin_archive": adminArchive,
        "is_draft": isDraft,
        "draft_view_page": draftViewPage,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "case_name": caseName,
      };
}
