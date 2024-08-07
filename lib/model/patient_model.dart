// To parse this JSON data, do
//
//     final patientModel = patientModelFromJson(jsonString);

import 'dart:convert';

PatientModel patientModelFromJson(String str) => PatientModel.fromJson(json.decode(str));

String patientModelToJson(PatientModel data) => json.encode(data.toJson());

class PatientModel {
  PatientData? data;
  bool? status;
  String? msg;

  PatientModel({
    this.data,
    this.status,
    this.msg,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
    data: json["data"] == null ? null : PatientData.fromJson(json["data"]),
    status: json["status"]==1,
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
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
  DateTime? createdAt;
  DateTime? updatedAt;
  Doctor? doctor;
  PatientPhoto? patientPhoto;
  ToothCase? toothCase;
  ClinicBill? clinicBill;
  ClinicLoc? clinicLoc;

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
    this.doctor,
    this.patientPhoto,
    this.toothCase,
    this.clinicBill,
    this.clinicLoc,
  });

  factory PatientData.fromJson(Map<String, dynamic> json) => PatientData(
    patientId: json["patient_id"],
    patientUniqueId: json["patient_unique_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    patientProfile: json["patient_profile"],
    bondDate: json["bond_date"] == null ? null : DateTime.parse(json["bond_date"]),
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
    technicianStartDate: json["technician_start_date"],
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
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    doctor: json["doctor"] == null ? null : Doctor.fromJson(json["doctor"]),
    patientPhoto: json["patient_photo"] == null ? null : PatientPhoto.fromJson(json["patient_photo"]),
    toothCase: json["tooth_case"] == null ? null : ToothCase.fromJson(json["tooth_case"]),
    clinicBill: json["clinic_bill"] == null ? null : ClinicBill.fromJson(json["clinic_bill"]),
    clinicLoc: json["clinic_loc"] == null ? null : ClinicLoc.fromJson(json["clinic_loc"]),
  );

  Map<String, dynamic> toJson() => {
    "patient_id": patientId,
    "patient_unique_id": patientUniqueId,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
    "patient_profile": patientProfile,
    "bond_date": "${bondDate!.year.toString().padLeft(4, '0')}-${bondDate!.month.toString().padLeft(2, '0')}-${bondDate!.day.toString().padLeft(2, '0')}",
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
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "doctor": doctor?.toJson(),
    "patient_photo": patientPhoto?.toJson(),
    "tooth_case": toothCase?.toJson(),
    "clinic_bill": clinicBill?.toJson(),
    "clinic_loc": clinicLoc?.toJson(),
  };
}

class ClinicBill {
  int? clinicBillingId;
  int? clinicId;
  String? billingName;
  String? billingAddress;
  String? billingLatitude;
  String? billingLongitude;
  String? billingMail;
  String? billingVat;


  ClinicBill({
    this.clinicBillingId,
    this.clinicId,
    this.billingName,
    this.billingAddress,
    this.billingLatitude,
    this.billingLongitude,
    this.billingMail,
    this.billingVat,

  });

  factory ClinicBill.fromJson(Map<String, dynamic> json) => ClinicBill(
    clinicBillingId: json["clinic_billing_id"],
    clinicId: json["clinic_id"],
    billingName: json["billing_name"],
    billingAddress: json["billing_address"],
    billingLatitude: json["billing_latitude"],
    billingLongitude: json["billing_longitude"],
    billingMail: json["billing_mail"],
    billingVat: json["billing_vat"],
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

  };
}

class ClinicLoc {
  int? clinicLocationId;
  int? clinicId;
  String? contactName;
  String? contactNumber;
  String? address;
  String? latitude;
  String? longitude;


  ClinicLoc({
    this.clinicLocationId,
    this.clinicId,
    this.contactName,
    this.contactNumber,
    this.address,
    this.latitude,
    this.longitude,
  });

  factory ClinicLoc.fromJson(Map<String, dynamic> json) => ClinicLoc(
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

class Doctor {
  int? doctorId;
  String? doctorUniqueId;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNumber;
  String? doctorProfile;
  String? country;
  String? language;
  int? clinicId;


  Doctor({
    this.doctorId,
    this.doctorUniqueId,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.doctorProfile,
    this.country,
    this.language,
    this.clinicId,

  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
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

  };
}

class PatientPhoto {
  int? patientPhotoId;
  int? patientId;
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
  int? is3Shape;
  String? upperJawStlFile;
  String? lowerJawStlFile;
  String? droite;
  String? maxScan;
  String? mandiScan;
  String? stlFileLink;
  DateTime? createdAt;
  DateTime? updatedAt;

  PatientPhoto({
    this.patientPhotoId,
    this.patientId,
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
    this.is3Shape,
    this.upperJawStlFile,
    this.lowerJawStlFile,
    this.droite,
    this.maxScan,
    this.mandiScan,
    this.stlFileLink,
    this.createdAt,
    this.updatedAt,
  });

  factory PatientPhoto.fromJson(Map<String, dynamic> json) => PatientPhoto(
    patientPhotoId: json["patient_photo_id"],
    patientId: json["patient_id"],
    gauche: json["gauche"],
    face: json["face"],
    sourire: json["sourire"],
    interGauche: json["inter_gauche"],
    interFace: json["inter_face"],
    interDroite: json["inter_droite"],
    interMax: json["inter_max"],
    interMandi: json["inter_mandi"],
    paramiqueRadio: json["paramique_radio"],
    cephalRadio: json["cephal_radio"],
    dcomFileName: json["dcom_file_name"],
    is3Shape: json["is_3shape"],
    upperJawStlFile: json["upper_jaw_stl_file"],
    lowerJawStlFile: json["lower_jaw_stl_file"],
    droite: json["droite"],
    maxScan: json["max_scan"],
    mandiScan: json["mandi_scan"],
    stlFileLink: json["stl_file_link"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "patient_photo_id": patientPhotoId,
    "patient_id": patientId,
    "gauche": gauche,
    "face": face,
    "sourire": sourire,
    "inter_gauche": interGauche,
    "inter_face": interFace,
    "inter_droite": interDroite,
    "inter_max": interMax,
    "inter_mandi": interMandi,
    "paramique_radio": paramiqueRadio,
    "cephal_radio": cephalRadio,
    "dcom_file_name": dcomFileName,
    "is_3shape": is3Shape,
    "upper_jaw_stl_file": upperJawStlFile,
    "lower_jaw_stl_file": lowerJawStlFile,
    "droite": droite,
    "max_scan": maxScan,
    "mandi_scan": mandiScan,
    "stl_file_link": stlFileLink,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class ToothCase {
  int? toothCaseId;
  String? caseName;
  String? casePrice;
  String? caseDesc;
  String? caseSteps;
  DateTime? createdAt;
  DateTime? updatedAt;

  ToothCase({
    this.toothCaseId,
    this.caseName,
    this.casePrice,
    this.caseDesc,
    this.caseSteps,
    this.createdAt,
    this.updatedAt,
  });

  factory ToothCase.fromJson(Map<String, dynamic> json) => ToothCase(
    toothCaseId: json["tooth_case_id"],
    caseName: json["case_name"],
    casePrice: json["case_price"],
    caseDesc: json["case_desc"],
    caseSteps: json["case_steps"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "tooth_case_id": toothCaseId,
    "case_name": caseName,
    "case_price": casePrice,
    "case_desc": caseDesc,
    "case_steps": caseSteps,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
