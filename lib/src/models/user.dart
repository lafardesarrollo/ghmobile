// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.userid,
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.username,
    this.password,
    this.idCargo,
    this.idRegional,
    this.idGrupo,
    this.idSuperior,
    this.idArea,
    this.idSeccion,
    this.foto,
    this.estado,
    this.usuarioCreacion,
    this.fechaCreacion,
    this.usuarioModificacion,
    this.fechaModificacion,
    this.idSuperArea,
    this.idsap,
    this.codigoCargo,
    this.codigoCargoSuperior,
    this.idRegionalSap,
    this.idAreaSap,
    this.cargo,
    this.paginacion,
  });

  int? userid;
  String? firstName;
  String? lastName;
  String? emailAddress;
  String? username;
  String? password;
  int? idCargo;
  int? idRegional;
  int? idGrupo;
  String? idSuperior;
  int? idArea;
  int? idSeccion;
  String? foto;
  int? estado;
  String? usuarioCreacion;
  DateTime? fechaCreacion;
  String? usuarioModificacion;
  DateTime? fechaModificacion;
  int? idSuperArea;
  int? idsap;
  String? codigoCargo;
  String? codigoCargoSuperior;
  int? idRegionalSap;
  int? idAreaSap;
  String? cargo;
  String? paginacion;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userid: json["userid"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        emailAddress: json["email_address"],
        username: json["username"],
        password: json["password"],
        idCargo: json["id_cargo"],
        idRegional: json["id_regional"],
        idGrupo: json["id_grupo"],
        idSuperior: json["id_superior"],
        idArea: json["id_area"],
        idSeccion: json["id_seccion"],
        foto: json["foto"],
        estado: json["estado"],
        usuarioCreacion: json["usuario_creacion"],
        fechaCreacion: DateTime.parse(json["fecha_creacion"]),
        usuarioModificacion: json["usuario_modificacion"],
        fechaModificacion: DateTime.parse(json["fecha_modificacion"]),
        idSuperArea: json["id_super_area"],
        idsap: json["idsap"],
        codigoCargo: json["codigo_cargo"],
        codigoCargoSuperior: json["codigo_cargo_superior"],
        idRegionalSap: json["id_regional_sap"],
        idAreaSap: json["id_area_sap"],
        cargo: json["cargo"],
        paginacion: json["paginacion"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "first_name": firstName,
        "last_name": lastName,
        "email_address": emailAddress,
        "username": username,
        "password": password,
        "id_cargo": idCargo,
        "id_regional": idRegional,
        "id_grupo": idGrupo,
        "id_superior": idSuperior,
        "id_area": idArea,
        "id_seccion": idSeccion,
        "foto": foto,
        "estado": estado,
        "usuario_creacion": usuarioCreacion,
        "fecha_creacion": fechaCreacion,
        "usuario_modificacion": usuarioModificacion,
        "fecha_modificacion": fechaModificacion,
        "id_super_area": idSuperArea,
        "idsap": idsap,
        "codigo_cargo": codigoCargo,
        "codigo_cargo_superior": codigoCargoSuperior,
        "id_regional_sap": idRegionalSap,
        "id_area_sap": idAreaSap,
        "cargo": cargo,
        "paginacion": paginacion,
      };
}
