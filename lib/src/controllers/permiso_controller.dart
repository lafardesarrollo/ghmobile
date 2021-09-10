// ignore_for_file: unnecessary_statements

import 'package:flutter/material.dart';
import 'package:ghmobile/src/helpers/helper.dart';
import 'package:ghmobile/src/models/boleta_permiso.dart';
import 'package:ghmobile/src/pages/detalle_permiso_page.dart';
import 'package:ghmobile/src/pages/nuevo_permiso_page.dart';
import 'package:ghmobile/src/repository/permiso_repository.dart';
import 'package:ghmobile/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class PermisoController extends ControllerMVC {
  bool loading = false;

  TextEditingController dateInputSalida = TextEditingController();
  TextEditingController dateInputRetorno = TextEditingController();
  TextEditingController timeInputSalida = TextEditingController();
  TextEditingController timeInputRetorno = TextEditingController();
  TextEditingController txtObservaciones = new TextEditingController();
  TextEditingController txtDetalleCompensacion = new TextEditingController();

  int index = 0;

  List<BoletaPermiso> boletas = [];
  BoletaPermiso boleta = new BoletaPermiso();

  late OverlayEntry loader;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> permisoFormKey = new GlobalKey<FormState>();

  String valor_motivo = "Seleccione un Motivo de Permiso";
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

  void listarBoletas(BuildContext context, int idEmpleado) async {
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
    }, onDone: () {
      loading = false;
    });
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

  void guardarBoletaPermiso(BuildContext context) async {
    loader = Helper.overlayLoader(context);
    FocusScope.of(context).unfocus();
    Overlay.of(context)!.insert(loader);

    boleta.idBoleta = 0;
    boleta.concepto = '';

    boleta.fechaSalida = dateInputSalida.text;
    boleta.fechaRetorno = dateInputRetorno.text;
    boleta.horaSalida = timeInputSalida.text;
    boleta.horaRetorno = timeInputRetorno.text;

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

    // print(this.boleta.toJson());

    final Stream<bool> stream = await saveBoletaPermiso(this.boleta);
    stream.listen((bool result) {
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Se guardo la Liencia correctamente!'),
          backgroundColor: Colors.blue,
        ));
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
