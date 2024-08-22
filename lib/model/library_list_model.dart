// To parse this JSON data, do
//
//     final libraryListModel = libraryListModelFromJson(jsonString);

import 'dart:convert';

LibraryListModel libraryListModelFromJson(String str) => LibraryListModel.fromJson(json.decode(str));

String libraryListModelToJson(LibraryListModel data) => json.encode(data.toJson());

class LibraryListModel {
  List<LibraryListData>? data;
  bool? status;
  String? msg;

  LibraryListModel({
    this.data,
    this.status,
    this.msg,
  });

  factory LibraryListModel.fromJson(Map<String, dynamic> json) => LibraryListModel(
    data: json["data"] == null ? [] : List<LibraryListData>.from(json["data"]!.map((x) => LibraryListData.fromJson(x))),
    status: json["status"]==1,
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "status": status,
    "msg": msg,
  };
}

class LibraryListData {
  int? libraryId;
  int? clinicId;
  String? libraryName;
  String? libraryUrl;
  String? type;

  LibraryListData({
    this.libraryId,
    this.clinicId,
    this.libraryName,
    this.libraryUrl,
    this.type,
  });

  factory LibraryListData.fromJson(Map<String, dynamic> json) => LibraryListData(
    libraryId: json["library_id"],
    clinicId: json["clinic_id"],
    libraryName: json["library_name"],
    libraryUrl: json["library_url"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "library_id": libraryId,
    "clinic_id": clinicId,
    "library_name": libraryName,
    "library_url": libraryUrl,
    "type": type,
  };
}
