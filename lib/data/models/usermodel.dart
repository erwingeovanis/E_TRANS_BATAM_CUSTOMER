// To parse this JSON data, do
//
//     final usermodel = usermodelFromJson(jsonString);

import 'dart:convert';

Usermodel usermodelFromJson(String str) => Usermodel.fromJson(json.decode(str));

String usermodelToJson(Usermodel data) => json.encode(data.toJson());

class Usermodel {
  Usermodel({
    this.idUser,
    this.name,
    this.email,
    this.password,
    nohp,
  });

  String? idUser;
  String? name;
  String? email;
  String? password;

  factory Usermodel.fromJson(Map<String, dynamic> json) => Usermodel(
        idUser: json["id_user"].toString(),
        name: json["name"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "name": name,
        "email": email,
        "password": password,
      };
}
