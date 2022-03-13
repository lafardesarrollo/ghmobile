// To parse this JSON data, do
//
//     final libroDetalle = libroDetalleFromJson(jsonString);

import 'dart:convert';

class LLibroDetalle {
  List<LibroDetalle> items = [];
  LLibroDetalle();
  LLibroDetalle.fromJsonList(List<dynamic> jsonList) {
    // ignore: unnecessary_null_comparison
    if (jsonList == null) return;

    for (var item in jsonList) {
      final libroDetalle = new LibroDetalle.fromJson(item);
      items.add(libroDetalle);
    }
  }
}

LibroDetalle libroDetalleFromJson(String str) =>
    LibroDetalle.fromJson(json.decode(str));

String libroDetalleToJson(LibroDetalle data) => json.encode(data.toJson());

class LibroDetalle {
  LibroDetalle({
    this.id,
    this.idLibro,
    this.correlativo,
    this.inciso,
    this.tipoTexto,
    this.texto,
    this.parent,
  });

  int? id;
  int? idLibro;
  int? correlativo;
  String? inciso;
  String? tipoTexto;
  String? texto;
  int? parent;

  factory LibroDetalle.fromJson(Map<String, dynamic> json) => LibroDetalle(
        id: json["id"],
        idLibro: json["idLibro"],
        correlativo: json["correlativo"],
        inciso: json["inciso"],
        tipoTexto: json["tipoTexto"],
        texto: json["texto"],
        parent: json["parent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idLibro": idLibro,
        "correlativo": correlativo,
        "inciso": inciso,
        "tipoTexto": tipoTexto,
        "texto": texto,
        "parent": parent,
      };
}
