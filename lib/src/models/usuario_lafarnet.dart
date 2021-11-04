// To parse this JSON data, do
//
//     final usuarioLafarnet = usuarioLafarnetFromJson(jsonString);

import 'dart:convert';

UsuarioLafarnet usuarioLafarnetFromJson(String str) =>
    UsuarioLafarnet.fromJson(json.decode(str));

String usuarioLafarnetToJson(UsuarioLafarnet data) =>
    json.encode(data.toJson());

class UsuarioLafarnet {
  UsuarioLafarnet({
    this.userid,
    this.firstName,
    this.lastName,
    this.username,
    this.emailAddress,
    this.nombreCompleto,
  });

  int? userid;
  String? firstName;
  String? lastName;
  String? username;
  String? emailAddress;
  String? nombreCompleto;

  factory UsuarioLafarnet.fromJson(Map<String, dynamic> json) =>
      UsuarioLafarnet(
        userid: json["userid"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        emailAddress: json["email_address"],
        nombreCompleto: json["nombre_completo"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "email_address": emailAddress,
        "nombre_completo": nombreCompleto,
      };
}
