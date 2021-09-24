// To parse this JSON data, do
//
//     final publicacion = publicacionFromJson(jsonString);

import 'dart:convert';

class LPublicaciones {
  List<Publicacion> items = [];
  LPublicaciones();
  LPublicaciones.fromJsonList(List<dynamic> jsonList) {
    // ignore: unnecessary_null_comparison
    if (jsonList == null) return;

    for (var item in jsonList) {
      final boleta = new Publicacion.fromJson(item);
      items.add(boleta);
    }
  }
}

Publicacion publicacionFromJson(String str) =>
    Publicacion.fromJson(json.decode(str));

String publicacionToJson(Publicacion data) => json.encode(data.toJson());

class Publicacion {
  Publicacion({
    this.id,
    this.titulo,
    this.nombreAdjunto,
    this.extension,
    this.usuarioPublicacion,
    this.idTipo,
    this.fechaPublicacion,
    this.fechaCaduca,
    this.estado,
    this.usuarioCreacion,
    this.fechaCreacion,
    this.usuarioModificacion,
    this.fechaModificacion,
  });

  String? id;
  String? titulo;
  String? nombreAdjunto;
  String? extension;
  String? usuarioPublicacion;
  String? idTipo;
  String? fechaPublicacion;
  String? fechaCaduca;
  String? estado;
  String? usuarioCreacion;
  String? fechaCreacion;
  String? usuarioModificacion;
  String? fechaModificacion;

  factory Publicacion.fromJson(Map<String, dynamic> json) => Publicacion(
        id: json["id"],
        titulo: json["titulo"],
        nombreAdjunto: json["nombreAdjunto"],
        extension: json["extension"],
        usuarioPublicacion: json["usuarioPublicacion"],
        idTipo: json["idTipo"],
        fechaPublicacion: (json["fechaPublicacion"]),
        fechaCaduca: (json["fechaCaduca"]),
        estado: json["estado"],
        usuarioCreacion: json["usuario_creacion"],
        fechaCreacion: (json["fecha_creacion"]),
        usuarioModificacion: json["usuario_modificacion"],
        fechaModificacion: (json["fecha_modificacion"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "nombreAdjunto": nombreAdjunto,
        "extension": extension,
        "usuarioPublicacion": usuarioPublicacion,
        "idTipo": idTipo,
        "fechaPublicacion": fechaPublicacion,
        "fechaCaduca": fechaCaduca,
        "estado": estado,
        "usuario_creacion": usuarioCreacion,
        "fecha_creacion": fechaCreacion,
        "usuario_modificacion": usuarioModificacion,
        "fecha_modificacion": fechaModificacion,
      };
}
