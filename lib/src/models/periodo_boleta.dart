// To parse this JSON data, do
//
//     final periodoBoleta = periodoBoletaFromJson(jsonString);

import 'dart:convert';

class LPeriodos {
  List<PeriodoBoleta> items = [];
  LPeriodos();
  LPeriodos.fromJsonList(List<dynamic> jsonList) {
    // ignore: unnecessary_null_comparison
    if (jsonList == null) return;

    for (var item in jsonList) {
      final boleta = new PeriodoBoleta.fromJson(item);
      items.add(boleta);
    }
  }
}

PeriodoBoleta periodoBoletaFromJson(String str) =>
    PeriodoBoleta.fromJson(json.decode(str));

String periodoBoletaToJson(PeriodoBoleta data) => json.encode(data.toJson());

class PeriodoBoleta {
  PeriodoBoleta({
    this.periodo,
    this.mes,
    this.nombreMes,
    this.gestion,
  });

  String? periodo;
  String? mes;
  String? nombreMes;
  String? gestion;

  factory PeriodoBoleta.fromJson(Map<String, dynamic> json) => PeriodoBoleta(
        periodo: json["periodo"],
        mes: json["mes"],
        nombreMes: json["nombreMes"],
        gestion: json["gestion"],
      );

  Map<String, dynamic> toJson() => {
        "periodo": periodo,
        "mes": mes,
        "nombreMes": nombreMes,
        "gestion": gestion,
      };
}
