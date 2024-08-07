import 'dart:convert';

class CommentsResponseModel {
  final List<CommentModel>? commentModel;
  final int? status;
  final String? msg;

  CommentsResponseModel({
    this.commentModel,
    this.status,
    this.msg,
  });

  CommentsResponseModel copyWith({
    List<CommentModel>? data,
    int? status,
    String? msg,
  }) =>
      CommentsResponseModel(
        commentModel: data ?? this.commentModel,
        status: status ?? this.status,
        msg: msg ?? this.msg,
      );

  factory CommentsResponseModel.fromRawJson(String str) =>
      CommentsResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentsResponseModel.fromJson(Map<String, dynamic> json) =>
      CommentsResponseModel(
        commentModel: json["data"] == null
            ? []
            : List<CommentModel>.from(
                json["data"]!.map((x) => CommentModel.fromJson(x))),
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "data": commentModel == null
            ? []
            : List<dynamic>.from(commentModel!.map((x) => x.toJson())),
        "status": status,
        "msg": msg,
      };
}

class CommentModel {
  final int? patientItemId;
  final int? patientId;
  final String? item;
  final String? comment;
  final String? fileName;
  final String? fileType;
  final String? extension;
  final int? isDownload;
  final int? sentByClinic;
  final int? sentByLyner;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CommentModel({
    this.patientItemId,
    this.patientId,
    this.item,
    this.comment,
    this.fileName,
    this.fileType,
    this.extension,
    this.isDownload,
    this.sentByClinic,
    this.sentByLyner,
    this.createdAt,
    this.updatedAt,
  });

  CommentModel copyWith({
    int? patientItemId,
    int? patientId,
    String? item,
    String? comment,
    String? fileName,
    String? fileType,
    String? extension,
    int? isDownload,
    int? sentByClinic,
    int? sentByLyner,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      CommentModel(
        patientItemId: patientItemId ?? this.patientItemId,
        patientId: patientId ?? this.patientId,
        item: item ?? this.item,
        comment: comment ?? this.comment,
        fileName: fileName ?? this.fileName,
        fileType: fileType ?? this.fileType,
        extension: extension ?? this.extension,
        isDownload: isDownload ?? this.isDownload,
        sentByClinic: sentByClinic ?? this.sentByClinic,
        sentByLyner: sentByLyner ?? this.sentByLyner,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory CommentModel.fromRawJson(String str) =>
      CommentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        patientItemId: json["patient_item_id"],
        patientId: json["patient_id"],
        item: json["item"],
        comment: json["comment"],
        fileName: json["file_name"],
        fileType: json["file_type"],
        extension: json["extension"],
        isDownload: json["is_download"],
        sentByClinic: json["sent_by_clinic"],
        sentByLyner: json["sent_by_lyner"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "patient_item_id": patientItemId,
        "patient_id": patientId,
        "item": item,
        "comment": comment,
        "file_name": fileName,
        "file_type": fileType,
        "extension": extension,
        "is_download": isDownload,
        "sent_by_clinic": sentByClinic,
        "sent_by_lyner": sentByLyner,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
