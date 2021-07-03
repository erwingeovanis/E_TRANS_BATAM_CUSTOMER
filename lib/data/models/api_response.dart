// To parse this JSON data, do
//
//     final apiResponse = apiResponseFromJson(jsonString);

import 'dart:convert';

ApiResponse apiResponseFromJson(String str) =>
    ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse {
  ApiResponse({
    this.data,
    this.message,
    this.result,
  });

  Data? data;
  String? message;
  bool? result;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "message": message,
        "result": result,
      };
}

class Data {
  Data({
    this.email,
    this.uid,
    this.code,
  });

  String? email;
  int? uid;
  String? code;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["email"],
        code: json["code"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "uid": uid,
        "code": code,
      };
}
