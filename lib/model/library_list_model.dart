// To parse this JSON data, do
//
//     final libraryListModel = libraryListModelFromJson(jsonString);

import 'dart:convert';

import 'package:lynerdoctor/core/utils/extension.dart';

LibraryListModel libraryListModelFromJson(String str) =>
    LibraryListModel.fromJson(json.decode(str));

String libraryListModelToJson(LibraryListModel data) =>
    json.encode(data.toJson());

class LibraryListModel {
  List<LibraryListData>? data;
  bool? status;
  String? msg;

  LibraryListModel({
    this.data,
    this.status,
    this.msg,
  });

  factory LibraryListModel.fromJson(Map<String, dynamic> json) =>
      LibraryListModel(
        data: json["data"] == null
            ? []
            : List<LibraryListData>.from(
                json["data"]!.map((x) => LibraryListData.fromJson(x))),
        status: json["status"],
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

class LibraryListData {
  int? libraryId;
  String? title;
  String? youtubeLink;
  String? file;
  int? isYoutube;
  int? isDelete;
  DateTime? createdAt;
  DateTime? updatedAt;

  LibraryListData({
    this.libraryId,
    this.title,
    this.youtubeLink,
    this.file,
    this.isYoutube,
    this.isDelete,
    this.createdAt,
    this.updatedAt,
  });

  factory LibraryListData.fromJson(Map<String, dynamic> json) =>
      LibraryListData(
        libraryId: json["library_id"],
        title: json["title"],
        youtubeLink: json["youtube_link"],
        file: json["file"],
        isYoutube: json["is_youtube"],
        isDelete: json["is_delete"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(convertUtcToLocal(json["created_at"])).toLocal(),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(convertUtcToLocal(json["updated_at"])).toLocal(),
      );

  Map<String, dynamic> toJson() => {
        "library_id": libraryId,
        "title": title,
        "youtube_link": youtubeLink,
        "file": file,
        "is_youtube": isYoutube,
        "is_delete": isDelete,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
