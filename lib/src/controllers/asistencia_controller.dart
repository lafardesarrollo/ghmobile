// ignore_for_file: unnecessary_statements

import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:ghmobile/src/helpers/helper.dart';
import 'package:ghmobile/src/models/marcacion.dart';
import 'package:ghmobile/src/models/regional.dart';
import 'package:ghmobile/src/models/regional_select.dart';
import 'package:ghmobile/src/pages/nueva_asistencia_page.dart';
import 'package:ghmobile/src/repository/asistencia_repository.dart';
import 'package:ghmobile/src/repository/regional_repository.dart';
import 'package:ghmobile/src/repository/settings_repository.dart';
import 'package:ghmobile/src/repository/user_repository.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:platform_device_id/platform_device_id.dart';

class AsistenciaController extends ControllerMVC {
  bool loading = false;

  double? latitud;
  double? longitud;

  Marcacion marcacion = new Marcacion();
  List<Marcacion> marcaciones = [];

  Regional regional = new Regional();
  List<Regional> regionales = [];

  RegionalSelect regionalSelect = new RegionalSelect();
  List<RegionalSelect> regionalesSelect = [];
  var regionalS = "";

  late OverlayEntry loader;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> permisoFormKey = new GlobalKey<FormState>();

  AsistenciaController() {
    // loader = Helper.overlayLoader(context);
  }

  void obtenerDateTime() async {
    final Stream<String> stream = await getDateTime();
    stream.listen((String _fechaActual) {
      setState(() {
        getLocalization();
        this.marcacion.fechaMarcacion = _fechaActual.replaceAll(' ', 'T');
      });
    }, onError: (a) {}, onDone: () {});
  }

  void listarMarcaciones(BuildContext context, String username) async {
    final Stream<List<Marcacion>> stream =
        await obtieneMarcacionesPorUsername(username);
    stream.listen((List<Marcacion> _marcaciones) {
      setState(() {
        marcaciones = _marcaciones;
      });
    }, onError: (a) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocurrio un error al obtener la información!'),
          backgroundColor: Colors.red,
        ),
      );
    }, onDone: () {
      loading = false;
    });
  }

  void listarRegionales(BuildContext context) async {
    final Stream<List<Regional>> stream = await obtieneRegionales();
    stream.listen((List<Regional> _regionales) {
      setState(() {
        regionales = _regionales;
        print(regionales);
      });
    }, onError: (a) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocurrio un error al obtener las regionales!'),
          backgroundColor: Colors.red,
        ),
      );
    }, onDone: () {
      loading = false;
    });
  }

  void obtenerRegionalDelUsuario(BuildContext context) async {
    final Stream<Regional> stream =
        await obtieneRegionalPorId(int.parse(currentUser.value.idRegional!));
    stream.listen((Regional _regional) {
      setState(() {
        regional = _regional;
        print(jsonEncode(regional.toJson()));
      });
    }, onError: (a) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocurrio un error al obtener la regional!'),
          backgroundColor: Colors.red,
        ),
      );
    }, onDone: () {
      loading = false;
    });
  }

  void listarRegionalSelect(BuildContext context) async {
    final Stream<List<RegionalSelect>> stream = await obtieneRegionalSelect();
    stream.listen((List<RegionalSelect> _regionales) {
      setState(() {
        regionalesSelect = _regionales;
      });
    }, onError: (a) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocurrio un error al obtener las regionales!'),
          backgroundColor: Colors.red,
        ),
      );
    }, onDone: () {
      loading = false;
    });
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
      listarMarcaciones(context, currentUser.value.username!);
    } else {
      //listarBoletas(context, int.parse(currentUser.value.idSap!));
    }
  }

  void guardarMarcacion(BuildContext context, String tipoMarcacion) async {
    loader = Helper.overlayLoader(context);
    FocusScope.of(context).unfocus();
    Overlay.of(context)!.insert(loader);

    marcacion.id = 0;
    marcacion.idGeneral = 0;
    marcacion.username = currentUser.value.username;
    marcacion.nombreEmpleado =
        currentUser.value.firstName! + ' ' + currentUser.value.lastName!;
    // marcacion.fechaMarcacion =
    // this.marcacion.latitud = latitud;
    // this.marcacion.longitud = longitud;
    marcacion.imagen = currentUser.value.foto;
    marcacion.tipoMarcacion = tipoMarcacion == 'I' ? 'Ingreso' : 'Salida';
    marcacion.estadoSync = false;
    marcacion.regional = regional.nombre;
    marcacion.macDevice = await PlatformDeviceId.getDeviceId;
    final Stream<bool> stream = await saveMarcacion(this.marcacion);
    stream.listen((bool result) {
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Se registro la marcación correctamente!'),
          backgroundColor: Colors.blue,
        ));
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No se registro la marcación, intente nuevamente.'),
          backgroundColor: Colors.red,
        ));
      }
    }, onError: (a) {
      Helper.hideLoader(loader);
      loader.remove();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Ocurrio un error al guardar la Marcación'),
        backgroundColor: Colors.red,
      ));
    }, onDone: () {
      Helper.hideLoader(loader);
      loading = false;
    });
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);

    return formatDate(dt, [HH, ':', nn, ':', ss]);
  }

  void getLocalization() async {
    final Stream<LocationData> stream = await obtenerLocalizacionActual();
    stream.listen((LocationData _locationData) {
      setState(() {
        this.latitud = _locationData.latitude;
        this.longitud = _locationData.longitude;
        this.marcacion.latitud = _locationData.latitude;
        this.marcacion.longitud = _locationData.longitude;
      });
    }, onError: (a) {
      print("====ON ERROR");
    }, onDone: () {
      print("====ON DONE");
    });
  }
}
