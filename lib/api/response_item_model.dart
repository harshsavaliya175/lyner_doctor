import 'dart:convert';

ResponseItem responseItemFromJson(String str) =>
    ResponseItem.fromJson(json.decode(str));

String responseItemToJson(ResponseItem data) => json.encode(data.toJson());

class ResponseItem {
  ResponseItem({
    this.data,
    required this.msg,
    required this.status,
    this.forceLogout = false,
    this.refreshToken,
  });

  dynamic data;
  String msg;
  String? refreshToken;
  bool status;

  final bool forceLogout;

  factory ResponseItem.fromJson(Map<String, dynamic> json) => ResponseItem(
        data: json["data"],
        msg: json["msg"],
        status: json["status"] == 1,
        forceLogout: json["force_logout"] == 1,
        refreshToken: json["new_token"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "msg": msg,
        "status": status,
        "force_logout": forceLogout,
        "new_token": refreshToken,
      };
}
