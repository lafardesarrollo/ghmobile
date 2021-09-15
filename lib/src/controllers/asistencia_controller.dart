// ignore_for_file: unnecessary_statements

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:ghmobile/src/pages/nueva_asistencia_page.dart';
import 'package:ghmobile/src/pages/nuevo_permiso_page.dart';
import 'package:ghmobile/src/repository/settings_repository.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AsistenciaController extends ControllerMVC {
  bool loading = false;

  double? latitud;
  double? longitud;

  late OverlayEntry loader;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> permisoFormKey = new GlobalKey<FormState>();

  AsistenciaController() {
    // loader = Helper.overlayLoader(context);
  }

  // void listarBoletas(BuildContext context, int idEmpleado) async {
  //   final Stream<List<BoletaPermiso>> stream =
  //       await obtenerPermisosPorEmpleado(idEmpleado);
  //   stream.listen((List<BoletaPermiso> _lpermisos) {
  //     setState(() {
  //       boletas = _lpermisos;
  //       print(boletas);
  //     });
  //   }, onError: (a) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Ocurrio un error al obtener la información!'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }, onDone: () {
  //     loading = false;
  //   });
  // }

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
      print('Return TRUEEEEEEEEEEEEEEE');
      //listarBoletas(context, int.parse(currentUser.value.idSap!));
    } else {
      //listarBoletas(context, int.parse(currentUser.value.idSap!));
    }
  }

  /*void guardarBoletaPermiso(BuildContext context) async {
    loader = Helper.overlayLoader(context);
    FocusScope.of(context).unfocus();
    Overlay.of(context)!.insert(loader);

    boleta.idBoleta = 0;
    boleta.concepto = '';

    boleta.fechaSalida = dateInputSalida.text;
    boleta.fechaRetorno = dateInputRetorno.text;
    boleta.horaSalida = timeInputSalida.text;
    boleta.horaRetorno = timeInputRetorno.text;

    boleta.motivos = txtObservaciones.text;

    boleta.userid = int.parse(currentUser.value.idSap!);
    boleta.fechaRegistro = '0001-01-01';
    boleta.horaRegistro = '';
    boleta.diaEntero = 0.0;
    boleta.fechaEfectivaRetorno = '0001-01-01';
    boleta.horaEfectivaRetorno = '';
    boleta.mitadJornada = 0.0;
    boleta.idSuperior = 0;
    boleta.autorizador = '';
    boleta.estadoPermiso = 0;
    boleta.fechaAccionSuperior = '0001-01-01';
    boleta.horaAccionSuperior = '';
    boleta.motivoRechazo = '';
    boleta.detalleCompensacion = txtDetalleCompensacion.text;
    boleta.fechaEfectivaSalida = '0001-01-01';
    boleta.horaEfectivaSalida = '';
    boleta.latLngSalida = "0";
    boleta.latLngRetorno = "0";

    // print(this.boleta.toJson());

    final Stream<bool> stream = await saveBoletaPermiso(this.boleta);
    stream.listen((bool result) {
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Se guardo la Liencia correctamente!'),
          backgroundColor: Colors.blue,
        ));
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No se guardo la licencia, intente nuevamente.'),
          backgroundColor: Colors.red,
        ));
      }
    }, onError: (a) {
      Helper.hideLoader(loader);
      loader.remove();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Ocurrio un error al guardar la Licencia de Permiso'),
        backgroundColor: Colors.red,
      ));
      // scaffoldKey.currentState?.showSnackBar(SnackBar(
      //   content: Text('Ocurrio un error al obtener la información'),
      // ));
    }, onDone: () {
      Helper.hideLoader(loader);
      loading = false;
    });
  }*/

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
      });
    }, onError: (a) {
      print("====ON ERROR");
    }, onDone: () {
      print("====ON DONE");
    });
  }
}
