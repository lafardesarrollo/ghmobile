import 'package:flutter/material.dart';
import 'package:ghmobile/src/controllers/permiso_controller.dart';
import 'package:ghmobile/src/models/boleta_permiso.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:date_format/date_format.dart';

// ignore: must_be_immutable
class DetallePermisoPage extends StatefulWidget {
  BoletaPermiso? boletaPermiso;

  DetallePermisoPage({Key? key, this.boletaPermiso});

  @override
  DetallePermisoPageState createState() => DetallePermisoPageState();
}

class DetallePermisoPageState extends StateMVC<DetallePermisoPage> {
  late PermisoController _con;

  DetallePermisoPageState() : super(PermisoController()) {
    _con = controller as PermisoController;
  }

  @override
  void initState() {
    _con.boleta = widget.boletaPermiso!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Detalle Permiso',
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).hintColor,
              ),
              onPressed: () => Navigator.pop(context, false),
            ),
            actions: [
//             IconButton(
//               icon: Icon(
//                 Icons.save_outlined,
//                 color: Theme.of(context).primaryColor,
//               ),
//               onPressed: () {
// //                 _con.checkMock();
//               },
//             )
            ],
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Column(
            children: [
              Card(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        'assets/icon/profile_blue.png',
                        width: 50,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Salida por: ' +
                            _con.boleta.cuentaSalida.toString()),
                        Text(
                          'Creada el: ' +
                              formatDate(_con.boleta.fechaRegistro!,
                                  [dd, '-', mm, '-', yyyy]) +
                              ' ' +
                              _con.boleta.horaRegistro!,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tipo de Permiso',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            _con.boleta.concepto!,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Fecha de Salida',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            formatDate(_con.boleta.fechaSalida!,
                                    [dd, '-', mm, '-', yyyy]) +
                                ' ' +
                                _con.boleta.horaSalida!,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Fecha de Retorno',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            formatDate(_con.boleta.fechaRetorno!,
                                    [dd, '-', mm, '-', yyyy]) +
                                ' ' +
                                _con.boleta.horaRetorno!,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                      Divider(),
                      Text('Motivo de Salida',
                          style: Theme.of(context).textTheme.subtitle2),
                      Text(_con.boleta.motivos!,
                          style: Theme.of(context).textTheme.subtitle1)
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Autorizado por: ',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            _con.boleta.autorizador.toString(),
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Estado del Permiso',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: _con.boleta.estadoPermiso == 0
                                    ? Colors.yellow
                                    : _con.boleta.estadoPermiso == 1
                                        ? Colors.green
                                        : Colors.red,
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              _con.boleta.estadoPermiso == 0
                                  ? 'Pendiente'
                                  : _con.boleta.estadoPermiso == 1
                                      ? 'Aprobado'
                                      : 'Rechazado',
                              style: Theme.of(context).textTheme.overline,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Fecha de Autorización:',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            formatDate(_con.boleta.fechaAccionSuperior!,
                                    [dd, '-', mm, '-', yyyy]) +
                                ' ' +
                                _con.boleta.horaAccionSuperior!,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                      Divider(),
                      Text('Fecha y Hora Efectiva de Salida',
                          style: Theme.of(context).textTheme.subtitle2),
                      Text(
                          formatDate(_con.boleta.fechaEfectivaSalida!,
                                  [dd, '-', mm, '-', yyyy]) +
                              ' ' +
                              _con.boleta.horaEfectivaSalida!,
                          style: Theme.of(context).textTheme.subtitle1),
                      Text('Fecha y Hora Efectiva de Retorno',
                          style: Theme.of(context).textTheme.subtitle2),
                      Text(
                          formatDate(_con.boleta.fechaEfectivaRetorno!,
                                  [dd, '-', mm, '-', yyyy]) +
                              ' ' +
                              _con.boleta.horaEfectivaRetorno!,
                          style: Theme.of(context).textTheme.subtitle1),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
