// To parse this JSON data, do
//
//     final responseSaldoVacaciones = responseSaldoVacacionesFromJson(jsonString);

import 'dart:convert';

ResponseSaldoVacaciones responseSaldoVacacionesFromJson(String str) =>
    ResponseSaldoVacaciones.fromJson(json.decode(str));

String responseSaldoVacacionesToJson(ResponseSaldoVacaciones data) =>
    json.encode(data.toJson());

class ResponseSaldoVacaciones {
  ResponseSaldoVacaciones(
      {this.empid,
      this.empleado,
      this.cargo,
      this.fechaIngreso,
      this.fecha,
      this.numdias,
      this.ant,
      this.saldo,
      this.saldoTotal,
      this.duodecima,
      this.oficina,
      this.area,
      this.diasUsados});

  int? empid;
  String? empleado;
  String? cargo;
  String? fechaIngreso;
  String? fecha;
  double? numdias;
  double? ant;
  double? saldo;
  double? saldoTotal;
  double? duodecima;
  String? oficina;
  dynamic area;
  double? diasUsados;

  factory ResponseSaldoVacaciones.fromJson(Map<String, dynamic> json) =>
      ResponseSaldoVacaciones(
          empid: json["empid"],
          empleado: json["empleado"],
          cargo: json["cargo"],
          fechaIngreso: json["fecha_ingreso"],
          fecha: json["fecha"],
          numdias: json["numdias"],
          ant: json["ant"],
          saldo: json["saldo"],
          saldoTotal: json["saldo_total"],
          duodecima: json["duodecima"].toDouble(),
          oficina: json["oficina"],
          area: json["area"],
          diasUsados: json["dias_usados"]);

  Map<String, dynamic> toJson() => {
        "empid": empid,
        "empleado": empleado,
        "cargo": cargo,
        "fecha_ingreso": fechaIngreso,
        "fecha": fecha,
        "numdias": numdias,
        "ant": ant,
        "saldo": saldo,
        "saldo_total": saldoTotal,
        "duodecima": duodecima,
        "oficina": oficina,
        "area": area,
        "dias_usados": diasUsados
      };
}
