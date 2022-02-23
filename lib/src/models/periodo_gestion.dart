// To parse this JSON data, do
//
//     final periodoGestion = periodoGestionFromJson(jsonString);

import 'dart:convert';

PeriodoGestion periodoGestionFromJson(String str) =>
    PeriodoGestion.fromJson(json.decode(str));

String periodoGestionToJson(PeriodoGestion data) => json.encode(data.toJson());

class PeriodoGestion {
  PeriodoGestion({
    this.idPeriodo,
    this.mes,
    this.nombreMes,
    this.anhio,
    this.fechaInicio,
    this.fechaFin,
  });

  int? idPeriodo;
  int? mes;
  String? nombreMes;
  int? anhio;
  DateTime? fechaInicio;
  DateTime? fechaFin;

  factory PeriodoGestion.fromJson(Map<String, dynamic> json) => PeriodoGestion(
        idPeriodo: json["idPeriodo"],
        mes: json["mes"],
        nombreMes: json["nombreMes"],
        anhio: json["anhio"],
        fechaInicio: DateTime.parse(json["fechaInicio"]),
        fechaFin: DateTime.parse(json["fechaFin"]),
      );

  Map<String, dynamic> toJson() => {
        "idPeriodo": idPeriodo,
        "mes": mes,
        "nombreMes": nombreMes,
        "anhio": anhio,
        "fechaInicio": fechaInicio,
        "fechaFin": fechaFin,
      };
}
