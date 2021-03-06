import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:ghmobile/src/models/asistencia_calculo_general.dart';
import 'package:ghmobile/src/models/cumpleaneros.dart';
import 'package:ghmobile/src/models/periodo_gestion.dart';
import 'package:ghmobile/src/models/publicacion.dart';
import 'package:ghmobile/src/models/request_asistencia_persona.dart';
import 'package:ghmobile/src/models/response_saldo_vacaciones.dart';
import 'package:ghmobile/src/pages/cumpleaneros_page.dart';
import 'package:ghmobile/src/pages/nueva_asistencia_page.dart';
import 'package:ghmobile/src/repository/asistencia_repository.dart';
import 'package:ghmobile/src/repository/home_repository.dart';
import 'package:ghmobile/src/repository/periodo_gestion_repository.dart';
import 'package:ghmobile/src/repository/publicacion_repository.dart';
import 'package:ghmobile/src/repository/settings_repository.dart';
import 'package:ghmobile/src/repository/user_repository.dart';
import 'package:ghmobile/src/repository/vacaciones_repository.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPageController extends ControllerMVC {
  String _url_intranet = 'http://intranet.lafar.net';

  double saldoDias = 0;
  late OverlayEntry loader;

  PeriodoGestion periodo = new PeriodoGestion();

  List<Cumpleaneros> cumpleaneros = [];
  List<Publicacion> publicaciones = [];

  String dropdownValue = 'Hoy';

  // SALDO DE VACACIONES
  ResponseSaldoVacaciones saldoVacaciones = new ResponseSaldoVacaciones();
  AsistenciaCalculoGeneral atrasos = new AsistenciaCalculoGeneral();

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  MainPageController() {
    // loader = Helper.overlayLoader(context);
    // atrasos.retrasoTotal = 0;
  }

  void getLocalization() async {
    final Stream<LocationData> stream = await obtenerLocalizacionActual();
    stream.listen((LocationData _locationData) {
      print("======OK");
      print(_locationData.latitude.toString());
    }, onError: (a) {
      print("====ON ERROR");
    }, onDone: () {
      print("====ON DONE");
    });
  }

  void abrirIntranet() async => await canLaunch(_url_intranet)
      ? await launch(_url_intranet)
      : throw 'Could not launch $_url_intranet';

  void obtenerSaldoVacaciones(int idEmpleado, {String? message}) async {
    this.saldoVacaciones = new ResponseSaldoVacaciones();
    final Stream<ResponseSaldoVacaciones> stream =
        await obtenerSaldoVacacionesPorEmpleado(
            idEmpleado); //(currentUser.value.username);
    stream.listen((ResponseSaldoVacaciones _saldo) {
      setState(() {
        this.saldoVacaciones = _saldo;
        this.saldoDias =
            this.saldoVacaciones.saldo! - this.saldoVacaciones.diasUsados!;
      });
    }, onError: (a) {
      print(a);
      scaffoldKey.currentState?.showSnackBar(SnackBar(
        content: Text('Ocurrio un error al obtener la informaci??n'),
      ));
    }, onDone: () {
      if (message != null) {
        scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
        ));
      }
    });
  }

  void obtenerCumpleanerosMes(BuildContext context) async {
    final Stream<List<Cumpleaneros>> stream = await obtieneCumpleanerosDelMes();
    stream.listen((List<Cumpleaneros> _cumpleaneros) {
      setState(() {
        cumpleaneros = _cumpleaneros;
      });
    }, onError: (a) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocurrio un error al obtener los cumplea??eros!'),
          backgroundColor: Colors.blue,
        ),
      );
    }, onDone: () {});
  }

  void obtenerPublicacionesIntranet(BuildContext context) async {
    final Stream<List<Publicacion>> stream = await obtenerPublicaciones();
    stream.listen((List<Publicacion> _publicaciones) {
      setState(() {
        publicaciones = _publicaciones;
        print(publicaciones);
      });
    }, onError: (a) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocurrio un error al obtener las publicaciones!'),
          backgroundColor: Colors.blue,
        ),
      );
    }, onDone: () {});
  }

  Future<void> abrirCumpleaneros(BuildContext context) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CumpleanerosPage(),
      ),
    );
    if (resultado) {
    } else {}
  }

  Future<void> abrirNuevoMarcaje(BuildContext context) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NuevaAsistenciaPage(
            // seguimiento: _seguimiento,
            ),
      ),
    );
    if (resultado) {
    } else {
      //listarBoletas(context, int.parse(currentUser.value.idSap!));
    }
  }

  void getPeriodoActual({message = ''}) async {
    final Stream<PeriodoGestion> stream =
        await obtenerPeriodoActual(); //(currentUser.value.username);
    stream.listen((PeriodoGestion _periodo) {
      setState(() {
        this.periodo = _periodo;
        DateTime fi = DateTime(this.periodo.fechaInicio!.year,
            this.periodo.fechaInicio!.month, this.periodo.fechaInicio!.day);
        DateTime ff = DateTime(this.periodo.fechaFin!.year,
            this.periodo.fechaFin!.month, this.periodo.fechaFin!.day);

        final fechaInicio = formatDate(fi, [yyyy, '-', mm, '-', dd]);
        final fechaFin = formatDate(ff, [yyyy, '-', mm, '-', dd]);

        getAtrasosMesActual(currentUser.value.idSap!, fechaInicio, fechaFin);
        // print(jsonEncode(this.periodo));
      });
    }, onError: (a) {
      print(a);
      scaffoldKey.currentState?.showSnackBar(SnackBar(
        content: Text('Ocurrio un error al obtener el periodo actual'),
      ));
    }, onDone: () {});
  }

  // OBTENER ATRASOS ACUMULADOS DEL MES
  void getAtrasosMesActual(
      String idEmpleado, String fechaInicio, String fechaFinal) async {
    final request = new RequestAsistenciaPersona();

/*
    final int mesactual = DateTime.now().month;
    final int mesanterior = mesactual == 1 ? 12 : DateTime.now().month - 1;
    final String nuevo_mes = mesactual.toString().padLeft(2, '0');
    final String nuevo_mes_anterior = mesanterior.toString().padLeft(2, '0');

    final int anioactual = DateTime.now().year;
    final int anioanterior = mesactual == 1 ? anioactual - 1 : anioactual;
*/
    request.empleado = int.parse(idEmpleado);

    request.fechaInicio = fechaInicio;
    request.fechaFin = fechaFinal;

    final Stream<AsistenciaCalculoGeneral> stream =
        await obtieneAtrasosPorMes(request); //(currentUser.value.username);
    stream.listen((AsistenciaCalculoGeneral _saldo) {
      setState(() {
        this.atrasos = _saldo;
        // print(jsonEncode(atrasos));
      });
    }, onError: (a) {
      print(a);
      scaffoldKey.currentState?.showSnackBar(SnackBar(
        content: Text('Ocurrio un error al obtener los retrasos'),
      ));
    }, onDone: () {});
  }
}
