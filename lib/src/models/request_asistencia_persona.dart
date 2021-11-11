// To parse this JSON data, do
//
//     final requestAsistenciaPersona = requestAsistenciaPersonaFromJson(jsonString);

import 'dart:convert';

RequestAsistenciaPersona requestAsistenciaPersonaFromJson(String str) =>
    RequestAsistenciaPersona.fromJson(json.decode(str));

String requestAsistenciaPersonaToJson(RequestAsistenciaPersona data) =>
    json.encode(data.toJson());

class RequestAsistenciaPersona {
  RequestAsistenciaPersona({
    this.fechaInicio,
    this.fechaFin,
    this.empleado,
  });

  String? fechaInicio;
  String? fechaFin;
  int? empleado;

  factory RequestAsistenciaPersona.fromJson(Map<String, dynamic> json) =>
      RequestAsistenciaPersona(
        fechaInicio: json["fechaInicio"],
        fechaFin: json["fechaFin"],
        empleado: json["empleado"],
      );

  Map<String, dynamic> toJson() => {
        "fechaInicio": fechaInicio,
        "fechaFin": fechaFin,
        "empleado": empleado,
      };
}
