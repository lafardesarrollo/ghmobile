// ignore_for_file: unnecessary_statements

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class OrganigramaController extends ControllerMVC {
  bool loading = false;
  late OverlayEntry loader;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  OrganigramaController() {
    // loader = Helper.overlayLoader(context);
  }

  // void listarMarcaciones(BuildContext context, String username) async {
  //   final Stream<List<Marcacion>> stream =
  //       await obtieneMarcacionesPorUsername(username);
  //   stream.listen((List<Marcacion> _marcaciones) {
  //     setState(() {
  //       marcaciones = _marcaciones;
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

  // Future<void> abrirNuevoMarcaje(BuildContext context) async {
  //   final resultado = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => NuevaAsistenciaPage(
  //           // seguimiento: _seguimiento,
  //           ),
  //     ),
  //   );
  //   if (resultado) {
  //     listarMarcaciones(context, currentUser.value.username!);
  //   } else {
  //     //listarBoletas(context, int.parse(currentUser.value.idSap!));
  //   }
  // }

}
