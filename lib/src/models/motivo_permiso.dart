// To parse this JSON data, do
//
//     final motivoPermiso = motivoPermisoFromJson(jsonString);

import 'dart:convert';

class LMotivoPermiso {
  List<MotivoPermiso> items = [];
  LMotivoPermiso();
  LMotivoPermiso.fromJsonList(List<dynamic> jsonList) {
    // ignore: unnecessary_null_comparison
    if (jsonList == null) return;

    for (var item in jsonList) {
      final boleta = new MotivoPermiso.fromJson(item);
      items.add(boleta);
    }
  }
}

MotivoPermiso motivoPermisoFromJson(String str) =>
    MotivoPermiso.fromJson(json.decode(str));

String motivoPermisoToJson(MotivoPermiso data) => json.encode(data.toJson());

class MotivoPermiso {
  MotivoPermiso({
    this.id,
    this.valor,
    this.motivo,
    this.aprobado,
    this.estado,
  });

  int? id;
  String? valor;
  String? motivo;
  String? aprobado;
  int? estado;

  factory MotivoPermiso.fromJson(Map<String, dynamic> json) => MotivoPermiso(
        id: json["id"],
        valor: json["valor"],
        motivo: json["motivo"],
        aprobado: json["aprobado"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "valor": valor,
        "motivo": motivo,
        "aprobado": aprobado,
        "estado": estado,
      };
}
