// To parse this JSON data, do
//
//     final boletaPago = boletaPagoFromJson(jsonString);

import 'dart:convert';

BoletaPago boletaPagoFromJson(String str) =>
    BoletaPago.fromJson(json.decode(str));

String boletaPagoToJson(BoletaPago data) => json.encode(data.toJson());

class BoletaPago {
  BoletaPago({
    this.codigo,
    this.ci,
    this.nombre,
    this.cargo,
    this.posicion,
    this.departamento,
    this.fechainic,
    this.fechapago,
    this.afiliado,
    this.salariob,
    this.bantiguedad,
    this.bdominical,
    this.bfrontera,
    this.hextras,
    this.hextrasdom,
    this.rnocturno,
    this.bonoprod,
    this.comisiones,
    this.retroactivo,
    this.otrosing,
    this.toting,
    this.rciva,
    this.afp,
    this.anticipo,
    this.prestamos,
    this.aporteSSindicales,
    this.sancioneSMultas,
    this.compraSPer,
    this.rendiciones,
    this.refrigerio,
    this.retenciones,
    this.faltinv,
    this.otrosdesc,
    this.descvarios,
    this.totdesc,
    this.totpagar,
    this.saldomessig,
    this.diast,
    this.afP10,
    this.afP05,
    this.afP17,
    this.solidario,
    this.sucursal,
    this.salarioBCalculado,
  });

  String? codigo;
  String? ci;
  String? nombre;
  String? cargo;
  String? posicion;
  String? departamento;
  String? fechainic;
  String? fechapago;
  String? afiliado;
  String? salariob;
  String? bantiguedad;
  String? bdominical;
  String? bfrontera;
  String? hextras;
  String? hextrasdom;
  String? rnocturno;
  String? bonoprod;
  String? comisiones;
  String? retroactivo;
  String? otrosing;
  String? toting;
  String? rciva;
  String? afp;
  String? anticipo;
  String? prestamos;
  String? aporteSSindicales;
  String? sancioneSMultas;
  String? compraSPer;
  String? rendiciones;
  String? refrigerio;
  String? retenciones;
  String? faltinv;
  String? otrosdesc;
  String? descvarios;
  String? totdesc;
  String? totpagar;
  String? saldomessig;
  String? diast;
  String? afP10;
  String? afP05;
  String? afP17;
  String? solidario;
  String? sucursal;
  String? salarioBCalculado;

  factory BoletaPago.fromJson(Map<String, dynamic> json) => BoletaPago(
        codigo: json["codigo"],
        ci: json["ci"],
        nombre: json["nombre"],
        cargo: json["cargo"],
        posicion: json["posicion"],
        departamento: json["departamento"],
        fechainic: json["fechainic"],
        fechapago: json["fechapago"],
        afiliado: json["afiliado"],
        salariob: json["salariob"],
        bantiguedad: json["bantiguedad"],
        bdominical: json["bdominical"],
        bfrontera: json["bfrontera"],
        hextras: json["hextras"],
        hextrasdom: json["hextrasdom"],
        rnocturno: json["rnocturno"],
        bonoprod: json["bonoprod"],
        comisiones: json["comisiones"],
        retroactivo: json["retroactivo"],
        otrosing: json["otrosing"],
        toting: json["toting"],
        rciva: json["rciva"],
        afp: json["afp"],
        anticipo: json["anticipo"],
        prestamos: json["prestamos"],
        aporteSSindicales: json["aporteS_SINDICALES"],
        sancioneSMultas: json["sancioneS_MULTAS"],
        compraSPer: json["compraS_PER"],
        rendiciones: json["rendiciones"],
        refrigerio: json["refrigerio"],
        retenciones: json["retenciones"],
        faltinv: json["faltinv"],
        otrosdesc: json["otrosdesc"],
        descvarios: json["descvarios"],
        totdesc: json["totdesc"],
        totpagar: json["totpagar"],
        saldomessig: json["saldomessig"],
        diast: json["diast"],
        afP10: json["afP10"],
        afP05: json["afP05"],
        afP17: json["afP17"],
        solidario: json["solidario"],
        sucursal: json["sucursal"],
        salarioBCalculado: json["salarioB_CALCULADO"],
      );

  Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "ci": ci,
        "nombre": nombre,
        "cargo": cargo,
        "posicion": posicion,
        "departamento": departamento,
        "fechainic": fechainic,
        "fechapago": fechapago,
        "afiliado": afiliado,
        "salariob": salariob,
        "bantiguedad": bantiguedad,
        "bdominical": bdominical,
        "bfrontera": bfrontera,
        "hextras": hextras,
        "hextrasdom": hextrasdom,
        "rnocturno": rnocturno,
        "bonoprod": bonoprod,
        "comisiones": comisiones,
        "retroactivo": retroactivo,
        "otrosing": otrosing,
        "toting": toting,
        "rciva": rciva,
        "afp": afp,
        "anticipo": anticipo,
        "prestamos": prestamos,
        "aporteS_SINDICALES": aporteSSindicales,
        "sancioneS_MULTAS": sancioneSMultas,
        "compraS_PER": compraSPer,
        "rendiciones": rendiciones,
        "refrigerio": refrigerio,
        "retenciones": retenciones,
        "faltinv": faltinv,
        "otrosdesc": otrosdesc,
        "descvarios": descvarios,
        "totdesc": totdesc,
        "totpagar": totpagar,
        "saldomessig": saldomessig,
        "diast": diast,
        "afP10": afP10,
        "afP05": afP05,
        "afP17": afP17,
        "solidario": solidario,
        "sucursal": sucursal,
        "salarioB_CALCULADO": salarioBCalculado,
      };
}
