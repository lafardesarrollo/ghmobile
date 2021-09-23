// To parse this JSON data, do
//
//     final regional = regionalFromJson(jsonString);

import 'dart:convert';

class LRegional {
  List<Regional> items = [];
  LRegional();
  LRegional.fromJsonList(List<dynamic> jsonList) {
    // ignore: unnecessary_null_comparison
    if (jsonList == null) return;

    for (var item in jsonList) {
      final boleta = new Regional.fromJson(item);
      items.add(boleta);
    }
  }
}

Regional regionalFromJson(String str) => Regional.fromJson(json.decode(str));

String regionalToJson(Regional data) => json.encode(data.toJson());

class Regional {
  Regional({
    this.id,
    this.nombre,
    this.codigoRegional,
    this.estado,
    this.ubicacion,
    this.rango,
    this.usuarioCreacion,
    this.fechaCreacion,
    this.usuarioModificacion,
    this.fechaModificacion,
  });

  int? id;
  String? nombre;
  String? codigoRegional;
  int? estado;
  String? ubicacion;
  int? rango;
  String? usuarioCreacion;
  String? fechaCreacion;
  String? usuarioModificacion;
  String? fechaModificacion;

  factory Regional.fromJson(Map<String, dynamic> json) => Regional(
        id: json["id"],
        nombre: json["nombre"],
        codigoRegional: json["codigo_regional"],
        estado: json["estado"],
        ubicacion: json["ubicacion"],
        rango: json["rango"],
        usuarioCreacion: json["usuario_creacion"],
        fechaCreacion: (json["fecha_creacion"]),
        usuarioModificacion: json["usuario_modificacion"],
        fechaModificacion: (json["fecha_modificacion"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "codigo_regional": codigoRegional,
        "estado": estado,
        "ubicacion": ubicacion,
        "rango": rango,
        "usuario_creacion": usuarioCreacion,
        "fecha_creacion": fechaCreacion,
        "usuario_modificacion": usuarioModificacion,
        "fecha_modificacion": fechaModificacion,
      };
}
