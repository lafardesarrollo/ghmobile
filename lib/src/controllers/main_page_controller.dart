import 'package:flutter/material.dart';
import 'package:ghmobile/src/models/response_saldo_vacaciones.dart';
import 'package:ghmobile/src/repository/settings_repository.dart';
import 'package:ghmobile/src/repository/user_repository.dart';
import 'package:ghmobile/src/repository/vacaciones_repository.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class MainPageController extends ControllerMVC {
  late OverlayEntry loader;

  String dropdownValue = 'Hoy';

  // SALDO DE VACACIONES
  ResponseSaldoVacaciones saldoVacaciones = new ResponseSaldoVacaciones();

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  MainPageController() {
    // loader = Helper.overlayLoader(context);
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

  void obtenerSaldoVacaciones(int idEmpleado, {String? message}) async {
    this.saldoVacaciones = new ResponseSaldoVacaciones();
    final Stream<ResponseSaldoVacaciones> stream =
        await obtenerSaldoVacacionesPorEmpleado(
            idEmpleado); //(currentUser.value.username);
    stream.listen((ResponseSaldoVacaciones _saldo) {
      setState(() {
        this.saldoVacaciones = _saldo;
        print(saldoVacaciones.toJson());
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

  // void listenSeguimientoUsuario({String message}) async {
  //   final Stream<List<Seguimiento>> stream = await getSeguimientoPorUsuario();
  //   stream.listen((List<Seguimiento> _lseguimiento) {
  //     setState(() {
  //       lseguimiento = _lseguimiento;
  //     });
  //   }, onError: (a) {
  //     print(a);
  //     scaffoldKey?.currentState?.showSnackBar(SnackBar(
  //       content: Text('Ocurrio un error al obtener la información'),
  //     ));
  //   }, onDone: () {
  //     if (message != null) {
  //       scaffoldKey.currentState.showSnackBar(SnackBar(
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
