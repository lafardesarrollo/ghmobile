// To parse this JSON data, do
//
//     final boletaPermiso = boletaPermisoFromJson(jsonString);

import 'dart:convert';

import 'package:ghmobile/src/models/user.dart';
import 'package:ghmobile/src/models/usuario.dart';
import 'package:ghmobile/src/models/usuario_lafarnet.dart';

class LBoletaPermiso {
  List<BoletaPermiso> items = [];
  LBoletaPermiso();
  LBoletaPermiso.fromJsonList(List<dynamic> jsonList) {
    // ignore: unnecessary_null_comparison
    if (jsonList == null) return;

    for (var item in jsonList) {
      final boleta = new BoletaPermiso.fromJson(item);
      items.add(boleta);
    }
  }
}

BoletaPermiso boletaPermisoFromJson(String str) =>
    BoletaPermiso.fromJson(json.decode(str));

String boletaPermisoToJson(BoletaPermiso data) => json.encode(data.toJson());

class BoletaPermiso {
  BoletaPermiso(
      {this.idBoleta,
      this.concepto,
      this.userid,
      this.usuario,
      this.fechaRegistro,
      this.horaRegistro,
      this.fechaSalida,
      this.horaSalida,
      this.diaEntero,
      this.fechaRetorno,
      this.horaRetorno,
      this.fechaEfectivaRetorno,
      this.horaEfectivaRetorno,
      this.mitadJornada,
      this.motivos,
      this.cuentaSalida,
      this.idSuperior,
      this.autorizador,
      this.estadoPermiso,
      this.fechaAccionSuperior,
      this.horaAccionSuperior,
      this.motivoRechazo,
      this.detalleCompensacion,
      this.fechaEfectivaSalida,
      this.horaEfectivaSalida,
      this.latLngSalida,
      this.latLngRetorno,
      this.aut});

  int? idBoleta;
  String? concepto;
  int? userid;
  UsuarioLafarnet? usuario = new UsuarioLafarnet();
  String? fechaRegistro;
  String? horaRegistro;
  String? fechaSalida;
  String? horaSalida;
  double? diaEntero;
  String? fechaRetorno;
  String? horaRetorno;
  String? fechaEfectivaRetorno;
  String? horaEfectivaRetorno;
  double? mitadJornada;
  String? motivos;
  String? cuentaSalida;
  int? idSuperior;
  String? autorizador;
  int? estadoPermiso;
  String? fechaAccionSuperior;
  String? horaAccionSuperior;
  String? motivoRechazo;
  String? detalleCompensacion;
  String? fechaEfectivaSalida;
  String? horaEfectivaSalida;
  String? latLngSalida;
  String? latLngRetorno;
  User? aut = new User();

  factory BoletaPermiso.fromJson(Map<String, dynamic> json) => BoletaPermiso(
        idBoleta: json["id_boleta"],
        concepto: json["concepto"],
        userid: json["userid"],
        usuario: json["usuario"] != null
            ? UsuarioLafarnet.fromJson(json["usuario"])
            : new UsuarioLafarnet(),
        fechaRegistro: json["fecha_registro"],
        horaRegistro: json["hora_registro"],
        fechaSalida: json["fecha_salida"],
        horaSalida: json["hora_salida"],
        diaEntero: json["dia_entero"].toDouble(),
        fechaRetorno: json["fecha_retorno"],
        horaRetorno: json["hora_retorno"],
        fechaEfectivaRetorno: json["fecha_efectiva_retorno"],
        horaEfectivaRetorno: json["hora_efectiva_retorno"],
        mitadJornada: json["mitad_jornada"].toDouble(),
        motivos: json["motivos"],
        cuentaSalida: json["cuenta_salida"],
        idSuperior: json["id_superior"],
        autorizador: json["autorizador"],
        estadoPermiso: json["estado_permiso"],
        fechaAccionSuperior: json["fecha_accion_superior"],
        horaAccionSuperior: json["hora_accion_superior"],
        motivoRechazo: json["motivo_rechazo"],
        detalleCompensacion: json["detalle_compensacion"],
        fechaEfectivaSalida: json["fecha_efectiva_salida"],
        horaEfectivaSalida: json["hora_efectiva_salida"],
        latLngSalida: json["lat_lng_salida"],
        latLngRetorno: json["lat_lng_retorno"],
        aut: json["aut"] != null ? User.fromJson(json["aut"]) : new User(),
      );

  Map<String, dynamic> toJson() => {
        "id_boleta": idBoleta,
        "concepto": concepto,
        "userid": userid,
        "usuario": usuario,
        "fecha_registro": fechaRegistro,
        "hora_registro": horaRegistro,
        "fecha_salida": fechaSalida,
        "hora_salida": horaSalida,
        "dia_entero": diaEntero,
        "fecha_retorno": fechaRetorno,
        "hora_retorno": horaRetorno,
        "fecha_efectiva_retorno": fechaEfectivaRetorno,
        "hora_efectiva_retorno": horaEfectivaRetorno,
        "mitad_jornada": mitadJornada,
        "motivos": motivos,
        "cuenta_salida": cuentaSalida,
        "id_superior": idSuperior,
        "autorizador": autorizador,
        "estado_permiso": estadoPermiso,
        "fecha_accion_superior": fechaAccionSuperior,
        "hora_accion_superior": horaAccionSuperior,
        "motivo_rechazo": motivoRechazo,
        "detalle_compensacion": detalleCompensacion,
        "fecha_efectiva_salida": fechaEfectivaSalida,
        "hora_efectiva_salida": horaEfectivaSalida,
        "lat_lng_salida": latLngSalida,
        "lat_lng_retorno": latLngRetorno
      };
}
