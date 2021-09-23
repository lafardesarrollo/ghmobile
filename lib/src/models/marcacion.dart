// To parse this JSON data, do
//
//     final marcacion = marcacionFromJson(jsonString);

import 'dart:convert';

class LMarcaciones {
  List<Marcacion> items = [];
  LMarcaciones();
  LMarcaciones.fromJsonList(List<dynamic> jsonList) {
    // ignore: unnecessary_null_comparison
    if (jsonList == null) return;

    for (var item in jsonList) {
      final boleta = new Marcacion.fromJson(item);
      items.add(boleta);
    }
  }
}

Marcacion marcacionFromJson(String str) => Marcacion.fromJson(json.decode(str));

String marcacionToJson(Marcacion data) => json.encode(data.toJson());

class Marcacion {
  Marcacion({
    this.idGeneral,
    this.id,
    this.username,
    this.nombreEmpleado,
    this.fechaMarcacion,
    this.latitud,
    this.longitud,
    this.imagen,
    this.tipoMarcacion,
    this.estadoSync,
    this.regional,
    this.macDevice,
  });

  int? idGeneral;
  int? id;
  String? username;
  String? nombreEmpleado;
  String? fechaMarcacion;
  double? latitud;
  double? longitud;
  String? imagen;
  String? tipoMarcacion;
  bool? estadoSync;
  String? regional;
  String? macDevice;

  factory Marcacion.fromJson(Map<String, dynamic> json) => Marcacion(
        idGeneral: json["idGeneral"],
        id: json["id"],
        username: json["username"],
        nombreEmpleado: json["nombreEmpleado"],
        fechaMarcacion: (json["fechaMarcacion"]),
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
        imagen: json["imagen"],
        tipoMarcacion: json["tipoMarcacion"],
        estadoSync: json["estadoSync"],
        regional: json["regional"],
        macDevice: json["mac_device"],
      );

  Map<String, dynamic> toJson() => {
        "idGeneral": idGeneral,
        "id": id,
        "username": username,
        "nombreEmpleado": nombreEmpleado,
        "fechaMarcacion": fechaMarcacion,
        "latitud": latitud,
        "longitud": longitud,
        "imagen": imagen,
        "tipoMarcacion": tipoMarcacion,
        "estadoSync": estadoSync,
        "regional": regional,
        "mac_device": macDevice,
      };
}
