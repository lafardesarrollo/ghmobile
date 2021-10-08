import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghmobile/src/controllers/boleta_pago_controller.dart';
import 'package:ghmobile/src/repository/user_repository.dart';
import 'package:ghmobile/src/widgets/DrawerWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

class BoletaPagoPage extends StatefulWidget {
  const BoletaPagoPage({Key? key}) : super(key: key);

  @override
  BoletaPagoPageState createState() => BoletaPagoPageState();
}

class BoletaPagoPageState extends StateMVC<BoletaPagoPage> {
  late BoletaPagoController _con;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  BoletaPagoPageState() : super(BoletaPagoController()) {
    _con = controller as BoletaPagoController;
  }
  int idEmpleado = int.parse(currentUser.value.idSap!);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: _onSelectNotification);
    _requestPermission();

    _con.requestBoleta.empId = int.parse(currentUser.value.idSap!);
    _con.requestBoleta.periodo = "202108";
    // _con.obtenerBoletaPago(context);
    _con.listarPeriodos(context, idEmpleado);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _con.scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (context) => IconButton(
              icon: FaIcon(
                FontAwesomeIcons.bars,
                color: Theme.of(context).hintColor,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          actions: [
            TextButton.icon(
              onPressed: () => _con.abrirPeriodos(context),
              icon: Icon(Icons.filter_list_alt),
              label: Text('Periodo'),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Boleta de Pago',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _con.descargarBoletaPago(flutterLocalNotificationsPlugin);
          },
          icon: FaIcon(FontAwesomeIcons.filePdf),
          label: Text('Descargar Boleta de Pago'),
        ),
        drawer: DrawerWidget(),
        body: _con.boleta.salarioBCalculado == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Seleccione un Periodo',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      'para ver sus Boletas de Pago',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton.icon(
                        icon: FaIcon(FontAwesomeIcons.fileSignature),
                        label: Text('Seleccionar Periodo'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).hintColor),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(10),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                  color: Theme.of(context).hintColor),
                            ),
                          ),
                        ),
                        onPressed: () {
                          _con.abrirPeriodos(context);
                        }),
                  ],
                ),
              )
            : ListView(
                children: [
                  Card(
                    color: Theme.of(context).hintColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Nombre: ' + _con.boleta.nombre.toString(),
                            style: Theme.of(context).textTheme.overline,
                          ),
                          Text(
                            'Sucursal: ' + _con.boleta.sucursal.toString(),
                            style: Theme.of(context).textTheme.overline,
                          ),
                          Text(
                            'Cargo: ' + _con.boleta.cargo.toString(),
                            style: Theme.of(context).textTheme.overline,
                          ),
                          Text(
                            'Fecha de Pago: ' +
                                _con.boleta.fechapago.toString(),
                            style: Theme.of(context).textTheme.overline,
                          ),
                          Text(
                            'PERIODO: ' + _con.requestBoleta.periodo.toString(),
                            style: Theme.of(context).textTheme.overline,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sueldo Bàsico:',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          _con.boleta.salarioBCalculado.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bono Antiguedad:',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          _con.boleta.bantiguedad.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bono Frontera:',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          _con.boleta.bfrontera.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bono Dominical:',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          _con.boleta.bdominical.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bono de Producción:',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          _con.boleta.bonoprod.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Horas Extras:',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          _con.boleta.hextras.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Horas Extras Dominicales:',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          _con.boleta.hextrasdom.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recargo Nocturno:',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          _con.boleta.rnocturno.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Comisiones:',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          _con.boleta.comisiones.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Otros Ingresos:',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          _con.boleta.otrosing.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'AFP PREVISION 12.71%:',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          _con.boleta.afp.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'RC-I.V.A.',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          _con.boleta.rciva.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Anticipo',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          _con.boleta.bfrontera.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Prestamos',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          _con.boleta.prestamos.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Aportes Sindicales',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          _con.boleta.aporteSSindicales.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sanciones y Multas',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          _con.boleta.sancioneSMultas.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Compras Personales',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          _con.boleta.compraSPer.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rendición de Cuentas',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          _con.boleta.rendiciones.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Refrigerio',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          _con.boleta.refrigerio.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Retenciones Judiciales',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          _con.boleta.retenciones.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Descuentos Varios',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          _con.boleta.descvarios.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Otros Descuentos',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          _con.boleta.descvarios.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Future<void> _onSelectNotification(dynamic json) async {
    final obj = jsonDecode(json);
    if (obj['isSuccess']) {
      OpenFile.open(obj['filePath']);
    } else {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('error'),
                content: Text('${obj['error']}'),
              ));
    }
    // todo: handling clicked notification
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
    // _toastInfo(info);
  }

  _toastInfo(String info) {
    Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
  }
}
