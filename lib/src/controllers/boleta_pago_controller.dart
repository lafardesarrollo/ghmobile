import 'package:flutter/material.dart';
import 'package:ghmobile/src/models/boleta_pago.dart';
import 'package:ghmobile/src/models/request_boleta_pago.dart';
import 'package:ghmobile/src/repository/boleta_pago_repository.dart';
import 'package:ghmobile/src/repository/settings_repository.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class BoletaPagoController extends ControllerMVC {
  RequestBoletaPago requestBoleta = new RequestBoletaPago();
  BoletaPago boleta = new BoletaPago();

  String dropdownValue = 'Agosto';

  late OverlayEntry loader;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  BoletaPagoController() {
    // loader = Helper.overlayLoader(context);
  }

  void obtenerBoletaPago({String? message}) async {
    this.boleta = new BoletaPago();
    final Stream<BoletaPago> stream =
        await obtenerBoletaPagoPorEmpleado(this.requestBoleta);
    stream.listen((BoletaPago _boleta) {
      setState(() {
        boleta = _boleta;
        print(boleta.toJson());
      });
    }, onError: (a) {
      print(a);
      scaffoldKey.currentState?.showSnackBar(SnackBar(
        content: Text('Ocurrio un error al obtener la información'),
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

  // Future<void> abrirDetalleSeguimiento(Seguimiento _seguimiento) async {
  //   final resultado = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => DetalleSeguimientoPage(
  //         seguimiento: _seguimiento,
  //       ),
  //     ),
  //   );
  //   if (resultado) {
  //   } else {

  //   }
  // }

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
