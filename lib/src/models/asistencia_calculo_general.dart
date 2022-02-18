// To parse this JSON data, do
//
//     final asistenciaCalculoGeneral = asistenciaCalculoGeneralFromJson(jsonString);

import 'dart:convert';

AsistenciaCalculoGeneral asistenciaCalculoGeneralFromJson(String str) =>
    AsistenciaCalculoGeneral.fromJson(json.decode(str));

String asistenciaCalculoGeneralToJson(AsistenciaCalculoGeneral data) =>
    json.encode(data.toJson());

class AsistenciaCalculoGeneral {
  AsistenciaCalculoGeneral({
    this.idSap,
    this.ci,
    this.nombreCompleto,
    this.retrasoTotal,
  });

  int? idSap;
  String? ci;
  String? nombreCompleto;
  double? retrasoTotal;

  factory AsistenciaCalculoGeneral.fromJson(Map<String, dynamic> json) =>
      AsistenciaCalculoGeneral(
        idSap: json["idSap"],
        ci: json["ci"],
        nombreCompleto: json["nombreCompleto"],
        retrasoTotal: json["retrasoTotal"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "idSap": idSap,
        "ci": ci,
        "nombreCompleto": nombreCompleto,
        "retrasoTotal": retrasoTotal,
      };
}
