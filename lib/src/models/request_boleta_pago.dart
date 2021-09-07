// To parse this JSON data, do
//
//     final requestBoletaPago = requestBoletaPagoFromJson(jsonString);

import 'dart:convert';

RequestBoletaPago requestBoletaPagoFromJson(String str) =>
    RequestBoletaPago.fromJson(json.decode(str));

String requestBoletaPagoToJson(RequestBoletaPago data) =>
    json.encode(data.toJson());

class RequestBoletaPago {
  RequestBoletaPago({
    this.empId,
    this.periodo,
  });

  int? empId;
  String? periodo;

  factory RequestBoletaPago.fromJson(Map<String, dynamic> json) =>
      RequestBoletaPago(
        empId: json["empID"],
        periodo: json["periodo"],
      );

  Map<String, dynamic> toJson() => {
        "empID": empId,
        "periodo": periodo,
      };
}
