// To parse this JSON data, do
//
//     final libro = libroFromJson(jsonString);

import 'dart:convert';

import 'titulo.dart';

Libro libroFromJson(String str) => Libro.fromJson(json.decode(str));

String libroToJson(Libro data) => json.encode(data.toJson());

class Libro {
  Libro({
    this.id,
    this.nombre,
    this.descripcion,
    this.estado,
    this.titulos,
  });

  int? id;
  String? nombre;
  String? descripcion;
  int? estado;
  List<Titulo>? titulos;

  factory Libro.fromJson(Map<String, dynamic> json) => Libro(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        estado: json["estado"],
        titulos:
            List<Titulo>.from(json["titulos"].map((x) => Titulo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "estado": estado,
        "titulos": List<dynamic>.from(titulos!.map((x) => x.toJson())),
      };
}
