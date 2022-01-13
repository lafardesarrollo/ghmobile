import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghmobile/src/controllers/asistencia_controller.dart';
import 'package:ghmobile/src/repository/user_repository.dart';
import 'package:ghmobile/src/widgets/CircularLoadingWidget.dart';
import 'package:ghmobile/src/widgets/DrawerWidget.dart';
import 'package:ghmobile/src/widgets/InformacionMensajeWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AsistenciaPage extends StatefulWidget {
  const AsistenciaPage({Key? key}) : super(key: key);

  @override
  AsistenciaPageState createState() => AsistenciaPageState();
}

class AsistenciaPageState extends StateMVC<AsistenciaPage> {
  late AsistenciaController _con;

  AsistenciaPageState() : super(AsistenciaController()) {
    _con = controller as AsistenciaController;
  }

  @override
  void initState() {
    super.initState();
    _con.loading = true;
    _con.listarMarcaciones(context, currentUser.value.username!);
    // _con.listarBoletas(context, int.parse(currentUser.value.idSap!));
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
          actions: [],
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Mi Asistencia',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              _con.abrirNuevoMarcaje(context);
            },
            label: Text('Marcar Asistencia')),
        drawer: DrawerWidget(),
        body: _con.loading
            ? CircularLoadingWidget(
                texto: 'Cargando mis Marcaciones...',
                height: MediaQuery.of(context).size.height,
              )
            : RefreshIndicator(
                onRefresh: () async {
                  _con.listarMarcaciones(context, currentUser.value.username!);
                },
                child: _con.marcaciones.length == 0
                    ? InformacionMensajeWidget(
                        mensaje: 'No se encontraron marcaciones',
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: _con.marcaciones.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              // _con.boleta = _con.boletas.elementAt(index);
                              // _con.abrirDetallePermiso(context);
                            },
                            leading: CircleAvatar(
                              backgroundColor: _con.marcaciones
                                          .elementAt(index)
                                          .tipoMarcacion
                                          .toString() ==
                                      'Salida'
                                  ? Theme.of(context).accentColor
                                  : Theme.of(context).hintColor,
                              child: Text(_con.marcaciones
                                          .elementAt(index)
                                          .tipoMarcacion
                                          .toString() ==
                                      'Salida'
                                  ? 'S'
                                  : 'I'),
                            ),
                            title: Text(formatDate(
                                DateTime.parse(_con.marcaciones
                                    .elementAt(index)
                                    .fechaMarcacion!),
                                [
                                  dd,
                                  '-',
                                  M,
                                  '-',
                                  yyyy,
                                  ' ',
                                  HH,
                                  ':',
                                  nn,
                                  ':',
                                  ss
                                ])),
                            subtitle: Text(
                                'Lugar Marcaje: ' +
                                    _con.marcaciones.elementAt(index).regional!,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).hintColor)),
                            // trailing: IconButton(
                            //   onPressed: () {
                            //     // _con.boleta = _con.boletas.elementAt(index);
                            //     // _con.abrirDetallePermiso(context);
                            //   },
                            //   icon: Icon(Icons.remove_red_eye_outlined),
                            // ),
                          );
                        }),
              ),
      ),
    );
  }
}
