import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghmobile/src/controllers/asistencia_controller.dart';
import 'package:ghmobile/src/helpers/app_config.dart';
import 'package:ghmobile/src/models/marcacion.dart';
import 'package:ghmobile/src/models/regional.dart';
import 'package:ghmobile/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class NuevaAsistenciaPage extends StatefulWidget {
  NuevaAsistenciaPage({Key? key});

  @override
  NuevaAsistenciaPageState createState() => NuevaAsistenciaPageState();
}

class NuevaAsistenciaPageState extends StateMVC<NuevaAsistenciaPage> {
  late AsistenciaController _con;

  NuevaAsistenciaPageState() : super(AsistenciaController()) {
    _con = controller as AsistenciaController;
  }

  @override
  void initState() {
    _con.obtenerDateTime();
    _con.obtenerRegionalDelUsuario(context);
    _con.listarRegionales(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Realizar Marcación',
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
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Card(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Empleado: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            currentUser.value.firstName! +
                                ' ' +
                                currentUser.value.lastName!,
                            // _con.seguimiento.nombreCompleto,
                            style: TextStyle(
                                fontWeight: FontWeight.w100, fontSize: 16),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Regional: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            currentUser.value.area!,
                            // _con.seguimiento.nombreCompleto,
                            style: TextStyle(
                                fontWeight: FontWeight.w100, fontSize: 16),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Fecha y Hora: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            _con.marcacion.fechaMarcacion.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w100, fontSize: 16),
                          )
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Text(_con.seguimiento.latitud),
                      //     Text(_con.seguimiento.longitud)
                      //   ],
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Lugar de Marcaje: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            _con.regional.nombre ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.w100, fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      OutlinedButton.icon(
                        icon: Icon(Icons.track_changes),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          fixedSize: Size(App(context).appWidth(100), 50),
                          primary: Theme.of(context).hintColor,
                        ),
                        onPressed: () => bottomSheetRegionales(),
                        label: Text('CAMBIAR LUGAR DE MARCAJE'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          fixedSize: Size(App(context).appWidth(100), 50),
                          primary: Theme.of(context).hintColor,
                        ),
                        onPressed: () {
                          _con.getLocalization();
                        },
                        icon: Icon(Icons.refresh),
                        label: Text('ACTUALIZAR UBICACIÓN'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Ubicación',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          MaterialButton(
                            child: _con.marcacion.latitud != null
                                ? Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.red),
                                  ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      // Text('Latitud: ${_con.latitud}  Longitud: ${_con.longitud}')
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  fixedSize: Size(App(context).appWidth(100), 70),
                  primary: Theme.of(context).hintColor,
                ),
                onPressed: () {
                  _con.guardarMarcacion(context, 'I');
                },
                icon: FaIcon(FontAwesomeIcons.fingerprint),
                label: Text('MARCAR INGRESO'),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  fixedSize: Size(App(context).appWidth(100), 70),
                  primary: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  _con.guardarMarcacion(context, 'S');
                },
                icon: FaIcon(FontAwesomeIcons.fingerprint),
                label: Text('MARCAR SALIDA'),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // _con.guardarVacaciones(context);
          },
          label: Text('Ver Ubicación'),
          icon: FaIcon(FontAwesomeIcons.map),
        ),
      ),
    );
  }

  bottomSheetRegionales() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.separated(
            itemCount: _con.regionales.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _con.regional = _con.regionales.elementAt(index);
                    Navigator.pop(context);
                  });
                },
                child: ListTile(
                  title: Text(_con.regionales.elementAt(index).nombre!),
                ),
              );
            });
      },
    );
  }
}
