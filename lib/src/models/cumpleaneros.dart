// To parse this JSON data, do
//
//     final cumpleaeros = cumpleaerosFromJson(jsonString);

import 'dart:convert';

class LCumpleaneros {
  List<Cumpleaneros> items = [];
  LCumpleaneros();
  LCumpleaneros.fromJsonList(List<dynamic> jsonList) {
    // ignore: unnecessary_null_comparison
    if (jsonList == null) return;

    for (var item in jsonList) {
      final boleta = new Cumpleaneros.fromJson(item);
      items.add(boleta);
    }
  }
}

Cumpleaneros cumpleanerosFromJson(String str) =>
    Cumpleaneros.fromJson(json.decode(str));

String cumpleanerosToJson(Cumpleaneros data) => json.encode(data.toJson());

class Cumpleaneros {
  Cumpleaneros({
    this.id,
    this.idSap,
    this.nombreCompleto,
    this.fechaNacimiento,
    this.cargo,
    this.departamentoLfr,
    this.area,
    this.foto,
  });

  int? id;
  int? idSap;
  String? nombreCompleto;
  DateTime? fechaNacimiento;
  String? cargo;
  String? departamentoLfr;
  String? area;
  String? foto;

  factory Cumpleaneros.fromJson(Map<String, dynamic> json) => Cumpleaneros(
        id: json["id"],
        idSap: json["idSap"],
        nombreCompleto: json["nombreCompleto"],
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
        cargo: json["cargo"],
        departamentoLfr: json["departamentoLfr"],
        area: json["area"],
        foto: json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idSap": idSap,
        "nombreCompleto": nombreCompleto,
        "fechaNacimiento": fechaNacimiento, // .toIso8601String(),
        "cargo": cargo,
        "departamentoLfr": departamentoLfr,
        "area": area,
        "foto": foto,
      };
}
