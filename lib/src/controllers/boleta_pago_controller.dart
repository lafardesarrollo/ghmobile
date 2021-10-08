import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ghmobile/src/helpers/helper.dart';
import 'package:ghmobile/src/models/boleta_pago.dart';
import 'package:ghmobile/src/models/request_boleta_pago.dart';
import 'package:ghmobile/src/repository/boleta_pago_repository.dart';
import 'package:ghmobile/src/repository/user_repository.dart';
import 'package:ghmobile/src/widgets/SeleccionarPeriodoWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class BoletaPagoController extends ControllerMVC {
  RequestBoletaPago requestBoleta = new RequestBoletaPago();
  BoletaPago boleta = new BoletaPago();

  String dropdownValue = 'Agosto';

  List<String> periodos = [];
  late OverlayEntry loader;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  // Descargar boleta de pago
  String progress = "-";

  BoletaPagoController() {
    // loader = Helper.overlayLoader(context);
  }

  void listarPeriodos(BuildContext context, int idEmpleado) async {
    final Stream<List<String>> stream =
        await obtenerPeriodosBoletaPagoEmpleado(idEmpleado);
    stream.listen((List<String> _periodos) {
      setState(() {
        periodos = _periodos;
        // print(periodos);
      });
    }, onError: (a) {
      // print(a);
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
        // print(boleta.toJson());
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

  void _onReceiveProgress(int received, int total) {
    if (total != -1) {
      setState(() {
        progress = (received / total * 100).toStringAsFixed(0) + "%";
      });
    }
  }

  Future<void> descargarBoletaPago(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    String fileUrl =
        "http://190.104.26.90:8082/lafarnetservice/api/boletapago/${this.requestBoleta.empId}_${this.requestBoleta.periodo}";

    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };
    try {
      var directorio = await getExternalStorageDirectory();
      String directorioDescargas = directorio!.path + "/boleta_pago.pdf";

      Response response = await Dio().download(fileUrl, directorioDescargas,
          onReceiveProgress: _onReceiveProgress);

      result['isSuccess'] = response.statusCode == 200;
      result['filePath'] = directorioDescargas;
      OpenFile.open(directorioDescargas);
    } catch (ex) {
      result['error'] = ex.toString();
    } finally {
      await _showNotification(result, flutterLocalNotificationsPlugin);
    }
  }

  Future<void> _showNotification(Map<String, dynamic> downloadStatus,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description',
        priority: Priority.high, importance: Importance.max);
    const IOSNotificationDetails iOS = IOSNotificationDetails();
    const NotificationDetails platform =
        NotificationDetails(android: android, iOS: iOS); // ( android , iOS);
    final json = jsonEncode(downloadStatus);
    final isSuccess = downloadStatus['isSuccess'];

    await flutterLocalNotificationsPlugin.show(
        0, // notification id
        isSuccess ? 'Correcto!' : 'Error',
        isSuccess
            ? 'Su boleta de pago fue descargado correctamente, puede ver directamente presionando aqui!'
            : 'A ocurrido un error mientras se descargaba el archivo.',
        platform,
        payload: json);
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
