import 'dart:convert';

RefinementModel refinementModelFromJson(String str) =>
    RefinementModel.fromJson(json.decode(str));

String refinementModelToJson(RefinementModel data) =>
    json.encode(data.toJson());

class RefinementModel {
  RefinementData data;
  int status;
  String msg;

  RefinementModel({
    required this.data,
    required this.status,
    required this.msg,
  });

  factory RefinementModel.fromJson(Map<String, dynamic> json) =>
      RefinementModel(
        data: RefinementData.fromJson(json["data"]),
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "msg": msg,
      };
}

class RefinementData {
  int patientRefinementId;
  int patientId;
  dynamic refinementNumber;
  String profile;
  dynamic face;
  dynamic smile;
  dynamic intraMax;
  dynamic intraMand;
  dynamic interRight;
  dynamic interFace;
  dynamic interLeft;
  dynamic panRadio;
  dynamic cephalRadio;
  dynamic dicomFileName;
  dynamic upperJawStlFile;
  dynamic lowerJawStlFile;
  int is3Shape;
  String arcadeOption;
  String arcadeComment;
  int isDraft;
  DateTime createdAt;
  DateTime updatedAt;

  RefinementData({
    required this.patientRefinementId,
    required this.patientId,
    required this.refinementNumber,
    required this.profile,
    required this.face,
    required this.smile,
    required this.intraMax,
    required this.intraMand,
    required this.interRight,
    required this.interFace,
    required this.interLeft,
    required this.panRadio,
    required this.cephalRadio,
    required this.dicomFileName,
    required this.upperJawStlFile,
    required this.lowerJawStlFile,
    required this.is3Shape,
    required this.arcadeOption,
    required this.arcadeComment,
    required this.isDraft,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RefinementData.fromJson(Map<String, dynamic> json) => RefinementData(
        patientRefinementId: json["patient_refinement_id"],
        patientId: json["patient_id"],
        refinementNumber: json["refinement_number"],
        profile: json["profile"],
        face: json["face"],
        smile: json["smile"],
        intraMax: json["intra_max"],
        intraMand: json["intra_mand"],
        interRight: json["inter_right"],
        interFace: json["inter_face"],
        interLeft: json["inter_left"],
        panRadio: json["pan_radio"],
        cephalRadio: json["cephal_radio"],
        dicomFileName: json["dicom_file_name"],
        upperJawStlFile: json["upper_jaw_stl_file"],
        lowerJawStlFile: json["lower_jaw_stl_file"],
        is3Shape: json["is_3shape"],
        arcadeOption: json["arcade_option"],
        arcadeComment: json["arcade_comment"],
        isDraft: json["is_draft"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "patient_refinement_id": patientRefinementId,
        "patient_id": patientId,
        "refinement_number": refinementNumber,
        "profile": profile,
        "face": face,
        "smile": smile,
        "intra_max": intraMax,
        "intra_mand": intraMand,
        "inter_right": interRight,
        "inter_face": interFace,
        "inter_left": interLeft,
        "pan_radio": panRadio,
        "cephal_radio": cephalRadio,
        "dicom_file_name": dicomFileName,
        "upper_jaw_stl_file": upperJawStlFile,
        "lower_jaw_stl_file": lowerJawStlFile,
        "is_3shape": is3Shape,
        "arcade_option": arcadeOption,
        "arcade_comment": arcadeComment,
        "is_draft": isDraft,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
