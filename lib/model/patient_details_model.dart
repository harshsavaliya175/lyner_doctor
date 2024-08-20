import 'dart:convert';

class PatientDetailsResponseModel {
  final PatientDetailsModel? patientDetailsModel;
  final int? status;
  final String? msg;

  PatientDetailsResponseModel({
    this.patientDetailsModel,
    this.status,
    this.msg,
  });

  PatientDetailsResponseModel copyWith({
    PatientDetailsModel? patientDetailsModel,
    int? status,
    String? msg,
  }) =>
      PatientDetailsResponseModel(
        patientDetailsModel: patientDetailsModel ?? this.patientDetailsModel,
        status: status ?? this.status,
        msg: msg ?? this.msg,
      );

  factory PatientDetailsResponseModel.fromRawJson(String str) =>
      PatientDetailsResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PatientDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      PatientDetailsResponseModel(
        patientDetailsModel: json["data"] == null
            ? null
            : PatientDetailsModel.fromJson(json["data"]),
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "data": patientDetailsModel?.toJson(),
        "status": status,
        "msg": msg,
      };
}

class PatientDetailsModel {
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
  final dynamic technicianId;
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
  final dynamic trackingId;
  final int? isDraft;
  final dynamic draftViewPage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Doctor? doctor;
  final PatientPhoto? patientPhoto;
  final ToothCase? toothCase;
  final ClinicBill? clinicBill;
  final ClinicLoc? clinicLoc;

  PatientDetailsModel({
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

  PatientDetailsModel copyWith({
    int? patientId,
    String? patientUniqueId,
    String? firstName,
    String? lastName,
    dynamic email,
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
    dynamic technicianId,
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
    dynamic trackingId,
    int? isDraft,
    dynamic draftViewPage,
    DateTime? createdAt,
    DateTime? updatedAt,
    Doctor? doctor,
    PatientPhoto? patientPhoto,
    ToothCase? toothCase,
    ClinicBill? clinicBill,
    ClinicLoc? clinicLoc,
  }) =>
      PatientDetailsModel(
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
        doctor: doctor ?? this.doctor,
        patientPhoto: patientPhoto ?? this.patientPhoto,
        toothCase: toothCase ?? this.toothCase,
        clinicBill: clinicBill ?? this.clinicBill,
        clinicLoc: clinicLoc ?? this.clinicLoc,
      );

  factory PatientDetailsModel.fromRawJson(String str) =>
      PatientDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PatientDetailsModel.fromJson(Map<String, dynamic> json) =>
      PatientDetailsModel(
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
        doctor: json["doctor"] == null ? null : Doctor.fromJson(json["doctor"]),
        patientPhoto: json["patient_photo"] == null
            ? null
            : PatientPhoto.fromJson(json["patient_photo"]),
        toothCase: json["tooth_case"] == null
            ? null
            : ToothCase.fromJson(json["tooth_case"]),
        clinicBill: json["clinic_bill"] == null
            ? null
            : ClinicBill.fromJson(json["clinic_bill"]),
        clinicLoc: json["clinic_loc"] == null
            ? null
            : ClinicLoc.fromJson(json["clinic_loc"]),
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

  ClinicBill({
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

  ClinicBill copyWith({
    int? clinicBillingId,
    int? clinicId,
    String? billingName,
    String? billingAddress,
    String? billingLatitude,
    String? billingLongitude,
    String? billingMail,
    String? billingVat,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ClinicBill(
        clinicBillingId: clinicBillingId ?? this.clinicBillingId,
        clinicId: clinicId ?? this.clinicId,
        billingName: billingName ?? this.billingName,
        billingAddress: billingAddress ?? this.billingAddress,
        billingLatitude: billingLatitude ?? this.billingLatitude,
        billingLongitude: billingLongitude ?? this.billingLongitude,
        billingMail: billingMail ?? this.billingMail,
        billingVat: billingVat ?? this.billingVat,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ClinicBill.fromRawJson(String str) =>
      ClinicBill.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClinicBill.fromJson(Map<String, dynamic> json) => ClinicBill(
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

class ClinicLoc {
  final int? clinicLocationId;
  final int? clinicId;
  final String? contactName;
  final String? contactNumber;
  final String? address;
  final String? latitude;
  final String? longitude;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ClinicLoc({
    this.clinicLocationId,
    this.clinicId,
    this.contactName,
    this.contactNumber,
    this.address,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  ClinicLoc copyWith({
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
      ClinicLoc(
        clinicLocationId: clinicLocationId ?? this.clinicLocationId,
        clinicId: clinicId ?? this.clinicId,
        contactName: contactName ?? this.contactName,
        contactNumber: contactNumber ?? this.contactNumber,
        address: address ?? this.address,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ClinicLoc.fromRawJson(String str) =>
      ClinicLoc.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClinicLoc.fromJson(Map<String, dynamic> json) => ClinicLoc(
        clinicLocationId: json["clinic_location_id"],
        clinicId: json["clinic_id"],
        contactName: json["contact_name"],
        contactNumber: json["contact_number"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "clinic_location_id": clinicLocationId,
        "clinic_id": clinicId,
        "contact_name": contactName,
        "contact_number": contactNumber,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Doctor {
  final int? doctorId;
  final String? doctorUniqueId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobileNumber;
  final String? doctorProfile;
  final dynamic country;
  final String? language;
  final int? clinicId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

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
    this.createdAt,
    this.updatedAt,
  });

  Doctor copyWith({
    int? doctorId,
    String? doctorUniqueId,
    String? firstName,
    String? lastName,
    String? email,
    String? mobileNumber,
    String? doctorProfile,
    dynamic country,
    String? language,
    int? clinicId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Doctor(
        doctorId: doctorId ?? this.doctorId,
        doctorUniqueId: doctorUniqueId ?? this.doctorUniqueId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        doctorProfile: doctorProfile ?? this.doctorProfile,
        country: country ?? this.country,
        language: language ?? this.language,
        clinicId: clinicId ?? this.clinicId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Doctor.fromRawJson(String str) => Doctor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class PatientPhoto {
  final int? patientPhotoId;
  final int? patientId;
  final String? gauche;
  final String? face;
  final String? sourire;
  final String? interGauche;
  final String? interFace;
  final String? interDroite;
  final String? interMax;
  final String? interMandi;
  final dynamic paramiqueRadio;
  final dynamic cephalRadio;
  final String? dcomFileName;
  final int? is3Shape;
  final dynamic upperJawStlFile;
  final dynamic lowerJawStlFile;
  final String? droite;
  final String? maxScan;
  final String? mandiScan;
  final String? stlFileLink;
  final DateTime? createdAt;
  final DateTime? updatedAt;

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

  PatientPhoto copyWith({
    int? patientPhotoId,
    int? patientId,
    String? gauche,
    String? face,
    String? sourire,
    String? interGauche,
    String? interFace,
    String? interDroite,
    String? interMax,
    String? interMandi,
    dynamic paramiqueRadio,
    dynamic cephalRadio,
    String? dcomFileName,
    int? is3Shape,
    dynamic upperJawStlFile,
    dynamic lowerJawStlFile,
    String? droite,
    String? maxScan,
    String? mandiScan,
    String? stlFileLink,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      PatientPhoto(
        patientPhotoId: patientPhotoId ?? this.patientPhotoId,
        patientId: patientId ?? this.patientId,
        gauche: gauche ?? this.gauche,
        face: face ?? this.face,
        sourire: sourire ?? this.sourire,
        interGauche: interGauche ?? this.interGauche,
        interFace: interFace ?? this.interFace,
        interDroite: interDroite ?? this.interDroite,
        interMax: interMax ?? this.interMax,
        interMandi: interMandi ?? this.interMandi,
        paramiqueRadio: paramiqueRadio ?? this.paramiqueRadio,
        cephalRadio: cephalRadio ?? this.cephalRadio,
        dcomFileName: dcomFileName ?? this.dcomFileName,
        is3Shape: is3Shape ?? this.is3Shape,
        upperJawStlFile: upperJawStlFile ?? this.upperJawStlFile,
        lowerJawStlFile: lowerJawStlFile ?? this.lowerJawStlFile,
        droite: droite ?? this.droite,
        maxScan: maxScan ?? this.maxScan,
        mandiScan: mandiScan ?? this.mandiScan,
        stlFileLink: stlFileLink ?? this.stlFileLink,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory PatientPhoto.fromRawJson(String str) =>
      PatientPhoto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
  final int? toothCaseId;
  final String? caseName;
  final String? casePrice;
  final String? caseDesc;
  final String? caseSteps;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ToothCase({
    this.toothCaseId,
    this.caseName,
    this.casePrice,
    this.caseDesc,
    this.caseSteps,
    this.createdAt,
    this.updatedAt,
  });

  ToothCase copyWith({
    int? toothCaseId,
    String? caseName,
    String? casePrice,
    String? caseDesc,
    String? caseSteps,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ToothCase(
        toothCaseId: toothCaseId ?? this.toothCaseId,
        caseName: caseName ?? this.caseName,
        casePrice: casePrice ?? this.casePrice,
        caseDesc: caseDesc ?? this.caseDesc,
        caseSteps: caseSteps ?? this.caseSteps,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ToothCase.fromRawJson(String str) =>
      ToothCase.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ToothCase.fromJson(Map<String, dynamic> json) => ToothCase(
        toothCaseId: json["tooth_case_id"],
        caseName: json["case_name"],
        casePrice: json["case_price"],
        caseDesc: json["case_desc"],
        caseSteps: json["case_steps"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
