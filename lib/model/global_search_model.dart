import 'dart:convert';

import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/model/lyner_connect_list_model.dart';

class GlobalSearchModel {
  final List<Archive>? patientTask;
  final List<Archive>? patient;
  final List<Archive>? archive;
  final List<LynerConnectList>? lynerConnect;

  GlobalSearchModel({
    this.patientTask,
    this.patient,
    this.archive,
    this.lynerConnect,
  });

  factory GlobalSearchModel.fromRawJson(String str) =>
      GlobalSearchModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GlobalSearchModel.fromJson(Map<String, dynamic> json) =>
      GlobalSearchModel(
        patientTask: json["patient_task"] == null
            ? []
            : List<Archive>.from(
                json["patient_task"]!.map((x) => Archive.fromJson(x))),
        patient: json["patient"] == null
            ? []
            : List<Archive>.from(
                json["patient"]!.map((x) => Archive.fromJson(x))),
        archive: json["archive"] == null
            ? []
            : List<Archive>.from(
                json["archive"]!.map((x) => Archive.fromJson(x))),
        lynerConnect: json["lyner_connect"] == null
            ? []
            : List<LynerConnectList>.from(json["lyner_connect"]!
                .map((x) => LynerConnectList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "patient_task": patientTask == null
            ? []
            : List<dynamic>.from(patientTask!.map((x) => x.toJson())),
        "patient": patient == null
            ? []
            : List<dynamic>.from(patient!.map((x) => x.toJson())),
        "archive": archive == null
            ? []
            : List<dynamic>.from(archive!.map((x) => x.toJson())),
        "lyner_connect": lynerConnect == null
            ? []
            : List<dynamic>.from(lynerConnect!.map((x) => x.toJson())),
      };
}

class Archive {
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
  final dynamic noteLink;
  final int? isDeleted;
  final int? adminArchive;
  final int? isDraft;
  final String? draftViewPage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? caseName;

  Archive({
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
    this.noteLink,
    this.isDeleted,
    this.adminArchive,
    this.isDraft,
    this.draftViewPage,
    this.createdAt,
    this.updatedAt,
    this.caseName,
  });

  factory Archive.fromRawJson(String str) => Archive.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Archive.fromJson(Map<String, dynamic> json) => Archive(
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
            : DateTime.parse(json["technician_start_date"]).toLocal(),
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
        noteLink: json["note_link"],
        isDeleted: json["is_deleted"],
        adminArchive: json["admin_archive"],
        isDraft: json["is_draft"],
        draftViewPage: json["draft_view_page"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(convertUtcToLocal(json["created_at"])).toLocal(),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(convertUtcToLocal(json["updated_at"])).toLocal(),
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
        "note_link": noteLink,
        "is_deleted": isDeleted,
        "admin_archive": adminArchive,
        "is_draft": isDraft,
        "draft_view_page": draftViewPage,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "case_name": caseName,
      };
}

// class LynerConnect {
//   final int? userId;
//   final int? doctorId;
//   final int? patientId;
//   final int? clinicId;
//   final String? userToken;
//   final String? doctorUniqId;
//   final String? firstName;
//   final String? lastName;
//   final String? email;
//   final String? userProfilePhoto;
//   final String? phoneNo;
//   final DateTime? emailVerifiedAt;
//   final String? referenceCode;
//   final int? alignerStage;
//   final int? currentAlignerStage;
//   final int? alignerDay;
//   final DateTime? treatmentStartDate;
//   final String? authToken;
//   final String? devicePushToken;
//   final String? deviceType;
//   final String? verifyForgotCode;
//   final String? timeZone;
//   final int? isLoggedOut;
//   final int? isBlock;
//   final int? isDeleted;
//   final String? caseName;
//
//   LynerConnect({
//     this.userId,
//     this.doctorId,
//     this.patientId,
//     this.clinicId,
//     this.userToken,
//     this.doctorUniqId,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.userProfilePhoto,
//     this.phoneNo,
//     this.emailVerifiedAt,
//     this.referenceCode,
//     this.alignerStage,
//     this.currentAlignerStage,
//     this.alignerDay,
//     this.treatmentStartDate,
//     this.authToken,
//     this.devicePushToken,
//     this.deviceType,
//     this.verifyForgotCode,
//     this.timeZone,
//     this.isLoggedOut,
//     this.isBlock,
//     this.isDeleted,
//     this.caseName,
//   });
//
//   factory LynerConnect.fromRawJson(String str) =>
//       LynerConnect.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory LynerConnect.fromJson(Map<String, dynamic> json) => LynerConnect(
//         userId: json["user_id"],
//         doctorId: json["doctor_id"],
//         patientId: json["patient_id"],
//         clinicId: json["clinic_id"],
//         userToken: json["user_token"],
//         doctorUniqId: json["doctor_uniq_id"],
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         email: json["email"],
//         userProfilePhoto: json["user_profile_photo"],
//         phoneNo: json["phone_no"],
//         emailVerifiedAt: json["email_verified_at"] == null
//             ? null
//             : DateTime.parse(json["email_verified_at"]),
//         referenceCode: json["reference_code"],
//         alignerStage: json["aligner_stage"],
//         currentAlignerStage: json["current_aligner_stage"],
//         alignerDay: json["aligner_day"],
//         treatmentStartDate: json["treatment_start_date"] == null
//             ? null
//             : DateTime.parse(json["treatment_start_date"]),
//         authToken: json["auth_token"],
//         devicePushToken: json["device_push_token"],
//         deviceType: json["device_type"],
//         verifyForgotCode: json["verify_forgot_code"],
//         timeZone: json["time_zone"],
//         isLoggedOut: json["is_logged_out"],
//         isBlock: json["is_block"],
//         isDeleted: json["is_deleted"],
//         caseName: json["case_name"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "user_id": userId,
//         "doctor_id": doctorId,
//         "patient_id": patientId,
//         "clinic_id": clinicId,
//         "user_token": userToken,
//         "doctor_uniq_id": doctorUniqId,
//         "first_name": firstName,
//         "last_name": lastName,
//         "email": email,
//         "user_profile_photo": userProfilePhoto,
//         "phone_no": phoneNo,
//         "email_verified_at": emailVerifiedAt?.toIso8601String(),
//         "reference_code": referenceCode,
//         "aligner_stage": alignerStage,
//         "current_aligner_stage": currentAlignerStage,
//         "aligner_day": alignerDay,
//         "treatment_start_date": treatmentStartDate?.toIso8601String(),
//         "auth_token": authToken,
//         "device_push_token": devicePushToken,
//         "device_type": deviceType,
//         "verify_forgot_code": verifyForgotCode,
//         "time_zone": timeZone,
//         "is_logged_out": isLoggedOut,
//         "is_block": isBlock,
//         "is_deleted": isDeleted,
//         "case_name": caseName,
//       };
// }
