import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ghmobile/src/models/boleta_permiso.dart';
import 'package:ghmobile/src/pages/detalle_permiso_page.dart';
import 'package:ghmobile/src/pages/nuevo_permiso_page.dart';
import 'package:ghmobile/src/repository/permiso_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class PermisoController extends ControllerMVC {
  TextEditingController dateInputSalida = TextEditingController();
  TextEditingController dateInputRetorno = TextEditingController();

  TextEditingController timeInputSalida = TextEditingController();
  TextEditingController timeInputRetorno = TextEditingController();

  int index = 0;

  List<BoletaPermiso> boletas = [];
  BoletaPermiso boleta = new BoletaPermiso();

  late OverlayEntry loader;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> permisoFormKey = new GlobalKey<FormState>();

  PermisoController() {
    // loader = Helper.overlayLoader(context);
  }

  // void obtenerBoletaPago({String? message}) async {
  //   this.boleta = new BoletaPago();
  //   final Stream<BoletaPago> stream =
  //       await obtenerBoletaPagoPorEmpleado(this.requestBoleta);
  //   stream.listen((BoletaPago _boleta) {
  //     setState(() {
  //       boleta = _boleta;
  //       print(boleta.toJson());
  //     });
  //   }, onError: (a) {
  //     print(a);
  //     scaffoldKey.currentState?.showSnackBar(SnackBar(
  //       content: Text('Ocurrio un error al obtener la información'),
  //     ));
  //   }, onDone: () {
  //     if (message != null) {
  //       scaffoldKey.currentState!.showSnackBar(SnackBar(
  //         content: Text(message),
  //         backgroundColor: Colors.green,
  //       ));
  //     }
  //   });
  // }

  void listarBoletas(int idEmpleado) async {
    final Stream<List<BoletaPermiso>> stream =
        await obtenerPermisosPorEmpleado(idEmpleado);
    stream.listen((List<BoletaPermiso> _lpermisos) {
      setState(() {
        boletas = _lpermisos;
        print(boletas);
      });
    }, onError: (a) {
      print(a);
      scaffoldKey.currentState?.showSnackBar(SnackBar(
        content: Text('Ocurrio un error al obtener la información'),
      ));
    }, onDone: () {});
  }

  Future<void> abrirNuevoSolicitudPermiso(BuildContext context) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NuevoPermisoPage(
            // seguimiento: _seguimiento,
            ),
      ),
    );
    if (resultado) {
    } else {}
  }

  Future<void> abrirDetallePermiso(BuildContext context) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetallePermisoPage(
          boletaPermiso: boleta,
        ),
      ),
    );
    if (resultado) {
    } else {}
  }

  // Future<void> abrirAgregarNuevo() async {
  //   final resultado = await Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => SeguimientoPage()));
  //   if (resultado) {
  //     // this.listenSeguimientoUsuario(message: 'Se creo el nuevo registro!');
  //     this.listenSeguimientoUsuarioFecha("Hoy");
  //   } else {
  //     print('No se actualizo el sistema');
  //   }
  // }
}
