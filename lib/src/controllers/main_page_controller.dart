import 'package:flutter/material.dart';
import 'package:ghmobile/src/models/cumpleaneros.dart';
import 'package:ghmobile/src/models/publicacion.dart';
import 'package:ghmobile/src/models/response_saldo_vacaciones.dart';
import 'package:ghmobile/src/pages/cumpleaneros_page.dart';
import 'package:ghmobile/src/pages/nueva_asistencia_page.dart';
import 'package:ghmobile/src/repository/home_repository.dart';
import 'package:ghmobile/src/repository/publicacion_repository.dart';
import 'package:ghmobile/src/repository/settings_repository.dart';
import 'package:ghmobile/src/repository/vacaciones_repository.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPageController extends ControllerMVC {
  String _url_intranet = 'http://intranet.lafar.net';

  double saldoDias = 0;
  late OverlayEntry loader;

  List<Cumpleaneros> cumpleaneros = [];
  List<Publicacion> publicaciones = [];

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
            this.saldoVacaciones.numdias! - this.saldoVacaciones.diasUsados!;
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

  void obtenerCumpleanerosMes(BuildContext context) async {
    final Stream<List<Cumpleaneros>> stream = await obtieneCumpleanerosDelMes();
    stream.listen((List<Cumpleaneros> _cumpleaneros) {
      setState(() {
        cumpleaneros = _cumpleaneros;
      });
    }, onError: (a) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocurrio un error al obtener los cumpleañeros!'),
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
