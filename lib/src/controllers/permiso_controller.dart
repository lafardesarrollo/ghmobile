import 'package:flutter/material.dart';
import 'package:ghmobile/src/pages/nuevo_permiso_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class PermisoController extends ControllerMVC {
  String dropdownValue = 'Agosto';

  late OverlayEntry loader;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

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

  // void listenSeguimientoUsuarioFecha(String fecha) async {
  //   final Stream<List<Seguimiento>> stream =
  //       await getSeguimientoPorUsuarioFecha(fecha);
  //   stream.listen((List<Seguimiento> _lseguimiento) {
  //     setState(() {
  //       lseguimiento = _lseguimiento;
  //     });
  //   }, onError: (a) {
  //     print(a);
  //     scaffoldKey?.currentState?.showSnackBar(SnackBar(
  //       content: Text('Ocurrio un error al obtener la información'),
  //     ));
  //   }, onDone: () {});
  // }

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
