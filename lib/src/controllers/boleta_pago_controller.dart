import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ghmobile/src/helpers/helper.dart';
import 'package:ghmobile/src/models/boleta_pago.dart';
import 'package:ghmobile/src/models/request_boleta_pago.dart';
import 'package:ghmobile/src/repository/boleta_pago_repository.dart';
import 'package:ghmobile/src/repository/user_repository.dart';
import 'package:ghmobile/src/widgets/SeleccionarPeriodoWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class BoletaPagoController extends ControllerMVC {
  RequestBoletaPago requestBoleta = new RequestBoletaPago();
  BoletaPago boleta = new BoletaPago();

  String dropdownValue = 'Agosto';

  List<String> periodos = [];
  late OverlayEntry loader;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  BoletaPagoController() {
    // loader = Helper.overlayLoader(context);
  }

  void listarPeriodos(BuildContext context, int idEmpleado) async {
    final Stream<List<String>> stream =
        await obtenerPeriodosBoletaPagoEmpleado(idEmpleado);
    stream.listen((List<String> _periodos) {
      setState(() {
        periodos = _periodos;
        print(periodos);
      });
    }, onError: (a) {
      print(a);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocurrio un error al obtener la información'),
          backgroundColor: Colors.red,
        ),
      );
    }, onDone: () {});
  }

  void obtenerBoletaPago(BuildContext context, {String? message}) async {
    loader = Helper.overlayLoader(context);
    FocusScope.of(context).unfocus();
    Overlay.of(context)!.insert(loader);

    this.boleta = new BoletaPago();
    final Stream<BoletaPago> stream =
        await obtenerBoletaPagoPorEmpleado(this.requestBoleta);
    stream.listen((BoletaPago _boleta) {
      setState(() {
        boleta = _boleta;
        print(boleta.toJson());
      });
    }, onError: (a) {
      Helper.hideLoader(loader);
      loader.remove();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocurrio un error al obtener la información'),
          backgroundColor: Colors.red,
        ),
      );
    }, onDone: () {
      Helper.hideLoader(loader);
      if (message != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  Future<void> abrirPeriodos(BuildContext context) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeleccionarPeriodoWidget(
          periodos: periodos,
        ),
      ),
    );
    if (resultado.length > 0) {
      this.requestBoleta.periodo = resultado;
      this.requestBoleta.empId = int.parse(currentUser.value.idSap!);
      obtenerBoletaPago(context);
      //listarBoletas(context, int.parse(currentUser.value.idSap!));
    }
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
